%%%-------------------------------------------------------------------
%%% @author Alpha Umaru Shaw <shawalpha5@gmail.com>
%%% @doc
%%%
%%% @end
%%% Copyright: (C) 2020, Skulup Ltd
%%%-------------------------------------------------------------------
-module(pulserl_consumer_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).
%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    ets:new(pulserl_consumers,
            [named_table, bag, public, {read_concurrency, true}, {write_concurrency, true}]),
    SupFlags =
        #{strategy => simple_one_for_one,
          intensity => 1000,
          period => 3600},
    ChildSpecs =
        [#{id => pulserl_consumer,
           start => {pulserl_consumer, start_link, []},
           restart => transient,
           shutdown => 10000,
           type => worker,
           modules => [pulserl_consumer]}],
    {ok, {SupFlags, ChildSpecs}}.
