infile = ARGV[0]
outfile = ARGV[1]
targets = []
open infile do |f|
	line = ""
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.collect{|p| p.strip}
		targets << [parts[1], parts[2]]
	end
end

targets.sort!{|a,b| b[1] <=> a[1]}

open outfile, "w", do |f|
	targets.each{|t| f.puts t[0]}
end