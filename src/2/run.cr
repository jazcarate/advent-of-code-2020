require "./main.cr"


lines = File.read_lines("src/2/input.txt")

puts "First part"
puts solve_2_1(lines)

puts "Second part"
puts solve_2_2(lines)
