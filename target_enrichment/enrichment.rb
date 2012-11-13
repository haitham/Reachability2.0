targets_file = ARGV[0]
terms_file = ARGV[1]
@annotations = {}
@targets = []
@terms = []


def success_count(term, top_size)
	success = 0
	0.upto(top_size-1) do |i|
		success = success + 1 if @annotations[@targets[i]].include? term
	end
	success
end

line = ""
open targets_file do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		@targets << line.strip
	end
end

open terms_file do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.collect{|p| p.strip}
		target = parts[0].split(/targets/).last.split(".").first
		@annotations[target] = parts[1..parts.size]
		@terms |= @annotations[target]
	end
end

