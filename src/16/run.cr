require "./main.cr"

rules = File.read_lines("src/16/input_rules.txt")
tickets = File.read_lines("src/16/input_tickets.txt")
mine = File.read("src/16/input_my_ticket.txt")

puts "First part"
puts solve_16_1(rules, tickets)

puts "Second part"
puts solve_16_2(rules, tickets, mine)
