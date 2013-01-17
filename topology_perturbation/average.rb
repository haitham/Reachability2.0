dataset = ARGV[0]
deltas = ARGV[1..ARGV.size-1]
versions = []

def avg(numbers)
	numbers.reduce(:+)/numbers.size
end

def abs_avg(numbers)
	avg numbers.map{|n| n.abs}
end

def norm(numbers)
	Math.sqrt numbers.map{|n| n*n}.reduce(:+)
end

files = Dir.glob "#{dataset}/summary*.out"
files.each do |file|
	keys = []
	values = {}
	open file do |f|
		line = f.gets
		parts = line.split.map{|p| p.strip}
		parts[3..parts.size-1].each{|p| keys << p.split("=").last.strip}
		keys.each{|k| values[k] = []}
		until (line = f.gets).nil?
			next if line.strip.empty?
			parts = line.split.map{|p| p.strip}
			keys.each_with_index{|k,i| values[k] << parts[i+3].to_f}
		end
	end
	versions << values
end
	
open "#{dataset}/average.out", "w" do |f|
	f.puts "#{sprintf "%-6s", "#d"}#{sprintf "%-23s", "avg"}#{sprintf "%-23s", "abs_avg"}norm"
	deltas.each do |d|
		f.puts "#{sprintf "%-6s", d}#{sprintf "%-23s", avg(versions.map{|v| avg(v[d])})}#{sprintf "%-23s", avg(versions.map{|v| abs_avg(v[d])})}#{avg(versions.map{|v| norm(v[d])})}"
	end
end