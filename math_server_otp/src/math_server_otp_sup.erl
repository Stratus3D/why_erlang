%%%-------------------------------------------------------------------
%% @doc math_server_otp top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(math_server_otp_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    MaxRestarts = 5,
    MaxSecondsBetweenRestarts = 60,

    % child spec
    MathServer = {math_server_otp, {math_server_otp, start_link, []},
              permanent, 2000, worker, [math_server_otp]},

    % Supervisor settings
    {ok, { {one_for_all, MaxRestarts, MaxSecondsBetweenRestarts}, [MathServer]} }.

%%====================================================================
%% Internal functions
%%====================================================================
