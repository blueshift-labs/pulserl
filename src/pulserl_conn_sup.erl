%%%-------------------------------------------------------------------
%%% @author Alpha Umaru Shaw <shawalpha5@gmail.com>
%%% @doc
%%%
%%% @end
%%% Copyright: (C) 2020, Skulup Ltd
%%%-------------------------------------------------------------------

-module(pulserl_conn_sup).

-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

init([]) ->
    SupFlags =
        #{strategy => simple_one_for_one,
          intensity => 1000,
          period => 3600},
    ChildSpecs =
        [#{id => pulserl_conn,
           start => {pulserl_conn, start_link, []},
           restart => transient,
           shutdown => 10000,
           type => worker,
           modules => [pulserl_conn]}],
    {ok, {SupFlags, ChildSpecs}}.
