dataset = ARGV[0]
edges = []
nodes = []

open "#{dataset}/#{dataset}_hsa_string.txt" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.map{|p| p.strip}
		edges << parts
		nodes << parts[0] unless nodes.include? parts[0]
		nodes << parts[1] unless nodes.include? parts[1]
	end
end

nodes.each do |node|
	nodename = node.gsub("|", "&").gsub(":", "_")
	nodename = "#{nodename[0..80]}..." if nodename.length > 84
	open "#{dataset}/missing-#{nodename}.txt", "w" do |f|
		edges.each do |edge|
			f.puts edge.join " " unless edge.include? node
		end
	end
end