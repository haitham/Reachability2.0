dataset = ARGV[0]
start_version = ARGV[1].to_i
end_version = ARGV[2].to_i
#deltas = ARGV[2..ARGV.size-1].map{|d| d.to_f}
deltas = (1..ARGV[3].to_i).map{|i| ARGV[4].to_f*i}

start_version.upto end_version do |i|
	puts "running version #{i}"
	`rm #{dataset}/#{dataset}_hsa_delta*.txt` unless Dir.glob("#{dataset}/#{dataset}_hsa_delta*.txt").empty?
	`rm #{dataset}/delta*.out` unless Dir.glob("#{dataset}/delta*.out").empty?
	`rm #{dataset}/summary#{i}.out` unless Dir.glob("#{dataset}/summary#{i}.out").empty?
	
	puts "ruby delta.rb #{dataset} #{ARGV[3]} #{ARGV[4]}"
	`ruby delta.rb #{dataset} #{ARGV[3]} #{ARGV[4]}`
	
	puts "ruby experiment.rb #{dataset} #{deltas.join " "}"
	`ruby experiment.rb #{dataset} #{deltas.join " "}`
	
	puts "ruby tabulate.rb #{dataset} #{i}"
	`ruby tabulate.rb #{dataset} #{i}`
end
