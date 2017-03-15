- module(integer_list).
- export([start/1]).
- export([stop/1]).

start(number_list) ->
  spawn(fun () -> run(number_list) end).


stop(pid) ->
  erlang:error(not_implemented).

run(numbers) ->
  receive
    {stop, ReplyPid} ->
      ReplyPid ! ok;
    {From, _} ->
      From ! {self(), numbers},
      run(numbers)
  end.
