require "big"

# Memory consumption: as big as the input
# Complexity: O(n/down)
def trees(levels, right, down)
  height = levels.size - 1
  width = levels[0].size

  BigInt.new (0..(height//down))
    .map { |row| {row * down, row * right % width} }
    .map { |(y, x)| levels[y][x] }
    .count('#')
end

def solve_3_1(levels)
  trees(levels, 3, 1)
end

def solve_3_2(levels)
  trees(levels, 1, 1) *
    trees(levels, 3, 1) *
    trees(levels, 5, 1) *
    trees(levels, 7, 1) *
    trees(levels, 1, 2)
end
