dataset = ARGV[0]
table = []
open "#{dataset}/delta0.out" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.map{|p| p.strip}
		table[parts[0].to_i] ||= []
		table[parts[0].to_i][parts[1].to_i] = {:ref => parts[2].to_f}
	end
end
deltas = Dir.glob("#{dataset}/delta0.*.out").map{|file| file.gsub("#{dataset}/delta", "").gsub(".out", "").to_f}.sort
deltas.each do |delta|
	open "#{dataset}/delta#{delta}.out" do |f|
		until (line = f.gets).nil?
			next if line.strip.empty?
			parts = line.split.map{|p| p.strip}
			s = parts[0].to_i
			t = parts[1].to_i
			table[s][t][delta] = parts[2].to_f - table[s][t][:ref]
		end
	end
end
open "#{dataset}/summary.out", "w" do |f|
	f.puts "#{sprintf "%-5s", "#s"}#{sprintf "%-5s", "t"}#{sprintf "%-11s", "P_ref"}#{deltas.map{|d| sprintf "%-22s", "d=#{d}"}.join}"
	table.each_with_index do |s, i|
		s.each_with_index do |t, j|
			next if t[:ref].zero?
			f.puts "#{sprintf "%-5s", i}#{sprintf "%-5s", j}#{sprintf "%-11s", t[:ref]}#{deltas.map{|d| sprintf "%-22s", t[d]}.join}"
		end
	end
end
