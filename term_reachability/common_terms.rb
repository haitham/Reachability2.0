wnt = {}
open "wnt/results.out" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		term, prob = line.strip.split.map{|p| p.strip}
		wnt[term] = prob
	end
end

common = []
open "erbb/results.out" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		term, prob = line.strip.split.map{|p| p.strip}
		common << {:term => term, :erbb => prob, :wnt => wnt[term]} unless wnt[term].nil?
	end
end

open "common.out", "w" do |f|
	f.puts "#{sprintf "%-12s", "#term"}#{sprintf "%-14s", "erbb"}wnt"
	common.each{|record| f.puts "#{sprintf "%-12s", record[:term]}#{sprintf "%-14s", record[:erbb]}#{record[:wnt]}"}
end