-module(concurrency101).
-compile(export_all).

% Rough concurrent process
useless() -> 
    receive
        yes -> io:format ("No.~n");
        no  -> io:format ("K.~n");
        _   -> io:format ("pls respond~n")
    end.

% Now with a sender ID and recursion
useless2() ->
    receive
        {ID, hai} -> ID ! "Go away pls",
                     useless2();
        {ID, no}  -> ID ! "Wanna fite me",
                     useless2();
        {ID, _}   -> ID ! "That's what I thought",
                     useless2();
        _         -> io:format("kbye"),
                     useless2()
    end.

% Now with parameters
useful(ID) ->
    receive
        myID -> ID ! "It is ", ID,
                useful(ID);
        _    -> ID ! "jk this isn't working but nice try",
                useful(ID)
    end.
