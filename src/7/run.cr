require "./main.cr"

input = File.read_lines("src/7/input.txt")

puts "First part"
puts solve_7_1(input)

puts "Second part"
puts solve_7_2(input)
