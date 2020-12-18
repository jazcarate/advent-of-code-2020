def set(value, bit, position)
  if bit == 1
    value | (2.to_u64 ** position)
  else
    value & ~(2.to_u64 ** position)
  end
end

def mangle_value(value, mask)
  ret = value
  mask.chars.reverse.each_with_index do |c, i|
    case c
    when '0'
      ret = set(ret, 0, i)
    when '1'
      ret = set(ret, 1, i)
    end
  end

  ret
end

def mangle_adress(adress, mask)
  ret = [adress]
  mask.chars.reverse.each_with_index do |c, i|
    case c
    when '1'
      ret = ret.map { |r| set(r, 1, i) }
    when 'X'
      ret = ret.map { |r| set(r, 1, i) } + ret.map { |r| set(r, 0, i) }
    end
  end

  ret
end

def solve_14_1(input)
  mask = ""
  memory = Hash(UInt64, UInt64).new

  input.each do |line|
    if line.starts_with?("mask")
      matches = /mask = (.*)/.match(line).not_nil!
      mask = matches[1]
    else
      matches = /mem\[(\d+)\] = (\d+)/.match(line).not_nil!

      pos = matches[1].to_u64
      val = matches[2].to_u64

      memory[pos] = mangle_value(val, mask)
    end
  end

  memory.values.sum
end

def solve_14_2(input)
  mask = ""
  memory = Hash(UInt64, UInt64).new

  input.each do |line|
    if line.starts_with?("mask")
      matches = /mask = (.*)/.match(line).not_nil!
      mask = matches[1]
    else
      matches = /mem\[(\d+)\] = (\d+)/.match(line).not_nil!

      pos = matches[1].to_u64
      val = matches[2].to_u64

      mangle_adress(pos, mask).each { |new_pos| memory[new_pos] = val }
    end
  end

  memory.values.sum
end
