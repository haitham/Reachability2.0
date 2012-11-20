dataset = ARGV[0]
terms = {}
open "#{dataset}/#{dataset}.s.terms.txt" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.map{|p| p.strip}
		parts[1..parts.size-1].each do |term|
			terms[term] ||= {:sources => [], :targets => []}
			terms[term][:sources] << parts[0]
		end
	end
end

open "#{dataset}/#{dataset}.t.terms.txt" do |f|
	until (line = f.gets).nil?
		next if line.strip.empty?
		parts = line.split.map{|p| p.strip}
		parts[1..parts.size-1].each do |term|
			terms[term] ||= {:sources => [], :targets => []}
			terms[term][:targets] << parts[0]
		end
	end
end

terms.each do |term, hash|
	next if hash[:sources].empty? or hash[:targets].empty?
	open "#{dataset}/#{dataset}_#{term}_sources.txt", "w" do |fout|
		hash[:sources].uniq.each do |source|
			open "#{dataset}/#{source}" do |f|
				fout.puts f.gets
			end
		end
	end
	open "#{dataset}/#{dataset}_#{term}_targets.txt", "w" do |fout|
		hash[:targets].uniq.each do |target|
			open "#{dataset}/#{target}" do |f|
				fout.puts f.gets
			end
		end
	end
end