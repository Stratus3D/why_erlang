% Code used on the slides in my talk


% Atoms
hello_world
a
true % No booleans


% Binaries and Numbers
% Binaries
<<97,98,99>>
<<"abc">>
% Integers
12
% Floats
23.5


% Tuples
{one, two, three}
% Tuples are contiguously in memory
{1,2,3,4}
% We can use access individual items
element(2, {1,2,3,4}) % => 2


% Lists
[1,2,3]
Letters = [a,b,c]
% Items can be added to the front of the list easily
[d|Letters] % => [d,a,b,c]


% Strings
"Joe" % => "Joe" % still just a list
% $a returns the character code for a
$a % => 97
% If lists only contain character codes they will be printed as strings
[$a, $b, $c] % => "abc"


% More Data Types
% Maps
#{key => value}
% Records
-record(user, {username, email, password}).
#user{username="Joe", email="joe@ericsson.com"}.


% Modules
-module(demo).
% Functions must be exported to be used outside the module
-export([test/0]).
% Function here


% Functions
% add/2 has two clauses
add(0, 0) -> 0;
add(X, Y) -> X + Y.

% add/3 has one clause
add(X, Y, Z) -> X + Y + Z.


% Pattern Matching
a = a % => a
a = b % => ** exception error: no match of right hand side value b
Letter = a % => a
Letter % => a


% Matching Tuples
{ok, Value} = {ok, "foo bar baz"}
Value % => "foo bar baz"
{ok, Value} = {error, crashed}
% => ** exception error: no match of right hand side value crashed


% Matching Lists
[Head|Tail] = [1,2,3]
Head % => 1
Tail % => [2,3]
[First,Second,Third] = [1,2,3]
Second % => 2
[One,Two] = [1,2,3] % ** exception error: no match of right hand side value [1,2,3]
[First,Second|Rest] = [1,2,3]


% Underscore variable
{_, _} = {1,1}
{_, _} = {1,2}
{Num, Num} = {1,2} % ** exception error: no match of right hand side value {1,2}


% Pattern matching in function clauses
% add/2 has three clauses
add(0, 0) -> 0;
add(X, X) -> X * 2;
add(X, Y) -> X + Y.


% Recursive Functions
sum_list(List) -> sum_list(List, 0).

sum_list([], Acc) -> Acc;
sum_list([Head|Tail], Acc) -> sum_list(Tail, Acc + Head).


% Process Messaging
% `Pid` is a process ID
Pid ! {add, 1, 2, self()}
% Receive a message in the process
receive
  {add, X, Y, Caller} ->
    % Send the result back
    Caller ! add(X, Y)
  _ ->
    error
end


% Spawning a process
% Assuming ?MODULE:math_server/0 is a function
{ok, Pid} = spawn(?MODULE, math_server, []).
