Program lr7;
type
	PNode = ^Node; {Соединенная вершина}
	Node = record
		Data : integer; {Номер вершины}
                First : boolean; {Флаг первой вершины}
		Next : PNode; {Ссылка на след соединенную вершину}
	end;
	PDot = ^Dot; {Вершина}
	Dot = record
		Data : integer; {Номер вершины}
		Next : PDot; {Следующая вершина}
		Prev : PDot; {Предыдущая вершина}
		Node : PNode; {Вершины с которыми есть ребра}
                FirstNode : PNode; {Ссылка на первую вершину с которой есть ребро}
                NoNodes : boolean;
	end;
var
  Dots, First : PDot;

procedure printStatus;
begin
   Dots := First;
   writeln('#Current snapshot#');
   while Dots <> NIL do
      begin
	 writeln('Dot: ', Dots^.Data);
	 Dots^.Node := Dots^.FirstNode;
	 while Dots^.Node <> NIL do
	    begin
	       writeln('Node: ', Dots^.Node^.Data);
	       Dots^.Node := Dots^.Node^.Next;
	    end;
	 Dots := Dots^.Next;
	 writeln();
      end;
   writeln('#End snapshot#');
end;
procedure addGraf;
var
     Temp : PDot;
begin
     new(Dots);

     First := Dots;
     Dots^.Data := 1;
     Dots^.Prev := nil;
     Dots^.NoNodes := False;
     new(Dots^.Node);
     Dots^.Node^.Data := 2;
     Dots^.FirstNode := Dots^.Node;
     Dots^.Node^.First := true;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 3;
     Dots^.Node^.First := false;
     Dots^.Node^.Next := nil;

     new(Dots^.Next);
     Temp := Dots;
     Dots := Dots^.Next;
     Dots^.Data := 2;
     Dots^.Prev := Temp;
     Dots^.NoNodes := False;
     new(Dots^.Node);
     Dots^.Node^.Data := 1;
     Dots^.FirstNode := Dots^.Node;
     Dots^.Node^.First := true;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 3;
     Dots^.Node^.First := false;
     Dots^.Node^.Next := nil;

     new(Dots^.Next);
     Temp := Dots;
     Dots := Dots^.Next;
     Dots^.Data := 3;
     Dots^.Prev := Temp;
     Dots^.NoNodes := False;
     new(Dots^.Node);
     Dots^.Node^.Data := 1;
     Dots^.FirstNode := Dots^.Node;
     Dots^.Node^.First := true;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 2;
     Dots^.Node^.First := false;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 4;
     Dots^.Node^.First := false;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 5;
     Dots^.Node^.First := false;
     Dots^.Node^.Next := nil;

     new(Dots^.Next);
     Temp := Dots;
     Dots := Dots^.Next;
     Dots^.Data := 4;
     Dots^.Prev := Temp;
     Dots^.NoNodes := False;
     new(Dots^.Node);
     Dots^.Node^.Data := 3;
     Dots^.FirstNode := Dots^.Node;
     Dots^.Node^.First := true;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 5;
     Dots^.Node^.First := false;
     Dots^.Node^.Next := nil;

     new(Dots^.Next);
     Temp := Dots;
     Dots := Dots^.Next;
     Dots^.Data := 5;
     Dots^.Prev := Temp;
     Dots^.NoNodes := False;
     new(Dots^.Node);
     Dots^.Node^.Data := 3;
     Dots^.FirstNode := Dots^.Node;
     Dots^.Node^.First := true;
     new(Dots^.Node^.Next);
     Dots^.Node := Dots^.Node^.Next;
     Dots^.Node^.Data := 4;
     Dots^.Node^.First := false;
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
function removeNode(var r : integer) : boolean;
var
     Node, Temp : PNode;
     errorCode : integer;
begin
     errorCode := 2;
     removeNode := false; {Флаг удаления}
     Node := Dots^.FirstNode; {Обходим список с начала}
     Temp := Node;
     if r <> 0 then {0 - только если мы еще не вышли из первой вершины}
     begin
        while Node <> NIL do
        begin
             if Node^.Data = r then
             begin
                  if Node^.First = true then
                  begin
                     if Node^.Next = NIL then
                     begin
                        Dots^.NoNodes := true;
                     end else begin
                        Node^.Next^.First := true;
                        Dots^.FirstNode := Node^.Next;
                     end;
                  end else begin
                      Temp^.Next := Node^.Next;
                  end;
                  removeNode := true;
                  break;
             end else begin
                 Temp := Node;
                 Node := Node^.Next;
             end;
        end;
        if removeNode = false then
        begin
             errorEiler(errorCode);
        end;
     end else begin
         removeNode := true;
     end;
end;
function getNode : integer;
var
     Node, Temp : PNode;
     errorCode : integer;
begin
     errorCode := 2;
     Node := Dots^.FirstNode;
     Temp := Node;
     if Dots^.NoNodes <> true then
     begin
          while Node^.Next <> NIL do
          begin
               if Node^.Next^.Next = NIL then Temp := Node;
               Node := Node^.Next;
          end;
          writeln(Node^.Data);
          Temp^.Next := nil;
          if Node^.First = true then
          begin
               Dots^.NoNodes := true;
	       if Dots^.Data = First^.Data then begin
                  writeln('End');
                  getNode := 0;
	       end else begin
                   getNode := Node^.Data;
	       end;
          end else begin
              getNode := Node^.Data;
          end;
     end else begin
         errorEiler(errorCode);
         getNode := -1;
     end;
end;
function findDot(var s : integer) : boolean;
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
          findDot := true;
     end else begin
          errorEiler(errorCode);
          findDot := false;
     end;
end;
procedure findEiler;
var
     dot, remove : integer;
     nodeStatus, removeStatus : boolean;
begin
     dot := 1;
     remove := 0;
     writeln('1');
     while dot <> 0 do
     begin
          nodeStatus := findDot(dot);
          if nodeStatus <> true then break;
          writeln('dot: ', Dots^.Data, ' remove: ', remove);
	  removeStatus := removeNode(remove);
          if removeStatus <> true then break;
          remove := dot;
          dot := getNode();
          printStatus();
          if dot = -1 then break;
     end;
end;
begin
     addGraf();
     findEiler();
     writeln('Done!');
     readln();
end.
