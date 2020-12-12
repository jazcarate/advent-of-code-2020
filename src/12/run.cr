require "./main.cr"

input = File.read_lines("src/12/input.txt")

puts "First part"
puts solve_12_1(input)

puts "Second part"
puts solve_12_2(input)
