dataset = ARGV[0]
deltas = ARGV[1..ARGV.size-1].map{|d| d.to_f}
lines = []
open "#{dataset}/#{dataset}_hsa_string.txt" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		lines << line.split.map{|p| p.strip}
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