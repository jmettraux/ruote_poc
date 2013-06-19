
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


## license

MIT

