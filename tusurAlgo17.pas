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
     Dots^.Next := nil;
end;
procedure findEiler;
begin
     writeln(First^.Data);
     writeln(First^.Node^.Data);
     writeln(Dots^.Data);
     writeln('find');
end;
begin
     addGraf();
     findEiler();
     writeln('Done!');
     readln();
end.
