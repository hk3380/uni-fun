(* For real this time *)
program diningPhilosophers;

(* Number of philosophers *)
const PHIL = 4;

var free: semaphore;
    forks: array[1..PHIL] of semaphore;

process type Philosopher(ID: integer);
var i: integer;

(* Just werks *)
begin
    for i := 1 to 5 do
    begin
        writeln (ID,' is deep in thought.');
        sleep(random(3));

        wait(free);
        wait(forks[ID]);
        wait(forks[(ID mod PHIL) + 1]);

        writeln (ID, ' is eating~');
        sleep(random(3));

        signal(forks[ID]);
        signal(forks[(ID mod PHIL) + 1]);
        signal(free);
    end;
end;

var phils: array[1..PHIL] of Philosopher;
    i: integer;
begin
    (* 1 less free seats than philosophers *)
    initial(free, PHIL-1);

    for i := 1 to PHIL do
        initial(forks[i], 1);

    cobegin
        for i := 1 to PHIL do
            phils[i](i);
    coend;
end.
