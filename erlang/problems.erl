-module(problems).
-export([mylast/1, mylastbutone/1, mylength/1, encode/1, reverse/1]).

mylast([H|[]]) -> H;
mylast([_|T]) -> mylast(T).

mylastbutone(List) -> mylastbutone(List, [], []).
mylastbutone([], A, _) -> [A];
mylastbutone([H|T], _, B) -> mylastbutone(T, B, H).

mylength([]) -> 0;
mylength([_|[]]) -> 1;
mylength([_|T]) -> 1 + length(T).

encode(List) -> encode(List, 1).
encode([], _) -> [];
encode([H, H | T], Num) -> encode([H | T], Num + 1);
encode([H | T], Num) -> [{Num, H} | encode(T, 1)].

reverse(List) -> reverse(List, []).
reverse([], Reverse_List) -> Reverse_List;
reverse([H | T], Reverse_List) -> reverse(T, [H | Reverse_List]).