runit(Proc, F, X) ->
    Proc ! {self(), X, F(X)}.

pfilter(F, L) ->
    W = lists:map(func(x) -> spawn(?MODULE, runit, [self(), F, X])
                             end, L),
    lists:foldl(fun (P, Vo) ->
                        receive
                            {P, X, true} -> Vo ++ [X];
                            {P, _, false} -> Vo
                        end
                end, [], W).
