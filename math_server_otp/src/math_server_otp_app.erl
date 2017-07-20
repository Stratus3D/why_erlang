%%%-------------------------------------------------------------------
%% @doc math_server_otp public API
%% @end
%%%-------------------------------------------------------------------

-module(math_server_otp_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    math_server_otp_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================