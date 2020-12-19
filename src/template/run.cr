require "./main.cr"

input = File.read_lines("src/xx/input.txt")

puts "First part"
puts solve_xx_1(input)

puts "Second part"
puts solve_xx_2(input)
