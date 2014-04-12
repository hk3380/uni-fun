program Barriers;

(* When to release the barrier *)
const MAX = 5;

(* To make the processes behave *)
var patience: semaphore;

(* Barrier that releases the process when they gather up to MAX *)
monitor barrier;
export Wait;

    var releaseCondition: condition;
        numProcesses: integer;

    procedure Wait(ID: integer);
    begin
        (* Count the waiting processes *)
        numProcesses := numProcesses + 1;

        (* Block them if they're not ready *)
        if numProcesses < MAX then
            delay(releaseCondition)
        else resume(releaseCondition);

        writeln (ID, ' released.');

        (* Keep count *)
        numProcesses := numProcesses - 1;
        resume(releaseCondition);
    end;

    begin
        numProcesses := 0;
    end;

process type Caller (ID: integer);
begin
    (* Mutex used to print nicely *)
    wait(patience);
    writeln ('Caller number ', ID, ' will be locked until further notice');
    signal(patience);

    barrier.Wait(ID);

    wait(patience);
    writeln (ID, ' is back ~');
    signal(patience);
end;

var callers: array[1..5] of Caller;
    i: integer;
begin
    initial(patience, 1);
    cobegin
        for i := 1 to 5 do
            callers[i](i);
    coend;
end.

