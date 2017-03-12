- module(dictionary_server).
- export([start/0]).
- export([stop/0]).
- export([insert/2]).
- export([remove/1]).
- export([lookup/1]).
- export([clear/0]).
- export([size/0]).

start() -> 
  Pid = spawn(fun() -> dictionary_listener() end),
  register(dictionary_listener, Pid),
  dictionary_listener ! {self(), command},
  receive
    _ -> "Dictonary Server - Started"
  end.


stop() ->
  Pid = whereis(dictionary_listener),
  end_server(Pid).

end_server(undefined) ->
  io:format("");

end_server(Pid) ->
  exit(Pid, ok),
  io:format("Dictionary Server - Stopped - ").


dictionary_listener() ->
  receive
    {From, Msg} ->
      From ! {self(), Msg},
      dictionary_listener();
    {From, insert, Key, Value} ->
      io:format("Inserting..."),
      io:format(Key),
      From ! {self(), "Inserting done"},
      dictionary_listener();
    {From, remove, Key} ->
      io:format("Removing"),
      dictionary_listener();
    {From, lookup, Key} ->
      io:format("Lookup"),
      dictionary_listener();
    {From, clear} ->
      io:format("Clearing"),
      dictionary_listener();
    {From, size} ->
      io:format("Inquiring size"),
      dictionary_listener();
    {From, stop} ->
      io:format("Stoppping...."),
      true
  end.


insert(Key, Value) ->
  Pid = whereis(dictionary_listener),
  Pid ! {self(), insert, Key, Value},
  receive
    _ -> ok
  end.

remove(Key) ->
  erlang:error(not_implemented).


lookup(Key) ->
  erlang:error(not_implemented).


clear() ->
  erlang:error(not_implemented).


size() ->
  erlang:error(not_implemented).
