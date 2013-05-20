dataset = ARGV[0]

enrich = {}
open "../target_enrichment/#{dataset}_enrichment.out" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		term, prob = line.strip.split.map{|p| p.strip}
		enrich[term] = -1.0 * Math.log(prob.to_f)
	end
end

common = []
open "#{dataset}/results.out" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		term, prob = line.strip.split.map{|p| p.strip}
		common << {:term => term, :reach => prob, :enrich => enrich[term]} unless enrich[term].nil?
	end
end

open "#{dataset}/reach_enrich.out", "w" do |f|
	f.puts "#{sprintf "%-12s", "#term"}#{sprintf "%-14s", "reachability"}enrichment"
	common.each{|record| f.puts "#{sprintf "%-12s", record[:term]}#{sprintf "%-14s", record[:reach]}#{record[:enrich]}"}
end