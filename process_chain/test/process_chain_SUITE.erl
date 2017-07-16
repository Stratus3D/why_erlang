-module(process_chain_SUITE).

%% API
-export([all/0,
         suite/0,
         groups/0,
         init_per_suite/1,
         end_per_suite/1]).

%% test cases
-export([
         test_start/1
        ]).

-include_lib("common_test/include/ct.hrl").

all() ->
    [
     test_start
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

test_start(_Config) ->
  % start/3 should return ok
  ok = process_chain:start(100, 100, test),

  % start/3 should return ok when told to create 100000 processes
  ok = process_chain:start(10000, 100, test),

  % start/3 should return ok when told to loop 100000 times" do
  ok = process_chain:start(100, 10000, test).
