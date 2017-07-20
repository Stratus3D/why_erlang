-module(math_server).

-export([start/0, add/2, subtract/2, multiply/2, divide/2]).

-export([loop/0]).

%% API

start() ->
  Pid = spawn_link(?MODULE, loop, []),
  register(?MODULE, Pid).

add(X, Y) ->
  request({add, X, Y}).

subtract(X, Y) ->
  request({subtract, X, Y}).

multiply(X, Y) ->
  request({multiply, X, Y}).

divide(X, Y) ->
  request({divide, X, Y}).

%% Callbacks and private functions

request(Command) ->
  ?MODULE ! {self(), Command},
  receive
    {response, Result} ->
      Result
  after
    1000 ->
      {error, timeout}
  end.

loop() ->
  receive
    {Pid, Request} ->
      % process_request does the actual arithmetic
      Response = process_request(Request),
      Pid ! {response, Response}
  end,
  loop().

process_request(Request) ->
  case Request of
    {add, X, Y} ->
      X + Y;
    {subtract, X, Y} ->
      X - Y;
    {multiply, X, Y} ->
      X * Y;
    {divide, X, Y} ->
      X / Y
  end.
