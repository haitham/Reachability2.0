dataset = ARGV[0]

order = []
matrix = []
open("#{dataset}/node_order.txt"){|f| order = f.gets.split.map{|n| n.to_i}}
open "#{dataset}/node_to_node.out" do |f|
	f.gets
	order.size.times{matrix << f.gets.split[1..order.size]}
end

middle = order.map{|o| matrix[o]}.transpose
final = order.map{|o| middle[o]}.transpose

open "#{dataset}/nodes_reordered.out", "w" do |fout|
	fout.print sprintf("%-14s", "")
	fout.puts order.map{|o| sprintf("%-14d", o)}.join
	final.each_with_index do |row, i|
		fout.print sprintf("%-14d", order[i])
		fout.puts row.map{|r| sprintf("%-14s", r)}.join
	end
end