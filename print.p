set datafile separator ","

set xlabel "time" 
set ylabel "sequence" 

set xtics rotate

set format y '%.0f'
set format x '%.0f'

set xtics 2
set ytics 2

plot "output/out.csv" with lines
