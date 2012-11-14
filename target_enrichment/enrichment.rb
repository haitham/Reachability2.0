targets_file = ARGV[0]
terms_file = ARGV[1]
output_file = ARGV[2]
@annotations = {}
@targets = []
@terms = []
@results = []
@annotation_maps = {}

#targets annotation map of a given term
def annotations_map(term)
	@annotation_maps[term] ||= 0.upto(@targets.size-1).map{|i| @annotations[@targets[i]].include?(term) ? 1 : 0}
end

#number of annotations in the top_size targets for the given term
def annotations_count(term, top_size)
	annotations_map(term)[0..top_size-1].reduce(:+)
end

#ln (n P r)
def log_perm(n, r)
	0.upto(r-1).reduce(0){|r, i| r = r + Math.log(n-i)}
end

#ln (n C r)
def log_comb(n, r)
	log_perm(n, r) - log_perm(r, r)
end

#Hypergeometric P(X = selected_true | universe, universal_true, selection)
def hypergeometric(universe, draw, partition, success)
	Math.exp(log_comb(partition, success) + log_comb(universe-partition, draw-success) - log_comb(universe, draw))
end

#Enrichment of a term using a given top_size
def enrichment(term, top_size)
	annotations_count(term, top_size).upto(top_size).map{|success|
		hypergeometric @targets.size, annotations_count(term, @targets.size), top_size, success
	}.reduce(:+)
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

@terms.each do |term|
	@results << 1.upto(@targets.size-1).map{|top_size|
		{:term => term, :top_size => top_size, :enrichment => enrichment(term, top_size)}
	}.reduce{|best, current| best[:enrichment] > current[:enrichment] ? current : best}
end

open output_file, "w" do |f|
	@results.sort{|a,b| a[:enrichment] <=> b[:enrichment]}.each{|r| f.puts "#{sprintf("%-10s", r[:term])}#{sprintf("%-24s", r[:enrichment])}#{sprintf("%-5s", r[:top_size])}#{sprintf("%-4s", annotations_count(r[:term], @targets.size))}#{annotations_map(r[:term]).join}"}
end













