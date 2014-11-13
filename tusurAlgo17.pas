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
		Node : PNode; {Ссылка на первую вершину с которой есть ребро}
	end;

begin
	writeln('Done!');
	readln();
end.