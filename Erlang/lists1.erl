-module(lists1).
-export([myLast/1, myButLast/1, min/1]).

myLast([X]) -> X;
myLast([_|T]) -> myLast(T).

myButLast([_]) -> false;
myButLast([X,_]) -> X;
myButLast([H|T]) -> myButLast(T).

min([H|T]) ->
    min(H, T).
min(M, []) ->
    M;
min(M, [H|T]) when M < H ->
    min(M, T);
min(_M, [H|T]) ->
    min(H, T).
