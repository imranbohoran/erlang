- module(dictionary_server).
- export([start/0]).
- export([stop/0]).
- export([insert/2]).
- export([remove/1]).
- export([lookup/1]).
- export([clear/0]).
- export([size/0]).

start() ->
  Dictionary = dict:new(),
  Pid = spawn(fun() -> dictionary_listener(Dictionary) end),
  register(dictionary_listener, Pid),
  dictionary_listener ! {self(), start},
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


dictionary_listener(Dictionary) ->
  receive
    {From, start} ->
      io:format("Starting..."),
      From ! {self(), "Started"},
      dictionary_listener(Dictionary);
    {From, insert, Key, Value} ->
      io:format("Inserting..."),
      io:format(Key),
      NewDictionary = dict:store(Key, Value, Dictionary),
      From ! {self(), "Inserting done"},
      dictionary_listener(NewDictionary);
    {From, remove, Key} ->
      io:format("Removing"),
      dictionary_listener(Dictionary);
    {From, lookup, Key} ->
      io:format("Lookup"),
      dictionary_listener(Dictionary);
    {From, clear} ->
      io:format("Clearing"),
      dictionary_listener(Dictionary);
    {From, size} ->
      From ! {self(), dict:size(Dictionary)},
      dictionary_listener(Dictionary);
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
  Pid = whereis(dictionary_listener),
  Pid ! {self(), clear},
  receive
    _ -> ok
  end.


size() ->
  Pid = whereis(dictionary_listener),
  Pid ! {self(), size},
  io:format("The dictionary size is - "),
  receive
    {_Pid, Size} ->
      Size;
    _ -> ok
  end.
