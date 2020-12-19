require "big"

class Rule
  getter name

  def initialize(name : String, ranges : Array(Range(Int32, Int32)))
    @name = name
    @ranges = ranges
  end

  def includes?(value : Int32)
    @ranges.any? { |r| r.includes? value }
  end
end

def rule(line)
  # class: 1-3 or 5-7

  matches = /(.*): (\d+)-(\d+) or (\d+)-(\d+)/.match(line).not_nil!
  Rule.new(matches[1], [(matches[2].to_i)..(matches[3].to_i), (matches[4].to_i)..(matches[5].to_i)])
end

def invalid(ticket, rules)
  ticket.reject { |v| rules.any? { |r| r.includes?(v) } }
end

def invalid?(ticket, rules)
  !invalid(ticket, rules).empty?
end

def solve_16_1(rules_lines, tickets)
  rules = rules_lines.map { |line| rule(line) }
  tickets = tickets.map { |t| t.split(",").map(&.to_i) }

  wrong = tickets.map { |ticket|
    invalid(ticket, rules)
  }
  wrong.flatten.sum
end

def merge(xs, ys)
  xs.zip(ys).map { |x, y| x ? x : y }
end

def solve_16_2_go(rules, values)
  if rules.empty?
    return values.map { |_| nil }
  end

  possible_rules = values.map do |vals|
    rules.select { |r| vals.all? { |v| r.includes? v } } # All the rules that can apply to ever vals
  end

  candidate = possible_rules.map { |rs| rs.size == 1 ? rs : nil }
  candidate_rule = candidate.compact[0][0]

  # print "candidate #{candidate}\n"
  # print "candidate_rule #{candidate_rule}\n"
  # print "rest\t #{rules.reject(candidate_rule)}\n"

  merge(
    candidate,
    solve_16_2_go(rules.reject(candidate_rule), values)
  )
end

def solve_16_2(rules_lines, tickets, mine)
  rules = rules_lines.map { |line| rule(line) }
  mine = mine.split(",").map(&.to_i)
  tickets = tickets.map { |t| t.split(",").map(&.to_i) }

  valid = tickets.reject { |ticket| invalid?(ticket, rules) }

  correct_rules = solve_16_2_go(rules, valid.transpose).map { |r| r.not_nil![0] }.map &.name

  mine.zip(correct_rules)
    .select { |_, name| name.starts_with? "departure" }
    .map { |v, _| v }
    .map(&.to_big_i)
    .product
end
