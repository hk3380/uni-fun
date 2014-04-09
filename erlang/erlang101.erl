-module (erlang101).
-export ([fact/1, sup/0, ez/2, go_home/1, hungry/1]).

% Let's see
sup() -> io:format("Hiya, world!~n").

% Recursion
fact(0) -> 1;
fact(N) -> N * fact(N-1).

% Pattern matching
ez(yes, Name) -> io:format ("good for you ~s~n", [Name]);
ez(no, Name)  -> io:format ("go home ~s~n", [Name]);
ez(_, Name)   -> io:format ("what ~n").

% Guards
go_home(H) when H >= 0000 andalso H =< 1600 -> true;
go_home(_) -> false.

% if else
hungry(X) -> 
    if X =:= me -> yes;
        true -> lolwhocares
    end.
