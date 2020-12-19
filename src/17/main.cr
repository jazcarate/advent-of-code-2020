def neighbours(map, x, y, z)
  [{-1, -1, -1}, {0, -1, -1}, {1, -1, -1},
   {-1, 0, -1}, {0, 0, -1}, {1, 0, -1},
   {-1, 1, -1}, {0, 1, -1}, {1, 1, -1},

   {-1, -1, 0}, {0, -1, 0}, {1, -1, 0},
   {-1, 0, 0}, {1, 0, 0},
   {-1, 1, 0}, {0, 1, 0}, {1, 1, 0},

   {-1, -1, 1}, {0, -1, 1}, {1, -1, 1},
   {-1, 0, 1}, {0, 0, 1}, {1, 0, 1},
   {-1, 1, 1}, {0, 1, 1}, {1, 1, 1}].map do |dx, dy, dz|
    nx = x + dx
    ny = y + dy
    nz = z + dz
    if nx < 0 || ny < 0 || nz < 0 || nx >= map.size || ny >= map.size || nz >= map.size
      false
    else
      map[nx][ny][nz]
    end
  end
end

def tick(map)
  map.map_with_index do |m1, x|
    m1.map_with_index do |m2, y|
      m2.map_with_index do |m3, z|
        n = neighbours(map, x, y, z).count { |v| v }
        if map[x][y][z]      # If a cube is active
          (2..3).includes? n # exactly 2 or 3 of its neighbors are also active
        else
          n == 3 # exactly 3 of its neighbors are active
        end
      end
    end
  end
end

def solve_17_1(input)
  cycles = 6
  size = input.size
  map = Array.new(size, Array.new(size, Array.new(size, false)))

  # Todo: this is mapping the input wrong.
  input.each_with_index do |l, y|
    l.chars.each_with_index do |c, x|
      map[x][y][0] = (c == '#')
    end
  end

  map
end

def solve_17_2(input)
  false
end
