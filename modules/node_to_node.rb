dataset = ARGV[0]
nodes = Dir.glob("#{dataset}/node_*.txt").map{|name| name.split("_").last.split(".").first.to_i}.sort.map{|n| n.to_s}

open "#{dataset}/node_to_node.out", "w" do |fout|
	fout.print sprintf("%-14s", "")
	fout.puts nodes.map{|n| sprintf("%-14s", n)}.join
	nodes.each do |source|
		fout.print sprintf("%-14s", source)
		nodes.each do |target|
			puts "./Graph #{dataset}/#{dataset}_hsa_string.txt #{dataset}/node_#{source}.txt #{dataset}/node_#{target}.txt pmc pre"
			output = `./Graph #{dataset}/#{dataset}_hsa_string.txt #{dataset}/node_#{source}.txt #{dataset}/node_#{target}.txt pmc pre`
			prob = output.split(">>").last.strip
			fout.print sprintf("%-14s", prob[0..8])
		end
		fout.puts
	end
end