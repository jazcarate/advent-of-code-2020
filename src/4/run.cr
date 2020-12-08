require "./main.cr"

input = File.read_lines("src/4/input.txt")

puts "First part"
puts solve_4_1(input)

puts "Second part"
puts solve_4_2(input)
