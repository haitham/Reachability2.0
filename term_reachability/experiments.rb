dataset = ARGV[0]
results = []
Dir.glob "#{dataset}/#{dataset}_*_sources.txt" do |sourcefile|
	term = sourcefile.split("_sources").first.split("_").last
	targetfile = sourcefile.gsub "sources", "targets"
	puts term
	output = `./Graph #{dataset}/#{dataset}_hsa_string.txt #{sourcefile} #{targetfile} pmc pre`
	results << {:term => term, :prob => output.split(">>").last.strip}
end
open "#{dataset}/results.out", "w" do |fout|
	results.sort{|a,b| b[:prob] <=> a[:prob]}.each{|r| fout.puts "#{sprintf "%-10s", r[:term]}#{r[:prob]}"}
end