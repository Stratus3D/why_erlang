-module(chain_controller_SUITE).

%% API
-export([all/0,
         suite/0,
         groups/0,
         init_per_suite/1,
         end_per_suite/1]).

%% test cases
-export([
         test_messaging/1
        ]).

-include_lib("common_test/include/ct.hrl").

all() ->
    [
     test_messaging
    ].

suite() ->
    [{ct_hooks,[cth_surefire]}, {timetrap, {seconds, 30}}].

groups() ->
    [].

%%%===================================================================
%%% Overall setup/teardown
%%%===================================================================
init_per_suite(Config) ->
    Config.

end_per_suite(_Config) ->
    ok.


%%%===================================================================
%%% Individual Test Cases (from groups() definition)
%%%===================================================================

test_messaging(_Config) ->
  % should loop the given number of times (two in this case)
  % Spawn controller process
  Msg = test,
  Controller = spawn(chain_controller, start, [2, Msg, false]),
  Controller ! {start, self()},

  % Start loop
  Controller ! start,

  % Should send message on first loop
  assert_receive({Msg, 0}),
  Controller ! {Msg, 1},

  % Should send message on second loop
  assert_receive({Msg, 2}),
  Controller ! {Msg, 3},

  % Should not send message on third loop
  refute_receive({Msg, 4}),

  % Should send shutdown message to processes in the loop when finished
  assert_receive(shutdown).

assert_receive(Msg) ->
  receive
      Msg ->
          true
  end.

refute_receive(Msg) ->
  receive
    Msg ->
      error("received unexpected message")
  after
    0 ->
      ok
  end.
