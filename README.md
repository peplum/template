# Peplum::Template

`Peplum::Template` is a template project used for [Peplum](https://github.com/peplum/peplum) applications.

## Implementation

* Clone this repo:
  * `$ git clone git@github.com:peplum/peplum-template.git`
* Remove current git repo:
  * `$ rm -rf peplum-template/.git`
* Fill in [template/application.rb](https://github.com/peplum/template/blob/master/lib/peplum/template/application.rb).
* Fill in [template/application/payload.rb](https://github.com/peplum/template/blob/master/lib/peplum/template/application/payload.rb) with the 
code you want to run in a distributed environment.
* Replace `template` and `Template` references with your project name.

You should now be good to go!

## Installation

    $ cd peplum-template
    $ bundle install

## Usage

See the [examples/](https://github.com/peplum/template/blob/master/examples/) directory.

### Grid

Peplum can run payloads from the same machine, but the idea behind it is to use a _Grid_ which transparently
load-balances and line-aggregates, in order to combine resources and perform batch operations faster than one single
machine could.

That _Grid_ technology is graciously provided by [Cuboid](https://github.com/qadron/cuboid) and can be setup like so:

```
$ bundle exec irb
irb(main):001:0> require 'peplum/template'
=> true
irb(main):002:0> Peplum::Template::Application.spawn( :agent, address: Socket.gethostname )
I, [2023-05-21T19:11:20.772790 #359147]  INFO -- System: Logfile at: /home/zapotek/.cuboid/logs/Agent-359147-8499.log
I, [2023-05-21T19:11:20.772886 #359147]  INFO -- System: [PID 359147] RPC Server started.
I, [2023-05-21T19:11:20.772892 #359147]  INFO -- System: Listening on xps:8499
```

And at the terminal of another machine:

```
$ bundle exec irb
irb(main):001:0> require 'peplum/template'
=> true
irb(main):002:0> Peplum::Template::Application.spawn( :agent, address: Socket.gethostname, peer: 'xps:8499' )
I, [2023-05-21T19:12:38.897746 #359221]  INFO -- System: Logfile at: /home/zapotek/.cuboid/logs/Agent-359221-5786.log
I, [2023-05-21T19:12:38.998472 #359221]  INFO -- System: [PID 359221] RPC Server started.
I, [2023-05-21T19:12:38.998494 #359221]  INFO -- System: Listening on xps:5786
```

That's a _Grid_ of 2 Peplum _Agents_, both of them available to provide worker _Instances_ that can be used to parallelize execution.

If those 2 machines use a different pipe to a network you target, the result will be that the network resources
are going to be in a way combined; or if the payload is too CPU intensive for just one machine, this will split the workload
amongst the 2.

The cool thing is that it doesn't matter to which you refer for _Instance_ _spawning_, the appropriate one is going to
be the one providing it.

You can then configure the _REST_ service to use any of those 2 _Agents_ and perform your operation --
see [examples/rest.rb](https://github.com/peplum/template/blob/master/examples/rest.rb).

The _REST_ service is good for integration, so it's your safe bet; you can however also take advantage of the internal
_RPC_ protocol and opt for something more like [examples/rpc.rb](https://github.com/peplum/template/blob/master/examples/rpc.rb).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/peplum/peplum-template.

## Funding

Peplum::Template is a [Peplum](https://github.com/peplum/) project and as such funded by [Ecsypno Single Member P.C.](https://ecsypno.com).
