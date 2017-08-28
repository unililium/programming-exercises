-module(pfilter).
-export([pfilter/2]).

runit(Proc, F, X) ->
    Proc ! {self(), X, F(X)}.

pfilter(F, L) ->
    W = lists:map(fun (X) -> spawn(?MODULE, runit, [self(), F, X])
                             end, L),
    lists:foldl(fun (P, Vo) ->
                        receive
                            {P, X, true} -> Vo ++ [X];
                            {P, _, false} -> Vo
                        end
                end, [], W).
