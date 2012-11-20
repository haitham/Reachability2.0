dataset = ARGV[0]
deltas = ARGV[1..ARGV.size-1]

sources = Dir.glob("#{dataset}/#{dataset}_hsa_sources*.txt").map{|file| file.split("sources").last.split(".").first.to_i}.sort
targets = Dir.glob("#{dataset}/#{dataset}_hsa_targets*.txt").map{|file| file.split("targets").last.split(".").first.to_i}.sort

deltas.each do |delta|
	open "#{dataset}/delta#{delta}.out", "w" do |f|
		sources.each do |source|
			targets.each do |target|
				puts "./Graph #{dataset}/#{dataset}_hsa_delta#{delta}.txt #{dataset}/#{dataset}_hsa_sources#{source}.txt #{dataset}/#{dataset}_hsa_targets#{target}.txt pmc pre"
				output = `./Graph #{dataset}/#{dataset}_hsa_delta#{delta}.txt #{dataset}/#{dataset}_hsa_sources#{source}.txt #{dataset}/#{dataset}_hsa_targets#{target}.txt pmc pre`
				f.puts "#{sprintf "%-5d", source}#{sprintf "%-5d", target}#{output.split(">>").last.strip}"
			end
		end
	end
end
