#!/bin/bash

#
# Benchmark performance of TLC multi-threaded simulation mode.
#

# Download Grid5k spec to test with.
wget https://raw.githubusercontent.com/tlaplus/tlaplus/master/general/performance/Grid5k/{MC.tla,MC.cfg,Grid5k.tla}

# Download tla tools JAR.
wget "https://nightly.tlapl.us/dist/tla2tools.jar"

for w in {8,16,24,32,40,48,56,64,72,80,88}; do
  # Run simulator for several minutes and then collect throughput stats.
  outfile="sim_${w}_workers.txt"
  timeout -sHUP 7m java -cp ./tla2tools-faster-progress.jar tlc2.TLC -simulate -depth 50 -workers $w -config MC.cfg MC.tla | tee $outfile
  grep "states checked" $outfile > "states_generated_${w}_workers.txt"
done

# Generate final stats.
printf "" > stats.txt
for f in states_generate*.txt; do
	printf $f >> stats.txt
	printf "," >> stats.txt
	grep -m 5 "states checked" $f | tail -n 1 | sed -E "s/Progress: (.*) states checked./\1/" >> stats.txt
done