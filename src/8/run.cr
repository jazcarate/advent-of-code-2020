require "./main.cr"

input = File.read_lines("src/8/input.txt")

puts "First part"
puts solve_8_1(input)

puts "Second part"
puts solve_8_2(input)
