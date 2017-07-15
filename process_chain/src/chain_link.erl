-module(chain_link).

-export([loop/1]).

loop(NextPid) ->
  receive
    shutdown ->
      NextPid ! shutdown;
    Msg ->
      NextPid ! Msg,
      loop(NextPid)
  end.
