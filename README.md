# Concurrent programming - Erlang

## part1.erl
Demonstrates sequential programming in Erlang. Provides the following functions;

    * fib(N)
    * adjacent duplicates(L)
    * deep_sum(L)
    * concatenate_all(L)
    * perimeter(Shape)
    * permutations(L)

##### Running the functions
On the erlang console
erl> c(part1).
erl> part1:fib(6).
erl> part1:adjacent duplicates([1, 1, 2, 2, 3, 3]).
erl> part1:deep_sum([1, 2, 3, 4]).
erl> part1:concatnate_all(["Trevor","is","happy"]).
erl> part1:perimeter({circle, 3}).
erl> part1:permutations([1, 2, 3]).

##### Running all tests
erl> part1:test().



## dictionary_server.erl
Demonstrates process and message passing in Erlang. The dictionary server can be started
and key-values can be inserted. Upon inserting key-values, the server provides
functions to lookup and remove values based on a key.
The following functions are available;

    * start/0  - Starts the dictionary server process. If there is already a dictionary server running, 
                 this function should fail, but it’s not important what error it returns. 
    * stop/0   - Stops the dictionary server process if it’s running. If there is no dictionary server
                 process running, this function has no effect.
    * insert/2 - Takes two parameters, a key and a value, and adds the given key and its value
                 to the dictionary. If the given key is already in the dictionary, the new value should
                 replace the old value in the dictionary. This function returns ok after its work is done.
    * remove/1 - Takes one parameter, a key, and removes the given key from the dictionary if
                 it’s present. This function returns ok if the key was removed successfully, or notfound
                 if the key was not in the dictionary.
    * lookup/1 - Takes one parameter, a key, and finds the corresponding value in the dictionary.
                 If the key is in the dictionary, this function returns the tuple {ok, Value}, where
                 Value is the value associated with the key. If the key is not in the dictionary, this
                 function returns notfound.
    * clear/0  - Clears all keys and values out of the dictionary.
    * size/0   - Returns an integer specifying the number of keys in the dictionary.

#### Running the dictionary server

###### Start the server
erl> dictionary_server:start().

###### Insert a key-value pair
erl> dictionary_server:insert(ab,"This is ab").

###### Look up a value for a given key
erl> dictionary_server:lookup(ab).

###### Check the size of the dictionary
erl> dictionary_server:size().

###### Remove a given key
erl> dictionary_server:remove(ab).

###### Clear all keys of the dictionary
erl> dictionary_server:size().

###### Stop the dictionary server
erl> dictionary_server:stop().


## integer_list.erl & integer_finder.erl
Demonstrates an implementation of MapReduce in Erlang. 
`integer_list` module can be spawned multiple times with different set of integers.
To spawn a process;

    erl> Pid1 = integer_list:start([3,5,2,1,4]).
    erl> Pid2 = integer_list:start([3,4,2,6,8,9]).

And then `integer_finder` can be used to apply a function on all numbers of all `integer_list` processes.
To run a finder;
    
    erl> Pids = [Pid1, Pid2].
    erl> integer_finder:find_integers(Pids, fun(X) -> X > 2 end).

An `integer_list` process can be stopped as follows;
    
    erl> integer_list:stop(Pid1).
