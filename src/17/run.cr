require "./main.cr"

input = File.read_lines("src/17/input.txt")

puts "First part"
puts solve_17_1(input)

puts "Second part"
puts solve_17_2(input)
