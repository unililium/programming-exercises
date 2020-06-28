-module(second).
-export([hypothenuse/2, perimeter/2, area/2]).

hypothenuse(A, B) ->
    math:sqrt(first:square(A) + first:square(B)).

perimeter(A, B) ->
    A + B + hypothenuse(A, B).

area(A, B) ->
    (A * B) / 2.