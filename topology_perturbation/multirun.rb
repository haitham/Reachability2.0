dataset = ARGV[0]
runs = ARGV[1].to_i
deltas = ARGV[1..ARGV.size-1].map{|d| d.to_f}

1.upto runs do |i|
	puts "running version #{i}"
	`rm #{dataset}/#{dataset}_hsa_delta*.txt` unless Dir.glob("#{dataset}/#{dataset}_hsa_delta*.txt").empty?
	`rm #{dataset}/delta*.out` unless Dir.glob("#{dataset}/delta*.out").empty?
	
	`ruby delta.rb #{dataset} #{deltas.join " "}`
	`ruby experiment.rb #{dataset} #{deltas.join " "}`
	`ruby tabulate.rb #{dataset} #{i}`
end
