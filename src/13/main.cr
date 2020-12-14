def solve_13_1(target, needle)
  i = target.to_i
  buses = needle
    .split(/,/)
    .reject("x")
    .map &.to_i

  selected, time = buses
    .map { |bus| {bus, ((i // bus) + 1) * bus} }
    .min_by { |_, v| v }

  selected * (time - i)
end

def solve_13_2(needle)
  false
end
