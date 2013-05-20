dataset = ARGV[0]
filename = ARGV[1] ||= "nodes_reordered"

row_labels, column_labels = "", ""
matrix = ""
open "#{dataset}/#{filename}.out" do |fin|
	column_labels = "{#{fin.gets.strip.split.map{|l| "'#{l}'"}.join " "}}"
	until (line = fin.gets).nil?
		parts = line.strip.split.map{|p| p.strip}
		row_labels = "#{row_labels} '#{parts[0]}'"
		matrix = "#{matrix}\n#{parts[1..parts.size-1].join " "}"
	end
	row_labels = "{#{row_labels}}"
	matrix = "[#{matrix}]"
end

open "#{dataset}/#{dataset}_#{filename}.m", "w" do |fout|
	fout.puts "RowLabels = #{row_labels}"
	fout.puts "ColumnLabels = #{column_labels}"
	fout.puts "Matrix = #{matrix}"
	fout.puts "HM = HeatMap(Matrix, 'RowLabels', RowLabels, 'ColumnLabels', ColumnLabels, 'Symmetric', false)"
end
