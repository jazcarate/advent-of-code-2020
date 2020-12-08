require "./main.cr"

input = File.read_lines("src/6/input.txt")

puts "First part"
puts solve_6_1(input)

puts "Second part"
puts solve_6_2(input)
