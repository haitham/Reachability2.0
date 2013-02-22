#set yrange [-5:70]
#plot 	"erbb_results.out" u 1 w l, \
#	"mapk_results.out" u 1 w l,\
#	"wnt_results.out"  u 1 w l

unset xrange
unset yrange

set key center top
set xlabel "Centrality Rank"

##Monochrome PDF versions

set term postscript eps enhanced

#ErbB

set xrange [0:45]

set ylabel "Rank Disagreement"
set output "erbb/order_disagreement.eps"
plot "erbb/misbehaviour.out" u 1:5 t "Prob. Centrality" w p, \
	"" u 3:5 t "Det. Centrality" w p
set output
!epstopdf erbb/order_disagreement.eps

set ylabel "Avg Rank Difference"
set output "erbb/order_difference.eps"
plot "erbb/misbehaviour.out" u 1:6 t "Prob. Centrality" w p, \
	"" u 3:6 t "Det. Centrality" w p
set output
!epstopdf erbb/order_difference.eps

#MAPK

set xrange [0:70]

set ylabel "Rank Disagreement"
set output "mapk/order_disagreement.eps"
plot "mapk/misbehaviour.out" u 1:5 t "Prob. Centrality" w p, \
	"" u 3:5 t "Det. Centrality" w p
set output
!epstopdf mapk/order_disagreement.eps

set ylabel "Avg Rank Difference"
set output "mapk/order_difference.eps"
plot "mapk/misbehaviour.out" u 1:6 t "Prob. Centrality" w p, \
	"" u 3:6 t "Det. Centrality" w p
set output
!epstopdf mapk/order_difference.eps

#Wnt

set xrange [0:30]

set ylabel "Rank Disagreement"
set output "wnt/order_disagreement.eps"
plot "wnt/misbehaviour.out" u 1:5 t "Prob. Centrality" w p, \
	"" u 3:5 t "Det. Centrality" w p
set output
!epstopdf wnt/order_disagreement.eps

set ylabel "Avg Rank Difference"
set output "wnt/order_difference.eps"
plot "wnt/misbehaviour.out" u 1:6 t "Prob. Centrality" w p, \
	"" u 3:6 t "Det. Centrality" w p
set output
!epstopdf wnt/order_difference.eps


##Color PNG versions

set term png size 1280,960 transparent truecolor linewidth 3 24

#ErbB

set xrange [0:45]

set ylabel "Rank Disagreement"
set output "erbb/order_disagreement.png"
plot "erbb/misbehaviour.out" u 1:5 t "Prob. Centrality" w p ps 2, \
	"" u 3:5 t "Det. Centrality" w p ps 2
set output

set ylabel "Avg Rank Difference"
set output "erbb/order_difference.png"
plot "erbb/misbehaviour.out" u 1:6 t "Prob. Centrality" w p ps 2, \
	"" u 3:6 t "Det. Centrality" w p ps 2
set output

#MAPK

set xrange [0:70]

set ylabel "Rank Disagreement"
set output "mapk/order_disagreement.png"
plot "mapk/misbehaviour.out" u 1:5 t "Prob. Centrality" w p ps 2, \
	"" u 3:5 t "Det. Centrality" w p ps 2
set output

set ylabel "Avg Rank Difference"
set output "mapk/order_difference.png"
plot "mapk/misbehaviour.out" u 1:6 t "Prob. Centrality" w p ps 2, \
	"" u 3:6 t "Det. Centrality" w p ps 2
set output

#Wnt

set xrange [0:30]

set ylabel "Rank Disagreement"
set output "wnt/order_disagreement.png"
plot "wnt/misbehaviour.out" u 1:5 t "Prob. Centrality" w p ps 2, \
	"" u 3:5 t "Det. Centrality" w p ps 2
set output

set ylabel "Avg Rank Difference"
set output "wnt/order_difference.png"
plot "wnt/misbehaviour.out" u 1:6 t "Prob. Centrality" w p ps 2, \
	"" u 3:6 t "Det. Centrality" w p ps 2
set output
