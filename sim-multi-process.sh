#!/bin/sh
# Work in progress...
mkdir -p results/
for i in `seq 1 40`; do
    echo $i
    java -cp tla2tools-faster-progress.jar tlc2.TLC -metadir states/sim_$i -seed $i -simulate -depth 50 -workers 1 -config MC.cfg MC.tla > results/worker_$i.txt &
    sleep 0.5
done