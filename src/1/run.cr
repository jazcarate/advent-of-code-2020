require "./main.cr"

lines = File.read_lines("src/1/input.txt")
report = lines.map { |str| str.to_i }


puts "First part"
puts solve_1_1(report)

puts "Second part"
puts solve_1_2(report)