dataset = ARGV[0]
deltas = ARGV[1..ARGV.size-1].map{|d| d.to_f}
edges = []
open "#{dataset}/#{dataset}_hsa_string.txt" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.map{|p| p.strip}
		edges << {:from => parts[0], :to => parts[1], :weight => parts[2]}
	end
end

deltas.each do |delta|
	open "#{dataset}/#{dataset}_hsa_delta#{delta}.txt", "w" do |f|
		lines.each do |line|
			prob = line[2].to_f
			max = prob + delta > 1.0 ? 1.0 : prob + delta
			min = prob - delta < 0.0 ? 0.0 : prob - delta
			line[2] = min + rand * (max - min)
			f.puts line.join " "
		end
	end
end