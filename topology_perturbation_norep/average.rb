dataset = ARGV[0]
deltas = []
values = {}
open "#{dataset}/summary.out" do |f|
	line = f.gets
	parts = line.split.map{|p| p.strip}
	parts[3..parts.size-1].each{|p| deltas << p.split("=").last.strip}
	deltas.each{|d|values[d] = []}
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.map{|p| p.strip}
		deltas.each_with_index{|d,i| values[d] << parts[i+3].to_f}
	end
end

results = 

open "#{dataset}/average.out", "w" do |f|
	f.puts "#{sprintf "%-6s", "#d"}#{sprintf "%-23s", "avg"}#{sprintf "%-23s", "abs_avg"}norm"
	deltas.map{|d|
		[d, values[d].reduce(:+)/values[d].size, values[d].map{|v| v.abs}.reduce(:+)/values[d].size, Math.sqrt(values[d].map{|v| v*v}.reduce(:+))]
	}.each{|r|
		f.puts "#{sprintf "%-6s", r[0]}#{sprintf "%-23s", r[1]}#{sprintf "%-23s", r[2]}#{r[3]}"
	}
end