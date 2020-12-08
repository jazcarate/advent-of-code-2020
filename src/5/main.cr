require "bit_array"

def to_i(bits)
  bits.join("") { |i| if (i)
    1
  else
    0
  end }.to_i(2)
end

def seat(input)
  row = BitArray.new(7)
  row.each_with_index do |_, i|
    row.toggle i if input[i] == 'B'
  end

  column = BitArray.new(3)
  column.each_with_index do |_, i|
    column.toggle i unless input[i + 7] == 'L'
  end

  {to_i(row), to_i(column)}
end

def seat_id(seat)
  row, column = seat
  row * 8 + column
end

def solve_5_1(input)
  input.map { |pass| seat_id seat(pass) }.max
end

def solve_5_2(input)
  seats = input.map { |pass| seat_id seat(pass) }

  # Both O(1)
  ((seats.min)..(seats.max)).sum - seats.sum
end
