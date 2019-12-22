set datafile separator ',';
set key autotitle columnhead;
set terminal svg; 
set style data lines; 
set style line 1 \
    linecolor rgb '#0060ad' \
    linetype 1 linewidth 1 \
    pointtype 7 pointsize 0.5
set xlabel "# TLC Workers"
set ylabel "States/Minute"
set xtics 0,2,48
set xrange [0:48]
set grid
set title "Multi-threaded TLC Simulation Mode Scaling"
plot 'stats.csv' with linespoints linestyle 1 title 'States/Minute'