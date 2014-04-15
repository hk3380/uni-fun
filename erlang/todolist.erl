% Concurrent TODO list

-module(todolist).
-compile(export_all).

todo(List) ->
    % The process receives signals in a direct asymmetric way
    receive
        % Patterns to match and respond asynchronously

        % Add item to the todo list
        {ID, add, Item} ->
            ID ! "added.",
            todo([Item|List]);

        % Remove item
        {ID, remove, Item} ->
            case lists:member(Item, List) of
                true ->
                    ID ! "removed.",
                    todo(lists:delete(Item, List));
                false ->
                    ID ! "not found.",
                    todo(List)
            end;

        % Get entire list
        {ID, list} ->
            ID ! List,
            todo(List);

    terminate ->
        ok

    end.

% Some sorts of interface

add(ID, Item) ->
    ID ! {self(), add, Item}.

remove(ID, Item) ->
    ID ! {self(), remove, Item}.

list(ID) ->
    ID ! {self(), list}.


% Spawns a todo process that listens for messages to pattern match
% Function returns ID, as the communication method is direct asymmetric naming
start() ->
    spawn(?MODULE, todo, [[]]).
