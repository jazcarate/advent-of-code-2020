require "bit_array"

def solve_10_1(input)
  one_jump = 0
  three_jump = 0

  input << 0

  input.sort.each_cons_pair do |current, succ|
    case (succ - current)
    when 1
      one_jump += 1
    when 3
      three_jump += 1
    end
  end

  one_jump * (three_jump + 1)
end

def mask(input, mask)
  offset = 0
  ret = input.dup
  mask.chars
    .map { |val| val == '0' }
    .each_with_index { |toggle, i|
      if (toggle)
        ret.delete_at(i - offset)
        offset += 1
      end
    }
  ret
end

def works?(adapters, target)
  adapters.each_cons_pair do |current, succ|
    if (succ - current > 3)
      break false
    end
  end
  target == adapters[-1]?
end

def solve_10_2(input)
  # No idea 😅
end
