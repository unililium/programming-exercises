-module(palin).
-export([server/1]).

rem_punct(String) ->
    lists:filter(fun (Ch) ->
        not(lists:member(Ch, "\"\'\t\n "))
    end,
    String).

to_small(String) ->
    lists:map(fun(Ch) ->
        case ($A =< Ch andalso Ch =< $Z) of
            true -> Ch+32;
            false -> Ch
        end
    end,
    String).

pal_check(String) ->
    Normalise = to_small(rem_punct(String)),
    lists:reverse(Normalise) == Normalise.

server(Pid) ->
    receive
        {check, String} ->
            case pal_check(String) of
                true -> Pid ! {result, String ++ " is a palindrome~n"};
                false -> Pid ! {result, String ++ " isn't palindrome~n"}
            end,
            server(Pid);
        stop ->
            io:format("Bye~n")
    end.