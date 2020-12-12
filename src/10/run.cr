require "./main.cr"

input = File.read_lines("src/10/input.txt").map &.to_i

puts "First part"
puts solve_10_1(input)

puts "Second part"
puts solve_10_2(input)
