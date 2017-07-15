-module(chain_controller).

-export([start/3, wait/2, loop/3]).

start(Loops, Message, Timed) ->
  % Wait for the start message to be received
  case Timed of
    true ->
      {Microseconds, ok} = timer:tc(?MODULE, wait, [Loops, Message]),
      io:format("~w Loops completed in ~w seconds", [Loops, (Microseconds / 1000000)]);
    false ->
      wait(Loops, Message)
  end.

wait(Loops, Message) ->
  receive
    {start, FirstLink} ->
      % Start the first loop
      io:format("Sending Message `~p`!", [Message]),
      FirstLink ! Message,
      loop(Loops-1, Message, FirstLink)
  end.

loop(0, Message, FirstLink) ->
  % All loops complete, tell the chain link processes to shutdown
  FirstLink ! shutdown,
  io:format("Got Message `~p`!", [Message]);
loop(Loops, Message, FirstLink) ->
  receive
    Message ->
      FirstLink ! Message
  end,
  loop(Loops-1, Message, FirstLink).
