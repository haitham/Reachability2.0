dataset = ARGV[0]
thresholds = ARGV[1].split(",").map{|t| t.to_f}
deltas = ARGV[2..ARGV.size-1]
versions = []

def avg(numbers)
	numbers.reduce(:+).to_f/numbers.size
end

files = Dir.glob "#{dataset}/summary*.out"
files.each do |file|
	values = {}
	keys = []
	open file do |f|
		line = f.gets
		parts = line.split.map{|p| p.strip}
		parts[3..parts.size-1].each{|p| keys << p.split("=").last.strip}
		keys.each{|d|values[d] = []}
		until (line = f.gets).nil?
			next if line.strip.empty?
			parts = line.split.map{|p| p.strip}
			keys.each_with_index{|d,i| values[d] << parts[i+3].to_f}
		end
	end
	versions << values
end

	
open "#{dataset}/threshold.out", "w" do |f|
	f.puts "#{sprintf "%-6s", "#d"}#{thresholds.map{|t| sprintf "%-23s", "t=#{t}"}.join}"
	deltas.each do |d|
		f.print sprintf("%-6s", d)
		thresholds.each do |t|
			f.print sprintf("%-23s", avg(versions.map{|values| avg(values[d].map{|v| v.abs > t ? 1 : 0})}))
		end
		f.puts
	end
end