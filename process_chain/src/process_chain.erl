-module(process_chain).

-export([start_timed/3, start/3, create_loop/2]).

start_timed(NumProcesses, Loops, Message) ->
  start(NumProcesses, Loops, Message, true).

start(NumProcesses, Loops, Message) ->
  start(NumProcesses, Loops, Message, false).

start(NumProcesses, Loops, Message, Timed) ->
  Controller = spawn_link(chain_controller, start, [Loops, Message, Timed]),
  FirstPid = create_loop(NumProcesses, Controller),
  Controller ! {start, FirstPid},
  ok.

create_loop(0, PreviousPid) ->
  PreviousPid;
create_loop(NumProcesses, PreviousPid) ->
  Pid = spawn_link(chain_link, loop, [PreviousPid]),
  create_loop(NumProcesses - 1, Pid).
