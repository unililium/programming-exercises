-module(lists1).
-export([min/1]).

min([H|T]) ->
    min(H, T).
min(M, []) ->
    M;
min(M, [H|T]) when M < H ->
    min(M, T);
min(_M, [H|T]) ->
    min(H, T).
