require "./main.cr"

input = File.read_lines("src/11/input.txt")

puts "First part"
puts solve_11_1(input)

puts "Second part"
puts solve_11_2(input)
