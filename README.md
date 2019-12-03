# Pulserl

Pulserl is an Erlang client for the Apache Pulsar Pub/Sub system aiming to provide a producer/consumer implementations.

## Pulsar is currently in progress. Consider current implementations as beta

### Quick Examples

The examples assume you have a running Pulsar broker at `localhost:6650`, a topic called `test-topic` (can be partitioned or not) and `rebar3` installed.

```
  git clone https://github.com/alphashaw/pulserl.git
  cd pulserl
  rebar3 compile
  rebar3 shell
  {ok, Pid} = pulserl:new_producer("test-topic").
  Promise = pulserl:produce(Pid, "Asynchronous produce message").
  pulserl:await(Promise).  %% Wait broker ack
  pulserl:sync_produce(Pid, "Synchronous produce message").
```
