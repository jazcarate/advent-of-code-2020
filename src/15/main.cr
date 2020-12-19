module Foo
  extend self

  @@last_apparance = {} of Int32 => Int32
  @@new_apparance = {} of Int32 => Int32

  def appear(number, turn)
    last = @@last_apparance[number]?
    if last
      new = @@new_apparance[number]?
      if new
        @@last_apparance[number] = new
      end
      @@new_apparance[number] = turn
    else
      @@last_apparance[number] = turn
    end
  end

  def solve(input, target)
    input.each_with_index do |val, i|
      appear(val, i + 1)
    end

    prev = input[-1]

    (input.size..(target - 1)).each do |i|
      turn = i + 1

      prev = @@new_apparance[prev]? ? (@@new_apparance[prev] - @@last_apparance[prev]) : 0
      appear(prev, turn)
    end

    prev
  end
end

def solve_15_1(input)
  Foo.solve(input, 2020)
end

def solve_15_2(input)
  Foo.solve(input, 30000000)
end
