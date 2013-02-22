dataset = ARGV[0]
prob_order = {}
det_order = {}
prob_rank = {}
det_rank = {}
reverse = {}
nonconformity = {}
proteins = []
open "#{dataset}/results.out" do |f|
	current_score = 99999999.0
	current_rank = 0
	counter = 0
	until (line = f.gets).nil?
		next if line.strip.empty?
		counter = counter + 1
		score, protein = line.split.map{|p| p.strip}
		proteins << protein
		prob_order[protein] = counter
		if score.to_f < current_score
			current_score = score.to_f
			current_rank = counter
		end
		prob_rank[protein] = current_rank
	end
end
open "#{dataset}/betweenness.out" do |f|
	current_score = 99999999.0
	current_rank = 0
	counter = 0
	until (line = f.gets).nil?
		next if line.strip.empty?
		counter = counter + 1
		score, protein = line.split.map{|p| p.strip}
		det_order[protein] = counter
		if score.to_f < current_score
			current_score = score.to_f
			current_rank = counter
		end
		det_rank[protein] = current_rank
	end
end
proteins.each do |protein|
	reverse[protein] = proteins.map{|p|
		(det_rank[protein] - det_rank[p]) * (prob_rank[protein] - prob_rank[p]) < 0
	}.count(true).to_f / proteins.size.to_f
	nonconformity[protein] = proteins.map{|p|
		((det_rank[protein] - det_rank[p]) - (prob_rank[protein] - prob_rank[p])).abs
	}.reduce(:+).to_f / proteins.size.to_f
end
open "#{dataset}/misbehaviour.out", "w" do |f|
	f.puts "#{sprintf "%-8s", "#POrder"}#{sprintf "%-7s", "PRank"}#{sprintf "%-8s", "DOrder"}#{sprintf "%-7s", "DRank"}#{sprintf "%-12s", "reverse"}#{sprintf "%-14s", "nonconformity"}protein"
	proteins.each do |p|
		f.puts "#{sprintf "%-8d", prob_order[p]}#{sprintf "%-7d", prob_rank[p]}#{sprintf "%-8d", det_order[p]}#{sprintf "%-7d", det_rank[p]}#{sprintf "%-12f", reverse[p]}#{sprintf "%-14f", nonconformity[p]}#{p}"
	end
end








