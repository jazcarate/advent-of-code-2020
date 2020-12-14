require "./main.cr"

target, needle = File.read_lines("src/13/input.txt")

puts "First part"
puts solve_13_1(target, needle)

puts "Second part"
puts solve_13_2(needle)
