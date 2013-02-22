set key right
set size 0.6,0.6
set style function linespoints
set xlabel "delta"
set terminal postscript eps  enhanced
set xrange [0.04:0.32] noreverse

set ylabel "average reachability change"

set key top
set yrange [-0.6:0.01]
set output "avg.eps"
plot "wnt/average.out" using 1:2 with line smooth unique title "Wnt",\
	 "mapk/average.out" using 1:2 with line smooth unique title "MAPK",\
	 "erbb/average.out" using 1:2 with line smooth unique title "ErbB"
set output
!epstopdf avg.eps

set key bottom
set yrange [0.0:0.6]
set output "abs_avg.eps"
plot "erbb/average.out" using 1:3 with line smooth unique title "ErbB",\
	 "mapk/average.out" using 1:3 with line smooth unique title "MAPK",\
	 "wnt/average.out" using 1:3 with line smooth unique title "Wnt"
set output
!epstopdf abs_avg.eps

set key bottom
set yrange [0.0:6.5]
set output "norm.eps"
plot "erbb/average.out" using 1:4 with line smooth unique title "ErbB",\
	 "mapk/average.out" using 1:4 with line smooth unique title "MAPK",\
	 "wnt/average.out" using 1:4 with line smooth unique title "Wnt"
set output
!epstopdf norm.eps



set ylabel "Percentage of changes exceeding threshold"

set key bottom
set yrange [0.25:1.0]
set output "threshold0.05.eps"
plot "erbb/threshold.out" using 1:2 with line smooth unique title "ErbB",\
	 "mapk/threshold.out" using 1:2 with line smooth unique title "MAPK",\
	 "wnt/threshold.out" using 1:2 with line smooth unique title "Wnt"
set output
!epstopdf threshold0.05.eps

set key bottom
set yrange [0.0:1.0]
set output "threshold0.1.eps"
plot "erbb/threshold.out" using 1:3 with line smooth unique title "ErbB",\
	 "mapk/threshold.out" using 1:3 with line smooth unique title "MAPK",\
	 "wnt/threshold.out" using 1:3 with line smooth unique title "Wnt"
set output
!epstopdf threshold0.1.eps

set key bottom
set yrange [0.0:1.0]
set output "threshold0.15.eps"
plot "erbb/threshold.out" using 1:4 with line smooth unique title "ErbB",\
	 "mapk/threshold.out" using 1:4 with line smooth unique title "MAPK",\
	 "wnt/threshold.out" using 1:4 with line smooth unique title "Wnt"
set output
!epstopdf threshold0.15.eps

set key bottom
set yrange [0.0:1.0]
set output "threshold0.2.eps"
plot "erbb/threshold.out" using 1:5 with line smooth unique title "ErbB",\
	 "mapk/threshold.out" using 1:5 with line smooth unique title "MAPK",\
	 "wnt/threshold.out" using 1:5 with line smooth unique title "Wnt"
set output
!epstopdf threshold0.2.eps

set key bottom
set yrange [0.0:1.0]
set output "threshold0.25.eps"
plot "erbb/threshold.out" using 1:6 with line smooth unique title "ErbB",\
	 "mapk/threshold.out" using 1:6 with line smooth unique title "MAPK",\
	 "wnt/threshold.out" using 1:6 with line smooth unique title "Wnt"
set output
!epstopdf threshold0.25.eps


##Color PNG versions

set term png size 1280,960 transparent truecolor linewidth 3 24
set size 1,1
set xlabel "edge probability change"
set ylabel "average reachability change"
set key top
set yrange [-0.6:0.01]
set output "avg.png"
plot "wnt/average.out" using 1:2 with line smooth unique title "Wnt",\
	 "mapk/average.out" using 1:2 with line smooth unique title "MAPK",\
	 "erbb/average.out" using 1:2 with line smooth unique title "ErbB"
set output



