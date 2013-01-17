dataset = ARGV[0]
#deltas = ARGV[1..ARGV.size-1].map{|d| d.to_f}
deltas = (1..ARGV[1].to_i).map{|i| ARGV[2].to_f*i}
edges = []
open "#{dataset}/#{dataset}_hsa_string.txt" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.map{|p| p.strip}
		edges << {:from => parts[0], :to => parts[1], :weight => parts[2]}
	end
end

shuffled = 0
deltas.each do |delta|
	while shuffled < ((delta.to_f*edges.size).ceil) do
		while true
			edge1 = edges[rand*edges.size]
			edge2 = edges[rand*edges.size]
			next if edges.map{|e|
				(e[:from] == edge1[:from] and e[:to] == edge2[:to]) or (e[:from] == edge2[:from] and e[:to] == edge1[:to])
			}.any?
			rand > 0.5 ? (edge1[:from], edge2[:from] = edge2[:from], edge1[:from]) : (edge1[:to], edge2[:to] = edge2[:to], edge1[:to])
			shuffled = shuffled + 2
			break
		end
	end
	open "#{dataset}/#{dataset}_hsa_delta#{delta}.txt", "w" do |f|
		edges.each{|e| f.puts "#{e[:from]} #{e[:to]} #{e[:weight]}"}
	end
end