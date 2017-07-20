-module(math_server_otp).

-behaviour(gen_server).

%% API
-export([start_link/0, add/2, subtract/2, multiply/2, divide/2]).

%% gen_server callbacks
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-define(SERVER, ?MODULE).

-record(state, {}).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

add(X, Y) ->
  gen_server:call(?MODULE, {add, X, Y}).

subtract(X, Y) ->
  gen_server:call(?MODULE, {subtract, X, Y}).

multiply(X, Y) ->
  gen_server:call(?MODULE, {multiply, X, Y}).

divide(X, Y) ->
  gen_server:call(?MODULE, {divide, X, Y}).


%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
    {ok, #state{}}.

handle_call({add, X, Y}, _From, State) ->
    Reply = X + Y,
    {reply, Reply, State};
handle_call({subtract, X, Y}, _From, State) ->
    Reply = X - Y,
    {reply, Reply, State};
handle_call({multiply, X, Y}, _From, State) ->
    Reply = X * Y,
    {reply, Reply, State};
handle_call({divide, X, Y}, _From, State) ->
    Reply = X / Y,
    {reply, Reply, State};
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
        {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
