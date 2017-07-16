-module(chain_link_SUITE).


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
  % it should send all messages it receives to the pid it is passed
  Link = spawn_link(chain_link, loop, [self()]),
  Msg = echo,
  Num = 0,
  Link ! {Msg, Num},
  assert_receive({Msg, Num+1}),

  % when it receives the :shutdown message it should end
  Link2 = spawn_link(chain_link, loop, [self()]),
  Msg2 = shutdown,
  Link2 ! Msg2,
  assert_receive(Msg2),
  false = is_process_alive(Link2).

assert_receive(Msg) ->
  receive
      Msg ->
          true
  end.
