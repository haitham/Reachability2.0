dataset = ARGV[0]

sources = []
targets = []
Dir.glob("#{dataset}/#{dataset}_hsa_sources*.txt").each do |filename|
	open filename do |f|
		sources << f.gets.strip
	end
end
Dir.glob("#{dataset}/#{dataset}_hsa_targets*.txt").each do |filename|
	open filename do |f|
		targets << f.gets.strip
	end
end

paths = {}
total_scores = {}
open "#{dataset}/#{dataset}_hsa_string.txt.dijkstra.out" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.map{|p| p.strip}
		paths[parts[0]] = parts[1] || "&"
		from, to = parts[0].split "&"
		total_scores[from] ||= 0.0
		total_scores[to] ||= 0.0
	end
end

sources.each do |s|
	targets.each do |t|
		st_paths = paths["#{s}&#{t}"]
		puts "PAIR NOT FOUND #{s}&#{t}" if st_paths.nil?
		scores = {}
		st_paths = st_paths.split "&"
		st_paths.each do |path|
			path.split("=>").each do |node|
				scores[node] = (scores[node] || 0.0) + 1.0
			end
		end
		scores.each{|node, score| total_scores[node] = total_scores[node] + score/st_paths.size}
	end
end

open "#{dataset}/betweenness.out", "w" do |f|
	total_scores.map{|k,v| {:node => (k.length > 84 ? "#{k[0..80]}..." : k), :score => v}}.sort{|a,b| b[:score] <=> a[:score]}.each do |record|
		f.puts "#{sprintf "%-12f", record[:score]}  #{record[:node].gsub(":", "_").gsub("|", "&")}"
	end
end