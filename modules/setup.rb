dataset = ARGV[0]

#set up individual-node input files
open "#{dataset}/#{dataset}_hsa_string.txt" do |fin|
	index = {}
	counter = 0
	until (line = fin.gets).nil?
		next if line.strip.empty?
		s, t, p = line.strip.split.map{|m| m.strip}
		if index[s].nil?
			open("#{dataset}/node_#{counter}.txt", "w"){|fout| fout.puts s}
			index[s] = counter
			counter = counter + 1
		end
		if index[t].nil?
			open("#{dataset}/node_#{counter}.txt", "w"){|fout| fout.puts t}
			index[t] = counter
			counter = counter + 1
		end
	end
end

#set up GO-term files
terms = {}
open "#{dataset}/#{dataset}.t.terms.txt" do |fin|
	until (line = fin.gets).nil?
		next if line.strip.empty?
		parts = line.strip.split.map{|m| m.strip}
		target_file = parts[0]
		target_terms = parts[1..parts.size-1]
		target = nil
		open("#{dataset}/#{target_file}"){|f| target = f.gets.strip}
		target_terms.each do |t|
			terms[t] ||= []
			terms[t] << target
		end
	end
end

terms.each do |term, targets|
	open("#{dataset}/go_#{term}.txt", "w"){|f| targets.each{|t| f.puts t}}
end