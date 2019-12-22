#!/bin/bash

#
# Benchmark performance of TLC multi-threaded simulation mode.
#

# Final stats file.
statsfile="stats.csv"
printf "" > $statsfile
printf "workers,states_per_min\n" >> $statsfile
tlcjar="tla2tools-faster-progress.jar"

# Run simulator for several seconds for different worker counts.
# Collect state throughput stats for each.
for w in {1,2,4,8,12,16,20,24,28,32,36,40,44,48}; do
  duration="60s"
  depth="50"
  echo "Running simulation mode with $w workers for duration of $duration"
  timeout -s SIGTERM $duration java -cp $tlcjar tlc2.TLC -seed 0 -simulate -depth $depth -workers $w -config MC.cfg MC.tla | tee tlc.out
  printf $w >> $statsfile 
  printf "," >> $statsfile
  throughput=`grep "states.min" tlc.out | tail -1`
  echo "Mean throughput: $throughput"
  echo $throughput | cut -d ' ' -f 1  | sed -E "s/,//g" >> $statsfile

  # Give the system time to recover (?)
  echo "Pausing for a bit before next run..."
  sleep 30
done