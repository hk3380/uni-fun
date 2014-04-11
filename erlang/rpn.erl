-module(rpn).
-export([rpn/1]).

% Reverse polish notation done on strings
rpn(L) when is_list(L) ->
        [Result] = lists:foldl(fun rpn/2, [], string:tokens(L, " ")),
        Result.

% Operands
rpn("+", [N1,N2|S]) -> [N2+N1|S];
rpn("-", [N1,N2|S]) -> [N2-N1|S];
rpn("*", [N1,N2|S]) -> [N2*N1|S];
rpn("/", [N1,N2|S]) -> [N2/N1|S];
rpn("^", [N1,N2|S]) -> [math:pow(N2,N1)|S];
rpn("ln", [N|S])    -> [math:log(N)|S];
rpn("log10", [N|S]) -> [math:log10(N)|S];
rpn("sum", Stack)   -> [lists:sum(Stack)];
rpn("prod", Stack)  -> [lists:foldl(fun erlang:'*'/2, 1, Stack)];

% Operators
rpn(X, Stack)       -> [read(X)|Stack].

% Cast string to either float or integer
read(X) -> 
    case string:to_float(X) of
        {error, no_float} -> string:to_integer(X);
        {F, _}            -> F
    end.
