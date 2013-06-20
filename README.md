
# ruote_poc

My take on https://groups.google.com/forum/#!topic/openwferu-users/EqFwrMQjEAE


## preparation

```
bundle install
```

Make sure a vanilla Redis is running (the usual port).


## usage

At first, run some workers

```
. worker.sh
```

Then launch the flows

```
. launch.sh 10 x_workers_10
```

The results are placed under results/

To observe the worker activity, run them with NOISY=true:

```
NOISY=true . worker.sh
```

You'll be greated with colorful activity streaming to the stdout.


## my results/

Debian GNU/Linux 2.6.32-5-amd64, Ruby 2.0.0-p195, Redis 2.6.7, ruote and co as per Gemfile.lock


## license

MIT

