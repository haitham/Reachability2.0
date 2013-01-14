dataset = ARGV[0]
deltas = ARGV[1..ARGV.size-1].map{|d| d.to_f}
original_edges = []
open "#{dataset}/#{dataset}_hsa_string.txt" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.map{|p| p.strip}
		original_edges << {:from => parts[0], :to => parts[1], :weight => parts[2]}
	end
end

deltas.each do |delta|
	edges = original_edges.clone
	shuffled = []
	1.upto (delta*original_edges.size/2).ceil do
		while true
			index1 = rand*edges.size
			edge1 = edges.delete_at index1
			index2 = rand*edges.size
			edge2 = edges.delete_at index2
			if edges.map{|e|
				(e[:from] == edge1[:from] and e[:to] == edge2[:to]) or (e[:from] == edge2[:from] and e[:to] == edge1[:to])
			}.any?
				edges.insert index2, edge2
				edges.insert index1, edge1
				next
			end
			rand > 0.5 ? (edge1[:from], edge2[:from] = edge2[:from], edge1[:from]) : (edge1[:to], edge2[:to] = edge2[:to], edge1[:to])
			shuffled << edge1 << edge2
			break
		end
	end
	open "#{dataset}/#{dataset}_hsa_delta#{delta}.txt", "w" do |f|
		(edges+shuffled).each{|e| f.puts "#{e[:from]} #{e[:to]} #{e[:weight]}"}
	end
end