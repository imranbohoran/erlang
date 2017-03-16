- module(integer_list).
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
    _ ->
      print_list([Numbers]),
      run(Numbers)
  end.
