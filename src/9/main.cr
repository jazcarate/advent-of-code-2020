def remove_one(ls, x)
  i = ls.index(x)
  if (i.nil?)
    ls
  else
    new_ls = ls.dup
    new_ls.delete_at(i, 1)
    new_ls
  end
end

def is_sum?(value, possibilities)
  possibilities.any? { |p|
    remove_one(possibilities, p).includes? (value - p)
  }
end

def solve_9(input, window_size)
  input[window_size...]
    .map_with_index { |val, index| {val, index} }
    .find { |val, index|
      !is_sum? val, input[index..(index + window_size)]
    }
end

def contiguos(input, target)
  contiguos_loop(input, target, 0, 1)
end

def contiguos_loop(input, target, start, finish)
  candidate = input[start..finish]
  sum = candidate.sum
  if (sum == target)
    candidate
  elsif (sum > target) # We are over, we should drop the tail
    contiguos_loop(input, target, start + 1, finish)
  else # We are under, we should enlarge the head
    contiguos_loop(input, target, start, finish + 1)
  end
end

def solve_9_1(input)
  solve_9(input, 25)
end

def solve_9_2(input)
  s = solve_9(input, 25)
  raise "nope" if s.nil?

  contiguos(input, s[0]).minmax.try { |a, b| a + b }
end
