dataset = ARGV[0]
thresholds = ARGV[1..ARGV.size-1].map{|t| t.to_f}
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

open "#{dataset}/threshold.out", "w" do |f|
	f.puts "#{sprintf "%-6s", "#d"}#{thresholds.map{|t| sprintf "%-23s", "t=#{t}"}.join}"
	deltas.map{|d|
		thresholds.map{|t| 1.0 * values[d].map{|v| v.abs > t ? 1 : 0}.reduce(:+) / values[d].size}
	}.each_with_index{|numbers, i|
		f.puts "#{sprintf "%-6s", deltas[i]}#{numbers.map{|n| sprintf "%-23s", n}.join}"
	}
end