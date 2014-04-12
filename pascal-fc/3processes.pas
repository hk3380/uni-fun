program three;
var turn: integer;

process type P(ID: integer; letter: char);
var j,i: integer;

begin
    for i := 1 to 20 do
    begin
        (* busy-wait loop *)
        while turn <> ID do
            null;

        (* critical section *)
        for j := 1 to 4 do
            write (letter);


        turn := (turn) mod 3 + 1
    end;
end;

var P1, P2, P3: P;

begin
    turn := 1;
    cobegin
        P1(1, 'A'); P2(2, 'B'); P3(3, 'C')
    coend;
end.

