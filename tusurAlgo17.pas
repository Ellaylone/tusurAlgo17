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
procedure addTestGraf;{Создание тестового графа с 5ю вершинами}
var
     Temp : PDot;
begin
     new(Dots);

     First := Dots;{Ссылка на первую вершину в списке}
     Dots^.Data := 1;{Номер вершины}
     Dots^.Prev := nil;{Предыдущая вершина}
     Dots^.NoNodes := False;{Флаг наличия у вершины ребер}
     new(Dots^.Node);{Создание связных вершин}
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
procedure errorEiler(var errorCode : integer);{Обработка ошибок, вывод сообщения}
begin
     if errorCode = 1 then begin{В списке не найдена вершина}
          writeln('Error: Dot not found');
     end else if errorCode = 2 then begin{У вершины не найдено ожидаемой связной вершины}
          writeln('Error: Nodes not found. Bugged graf?');
     end;
end;
function removeNode(var r : integer) : boolean;{Удаление связной вершины}
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
        while Node <> NIL do {Пока есть связные вершины}
        begin
             if Node^.Data = r then {Если связная вершина совпадает с искомой}
             begin
                  if Node^.First = true then {Если первая}
                  begin
                     if Node^.Next = NIL then {Если после нее нет связных вершин в списке}
                     begin
                        Dots^.NoNodes := true; {Значит у вершины больше нет связных}
                     end else begin
                        Node^.Next^.First := true; {Отмечаем следующую связную как первую}
                        Dots^.FirstNode := Node^.Next;
                     end;
                  end else begin
                      Temp^.Next := Node^.Next; {Удаляем искомую вершину}
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
function getNode : integer; {Получение последней связной вершины в списке}
var
     Node, Last, PreLast : PNode;
     errorCode : integer;
begin
     errorCode := 2;
     Node := Dots^.FirstNode; {Обходим связные вершины с первой}
     PreLast := Node; {Предпоследняя связная вершина}
     Last := Node; {Последняя связная вершина}
     write(Dots^.Data, ' '); {Вывод вершины входящей в эйлеров цикл}
     if Dots^.NoNodes <> true then {Если у вершины есть связные}
     begin
          while Node <> NIL do begin {Пока есть связные}
             Last := Node; {Отмечаем последнюю связную}
             if Node^.Next <> NIL then PreLast := Node; {Отмечаем предпоследнюю}
             Node := Node^.Next;
          end;
          if Last^.First = true then {Если последняя связная одновременно первая}
          begin
              Dots^.NoNodes := true; {Значит у вершины больше нет связных}
          end else begin
              PreLast^.Next := NIL; {Удаляем последнюю вершину}
          end;
          getNode := Last^.Data; {Возвращаем значение последней связной}
     end else begin
        if Dots^.Data <> First^.Data then {Если мы находимся не на первой вершине графа}
        begin
             errorEiler(errorCode); {Значит возникла ошибка}
        end else begin
             writeln(); {Значит эйлеров цикл построен}
        end;
         getNode := -1; {Прекращаем выполнение}
     end;
end;
function findDot(var s : integer) : boolean; {Поиск следующей вершины графа}
var
     found : boolean;
     errorCode : integer;
begin
     errorCode := 1;
     Dots := First; {Обходим граф с начала}
     while Dots <> NIL do {Пока есть вершины}
     begin
          found := false;
          if Dots^.Data = s then {Если нашли нужную вершину}
          begin
               found := true; {Значит останавливаемся на ней}
               break;
          end;
          Dots := Dots^.Next; {Идем к следующей вершине}
     end;
     if found = true then {Если вершина найдена}
     begin
          findDot := true; {Значит продолжаем выполнение}
     end else begin
          errorEiler(errorCode); {Значит возникла ошибка}
          findDot := false;
     end;
end;
procedure findEiler; {Поиск эйлерова цикла}
var
     dot, remove : integer;
     nodeStatus, removeStatus : boolean;
begin
     dot := 1; {Начинаем идти с первой вершины}
     remove := 0; {Начинаем с первой, значит не нужно у нее удалять никаких связных вершин}
     while dot <> 0 do {Пока цикл не построен}
     begin
          nodeStatus := findDot(dot); {Ищем вершину графа}
          if nodeStatus <> true then break; {Если возникла ошибка - прекращаем выполнение}
	  removeStatus := removeNode(remove); {Удаляем из связных с вершиной ту из которой пришли}
          if removeStatus <> true then break; {Если возникла ошибка - прекращаем выполнение}
          remove := dot; {Вершина из которой мы пришли}
          dot := getNode(); {Следующая вершина, это последняя связная с той из которой пришли}
          if dot = -1 then break; {Флаг прекращения выполнения}
     end;
end;
begin
     addTestGraf(); {Создаем тестовый граф}
     findEiler(); {Ищем эйлеров цикл}
     writeln('Done!');
     readln();
end.
