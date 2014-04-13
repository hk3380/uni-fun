-module(todolist).
-compile(export_all).

todo(List) ->
    receive
        {ID, add, Item} ->
            ID ! "added.",
            todo([Item|List]);
        {ID, remove, Item} ->
            case lists:member(Item, List) of
                true ->
                    ID ! "removed.",
                    todo(lists:delete(Item, List));
                false ->
                    ID ! "not found.",
                    todo(List)
            end;
    terminate ->
        ok
    end.

add(ID, Item) ->
    ID ! {self(), add, Item}.

remove(ID, Item) ->
    ID ! {self(), remove, Item}.

start() ->
    spawn(?MODULE, todo, [[]]).
