reset
set size 0.6,0.6
set term postscript eps enhanced

#Reachability vs rank
set xlabel "Rank"
set ylabel "Reachability Probability"
set output "reach_rank.eps"
plot "erbb/results.out" using 2 with point title "ErbB" pt 2,\
	 "wnt/results.out" using 2 with point title "Wnt" pt 6
set output
!epstopdf reach_rank.eps

#Reachability of a term in ErbB vs Wnt
set xlabel "Reachability in ErbB"
set ylabel "Reachability in Wnt"
set output "erbb_wnt.eps"
plot "common.out" using 2:3 with point title "" pt 6,\
	 x title ""
set output
!epstopdf erbb_wnt.eps

#Reachability vs Enrichment
set xlabel "Reachability Probability"
set ylabel "-ve Log Enrichment"
set yrange [-0.1:5.5]
set key left
set output "reach_enrich.eps"
plot "erbb/reach_enrich.out" using 2:3 with point title "ErbB" pt 2,\
	 "wnt/reach_enrich.out" using 2:3 with point title "Wnt" pt 6
set output
!epstopdf reach_enrich.eps


