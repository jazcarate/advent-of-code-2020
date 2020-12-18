require "./main.cr"

input = File.read_lines("src/14/input.txt")

puts "First part"
puts solve_14_1(input)

puts "Second part"
puts solve_14_2(input)
