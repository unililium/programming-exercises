-module(lists1).
-export([myLast/1, myButLast/1, elementAt/2, myLength/1, myReverse/1, isPalindrome/1, flatten/1, myMin/1]).

% myLast([1,2,3]).
% 3
myLast([X]) -> X;
myLast([_|T]) -> myLast(T).

% myButLast([1,2,3]).
% 2
myButLast([_]) -> nil;
myButLast([X,_]) -> X;
myButLast([_|T]) -> myButLast(T).

% elementAt(3, [3,2,1,0]).
% 1
elementAt(_, []) -> nil;
elementAt(N, [H|_]) when N == 1 -> H;
elementAt(N, [_|T]) -> elementAt(N - 1, T).

% myLength([1,2,3]).
% 3
myLength([]) -> 0;
myLength([_|T]) -> 1 + myLength(T).

% myReverse([1,2,3]).
% [3,2,1]
myReverse([X]) -> [X];
myReverse([H|T]) -> myReverse(T) ++ [H]. 

% isPalindrome([1,2,3,2,1]).
% true
isPalindrome(X) -> X == myReverse(X).

% min([1,2,3])
% 1
myMin([H|T]) ->
    myMin(H, T).
myMin(M, []) ->
    M;
myMin(M, [H|T]) when M < H ->
    myMin(M, T);
myMin(_M, [H|T]) ->
    myMin(H, T).

% flatten([1,[2,3],4,[5,[6,7,[8]]],9]).
% [1,2,3,4,5,6,7,8,9]
flatten([H|T]) -> flatten(H) ++ flatten(T);
flatten([]) -> [];
flatten(X) -> [X].
