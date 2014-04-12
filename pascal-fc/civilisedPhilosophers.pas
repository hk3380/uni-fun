(* :^) *)
program civilisedPhilosophers;
var forks: array[0..2] of boolean;
    turn: integer;

process type Philosopher(ID: integer);
var i: integer;

begin
    for i := 1 to 10 do
    begin
        (* busy-wait loop *)
        while not (turn = ID) do
                null;

        (* critical section *)
        writeln (ID, ' eating');

        turn := (ID+1) mod 3;
    end;
end;

var P1, P2, P3: Philosopher;
begin
    turn := 0;

    cobegin
       P1(0); P2(1); P3(2) 
    coend;
end.
