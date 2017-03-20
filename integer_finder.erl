-module(integer_finder).
- include_lib("includes/eunit.hrl").

-export([find_integers/2]).
-import(mapreduce, [mapreduce/3]).

find_integers(Pids, Finder) ->
  Jobs = lists:map(
    fun(Pid) -> {Pid, {filter, Finder, self()}} end,
    Pids),
  mapreduce:mapreduce(
    Jobs,
    fun(Results, Filtered) ->
      combine_result(Results, Filtered)
    end,
    []).

combine_result(Results, []) ->
  Results;

combine_result(Results, Filtered) ->
  lists:sort(
    sets:to_list(
      sets:from_list(
        lists:flatten(Results ++ Filtered)
      )
    )
  ).

% Tests
find_integers_greater_than_2_test_() ->
  Pid1 = integer_list:start([3,5,2,1,4]),
  Pid2 = integer_list:start([3,4,2,6,8,9]),
  Pids = [Pid1, Pid2],
  Result = find_integers(Pids, fun(X) -> X > 2 end),
  integer_list:stop(Pid1),
  integer_list:stop(Pid2),
  ?_assert(Result =:= [3,4,5,6,8,9]).

find_integers_greater_than_5_test_() ->
  Pid1 = integer_list:start([3,5,2,1,4]),
  Pid2 = integer_list:start([3,4,2,6,8,9]),
  Pids = [Pid1, Pid2],
  Result = find_integers(Pids, fun(X) -> X > 5 end),
  integer_list:stop(Pid1),
  integer_list:stop(Pid2),
  ?_assert(Result =:= [6,8,9]).

