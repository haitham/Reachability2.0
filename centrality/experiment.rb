dataset = ARGV[0]
sources = Dir.glob("#{dataset}/#{dataset}_hsa_sources*.txt").map{|file| file.split("sources").last.split(".").first.to_i}.sort
targets = Dir.glob("#{dataset}/#{dataset}_hsa_targets*.txt").map{|file| file.split("targets").last.split(".").first.to_i}.sort
reference = {}

sources.each do |source|
	reference[source] = {}
	targets.each do |target|
		puts "Running: reference from #{source} to #{target}"
		output = `./Graph #{dataset}/#{dataset}_hsa_string.txt #{dataset}/#{dataset}_hsa_sources#{source}.txt #{dataset}/#{dataset}_hsa_targets#{target}.txt pmc pre`
		reference[source][target] = output.split(">>").last.strip.to_f
	end
end

nodes = Dir.glob("#{dataset}/missing-*.txt").map{|file| file.split("missing-").last.split(".txt").first}
values = {}
nodes.each do |node|
	values[node] = 0.0
	sources.each do |source|
		targets.each do |target|
			puts "Running: missing-#{node} from #{source} to #{target}"
			output = `./Graph "#{dataset}/missing-#{node}.txt" #{dataset}/#{dataset}_hsa_sources#{source}.txt #{dataset}/#{dataset}_hsa_targets#{target}.txt pmc pre`
			new_value = output.split(">>").last.strip.to_f
			values[node] = values[node] + reference[source][target] - new_value
		end
	end
end

open "#{dataset}/results.out", "w" do |f|
	values.map{|k,v| [k,v]}.sort{|a,b| b[1] <=> a[1]}.each{|p| f.puts "#{sprintf "%-12f", p[1]}#{"  "}#{p[0]}"}
end
