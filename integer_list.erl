- module(integer_list).
- include_lib("includes/eunit.hrl").

- export([start/1]).
- export([stop/1]).

start(NumberList) ->
  io:format("Starting..."),
  Pid = spawn(fun () -> run(NumberList) end),
  Pid.

stop(Pid) ->
  Pid ! {stop, self()},
  receive
    ok ->  exit(Pid, ok)
  end.

print_list([]) ->
  ok;
print_list([H|T]) ->
  io:format("~p",[H]),
  print_list(T).

run(Numbers) ->
  receive
    {stop, ReplyPid} ->
      io:format("Stopping..."),
      ReplyPid ! ok;
    {filter, FilterFunction, ReplyPid} ->
      io:format("Inside filter"),
      Filtered = lists:filter(FilterFunction, Numbers),
      io:format("Filtering done"),
      print_list([Filtered]),
      io:format("~n"),
      ReplyPid ! [Filtered],
      run(Numbers);
    _ ->
      print_list([Numbers]),
      run(Numbers)
  end.

% Tests
start_stop_test_() ->
  TPid = start([1,3]),
  ?_assert(is_process_alive(TPid)),
  stop(TPid),
  ?_assertNot(is_process_alive(TPid)).
