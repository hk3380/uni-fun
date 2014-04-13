-module (erlang101).
-export ([fact/1, sup/0, ez/2, go_home/1,
        hungry/1, factail/1, quicksort/1, map/2]).

% Let's see
sup() -> io:format("Hiya, world!~n").

% Pattern matching
ez(yes, Name) -> io:format ("good for you ~s~n", [Name]);
ez(no, Name)  -> io:format ("go home ~s~n", [Name]);
ez(_, _)      -> io:format ("what ~n").

% Guards
go_home(H) when H >= 0000 andalso H =< 1600 -> true;
go_home(_) -> false.

% if else
hungry(X) -> 
    if X =:= me -> yes;
        true    -> lolwhocares
    end.

% Recursion
fact(0) -> 1;
fact(N) -> N * fact(N-1).

% Tail recursion
factail(N)      -> factail(N, 1).
factail(0, Acc) -> Acc;
factail(N, Acc) -> factail(N-1, Acc * N).

% Am i functional yet
quicksort([])           -> [];
quicksort([Pivot|Rest]) ->
    quicksort([Smaller || Smaller <- Rest, Smaller =< Pivot])
    ++ [Pivot] ++
    quicksort([Bigger || Bigger   <- Rest, Bigger > Pivot]).

% Higher order
map (_, [])    -> [];
map (F, [H|T]) -> [F(H) | map(F, T)].
