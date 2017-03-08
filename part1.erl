- module(part1).
- include_lib("includes/eunit.hrl").
- export([fib/1]).
- export([adjacent_duplicates/1]).
- export([deep_sum/1]).
- export([concatenate_all/1]).
- export([perimeter/1]).

fib(N) -> fib_tail_recursive(N, 1, 1).
fib_tail_recursive(0, _FibValue, _NextValue) -> 1;
fib_tail_recursive(1, FibValue, _NextValue) -> FibValue;
% Tail recursive function when iteration is more than 1. When it's 1, we return the FibValue from the above definision
% For 6 -> (6,1,1) -> (5,1,2) -> (4,2,3) -> (3,3,5) -> (2, 5, 8) -> (1, 8, 13) -> hits the first definition
fib_tail_recursive(Iteration, FibValue, NextValue) -> fib_tail_recursive(Iteration - 1, NextValue, FibValue + NextValue).

adjacent_duplicates([]) -> [];
adjacent_duplicates([First | [Next | Rest]]) -> capture_duplicates(First, Next, Rest, []).

capture_duplicates(FirstValue, FirstValue, [], Result) -> 
    NewResult = Result ++ [FirstValue],
    NewResult;

capture_duplicates(FirstValue,NextValue,[],Result) -> 
    Result;

capture_duplicates(FirstValue, FirstValue, Rest, Result) -> 
    [NextValue | Remaining] = Rest,
    NewResult = Result ++ [FirstValue],
    capture_duplicates(FirstValue, NextValue, Remaining, NewResult);

capture_duplicates(FirstValue, ComparingValue, Rest, Result) -> 
    [NextValue | Remaining] = Rest,
    capture_duplicates(ComparingValue, NextValue, Remaining, Result).

deep_sum(L) -> lists:sum(lists:flatten(L)).

concatenate_all(L) -> lists:flatten(L).

perimeter(Shape) -> calculate_perimeter(Shape).

calculate_perimeter({circle,Radius}) -> 2 * Radius * 3.141592;
calculate_perimeter({right_triangle, Width, Height, Hypot}) -> Width + Height + Hypot;
calculate_perimeter({rectangle, Width, Height}) -> 2 * (Width + Height).


fib_test_() ->
    [
        ?_assert(fib(0) =:= 1),
        ?_assert(fib(1) =:= 1),
        ?_assert(fib(6) =:= 8),
        ?_assert(fib(40) =:= 102334155)
    ].

adjacent_duplicates_test_() ->
    [
        ?_assert(adjacent_duplicates([1, 1, 2, 2, 3, 3]) =:= [1, 2, 3]),
        ?_assert(adjacent_duplicates([1, 2, 2, 2, 3]) =:= [2, 2]),
        ?_assert(adjacent_duplicates([1, 2, 3, 4]) =:= []),
        ?_assert(adjacent_duplicates([1, 2, 3, 2, 1]) =:= [])
    ].

deep_sum_test_() ->
    [
        ?_assert(deep_sum([1, 2, 3, 4]) =:= 10),
        ?_assert(deep_sum([1, 2, [2, 3, 3, 4], 4, 5]) =:= 24),
        ?_assert(deep_sum([[[1, 2, 3, 4], 3, 4], 4, 5, [5, 6, 6, 7]]) =:= 50),
        ?_assert(deep_sum([]) =:= 0)
    ].

concatenate_all_test_() ->
    [
        ?_assert(concatenate_all(["Trevor","is","happy"]) =:= "Trevorishappy"),
        ?_assert(concatenate_all(["Time",""," ","the ","Conquerer"]) =:= "Time the Conquerer")
    ].

perimeter_test_() ->
    [
        ?_assert(perimeter({circle, 3}) =:= 18.849552000000003),
        ?_assert(perimeter({rectangle, 5, 7}) =:= 24),
        ?_assert(perimeter({right_triangle, 3, 4, 5}) =:= 12)
    ].