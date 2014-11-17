Program lr7;
type
	PNode = ^Node; {Соединенная вершина}
	Node = record
		Data : integer; {Номер вершины}
		Next : PNode; {Ссылка на след соединенную вершину}
	end;
	PDot = ^Dot; {Вершина}
	Dot = record
		Data : integer; {Номер вершины}
		Next : PDot; {Следующая вершина}
		Prev : PDot; {Предыдущая вершина}
		Node : PNode; {Вершины с которыми есть ребра}
                FirstNode : PNode; {Ссылка на первую вершину с которой есть ребро}
	end;
var
  Dots, First : PDot;

procedure addGraf;
var
     Temp : PDot;
begin
     new(Dots);

     First := Dots;
     Dots^.Data := 1;
     Dots^.Prev := nil;
     new(Dots^.Node);
     Dots^.Node^.Data := 2;
     Dots^.FirstNode := Dots^.Node;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 3;
     Dots^.Node^.Next := nil;

     new(Dots^.Next);
     Temp := Dots;
     Dots := Dots^.Next;
     Dots^.Data := 2;
     Dots^.Prev := Temp;
     new(Dots^.Node);
     Dots^.Node^.Data := 1;
     Dots^.FirstNode := Dots^.Node;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 3;
     Dots^.Node^.Next := nil;

     new(Dots^.Next);
     Temp := Dots;
     Dots := Dots^.Next;
     Dots^.Data := 3;
     Dots^.Prev := Temp;
     new(Dots^.Node);
     Dots^.Node^.Data := 1;
     Dots^.FirstNode := Dots^.Node;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 2;
     Dots^.Node^.Next := nil;
     Dots^.Next := nil;
end;
procedure errorEiler(var errorCode : integer);
begin
     if errorCode = 1 then begin
          writeln('Error: Dot not found');
     end else if errorCode = 2 then begin
          writeln('Error: Nodes not found. Bugged graf?');
     end;
end;
procedure getNode;
var
     Node, Temp : PNode;
     errorCode : integer;
begin
     errorCode := 2;
     Node := Dots^.FirstNode;
     while Node^.Next <> NIL do
     begin
          if Node^.Next^.Next = NIL then Temp := Node;
          Node := Node^.Next;
     end;
     write(Node^.Data, ' ');
     Temp^.Next := nil;
     if Temp = Dots^.FirstNode then
     begin
          if Dots^.FirstNode^.Next <> NIL then
          begin
               Dots^.FirstNode^.Next := nil;
               findDot(Dots^.FirstNode^.Data);
          end else begin
               if Dots = First then begin
                    writeln();
                    writeln('End');
               end else begin
                    errorEiler(errorCode);
               end;
          end;
     end else begin
          findDot(Temp^.Data);
     end;
end;
procedure findDot(var s : integer);
var
     found : boolean;
     errorCode : integer;
begin
     errorCode := 1;
     Dots := First;
     while Dots <> NIL do
     begin
          found := false;
          if Dots^.Data = s then
          begin
               found := true;
               break;
          end;
          Dots := Dots^.Next;
     end;
     if found = true then
     begin
          getNode();
     end else begin
          errorEiler(errorCode);
     end;
end;
procedure findEiler;
var start : integer;
begin
     start := 1;
     findDot(start);
end;
begin
     addGraf();
     findEiler();
     writeln('Done!');
     readln();
end.
