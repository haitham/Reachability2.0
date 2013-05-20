dataset = ARGV[0]
type = ARGV[1] ||= "node"

row_labels, column_labels = "", ""
matrix = ""
colormap = ""
open "#{dataset}/node_to_#{type}.out" do |fin|
	column_labels = "{#{fin.gets.strip.split.map{|l| "'#{l}'"}.join " "}}"
	row_counter = 0
	until (line = fin.gets).nil?
		row_counter = row_counter + 1
		parts = line.strip.split.map{|p| p.strip}
		row_labels = "#{row_labels} '#{parts[0]}'"
		matrix = "#{matrix}\n#{parts[1..parts.size-1].join " "}"
	end
	row_counter.times do |i|
		color_row = 3.times.map{1.0 - i.to_f/row_counter.to_f}.join(" ")
		colormap = "#{colormap}\n#{color_row}"
	end
	row_labels = "{#{row_labels}}"
	matrix = "[#{matrix}]"
	colormap = "[#{colormap}]"
end

open "#{dataset}/#{dataset}_#{type}.m", "w" do |fout|
	fout.puts "RowLabels = #{row_labels}"
	fout.puts "ColumnLabels = #{column_labels}"
	fout.puts "Matrix = #{matrix}"
	fout.puts "ColorMap = #{colormap}"
	fout.puts "CG = clustergram(Matrix, 'RowLabels', RowLabels, 'ColumnLabels', ColumnLabels, 'Symmetric', false, 'ColorMap', ColorMap)"
end
