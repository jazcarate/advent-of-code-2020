require "./main.cr"

lines = File.read_lines("src/3/input.txt")

puts "First part"
puts solve_3_1(lines)

puts "Second part"
puts solve_3_2(lines)
