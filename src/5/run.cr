require "./main.cr"

input = File.read_lines("src/5/input.txt")

puts "First part"
puts solve_5_1(input)

puts "Second part"
puts solve_5_2(input)
