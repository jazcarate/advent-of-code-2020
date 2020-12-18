require "big"

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

# Inspired in https://rosettacode.org/wiki/Chinese_remainder_theorem#Crystal
def extended_gcd(a, b)
  last_remainder, remainder = a.abs, b.abs
  x, last_x = 0, 1

  until remainder == 0
    tmp = remainder
    quotient, remainder = last_remainder.divmod(remainder)
    last_remainder = tmp
    x, last_x = last_x - quotient * x, x
  end

  return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, et)
  g, x = extended_gcd(e, et)
  unless g == 1
    raise "Multiplicative inverse modulo does not exist"
  end
  return x % et
end

def chinese_remainder(mods, remainders)
  max = mods.product
  series = remainders.zip(mods).map { |r, m| r * max * invmod(max // m, m) // m }
  return series.sum % max, max
end

def solve_13_2(needle)
  mods = [] of BigInt
  rems = [] of BigInt

  buses = needle
    .split(/,/)
    .each_with_index do |bus, poss|
      if bus != "x"
        mods << bus.to_big_i
        rems << poss.to_big_i
      end
    end

  a, b = chinese_remainder(mods, rems)
  b - a
end
