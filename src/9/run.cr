require "big"

require "./main.cr"

input = File.read_lines("src/9/input.txt").map &.to_big_d

puts "First part"
puts solve_9_1(input)

puts "Second part"
puts solve_9_2(input)
