- module(part1).
- export([fib/1]).
- export([adjacent_duplicates/1]).
- export([deep_sum/1]).

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

