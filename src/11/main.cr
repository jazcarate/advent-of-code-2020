OCCUPIED = '#'
EMPTY    = 'L'
FLOOR    = '.'

def is_empty(seat)
  seat == EMPTY
end

def is_occupied(seat)
  seat == OCCUPIED
end

def is_floor(seat)
  seat == FLOOR
end

def ray_trace(state, direction, starting, step)
  x, y = starting
  dirX, dirY = direction

  new_x = x + dirX * step
  new_y = y + dirY * step

  if (new_x < 0 || new_y < 0)
    nil
  else
    state[new_x]?.try { |row_state| row_state[new_y]? }
  end
end

def adjacent(state, ray_trace, row, column)
  directions = [
    {-1, -1}, {-1, 0}, {-1, +1},
    {0, -1}, {0, +1},
    {+1, -1}, {+1, 0}, {+1, +1},
  ]

  directions.map { |dir|
    if ray_trace
      (1..).step
        .map { |step| ray_trace(state, dir, {row, column}, step) }
        .find { |v| !is_floor(v) }
    else
      ray_trace(state, dir, {row, column}, 1)
    end
  }.compact
end

def tick(state, ray_trace, tolerance)
  new_state = state.clone

  state.each_with_index do |row, r|
    row.each_with_index do |seat, c|
      ocuppancy = adjacent(state, ray_trace, r, c).count { |v| is_occupied(v) }
      if is_empty(seat) && ocuppancy == 0
        new_state[r][c] = OCCUPIED
      elsif is_occupied(seat) && ocuppancy >= tolerance
        new_state[r][c] = EMPTY
      end
    end
  end

  new_state
end

def solve_11(input, ray_trace, tolerance)
  old_state = nil
  new_state = input.map &.chars

  until old_state == new_state
    old_state = new_state
    new_state = tick old_state, ray_trace, tolerance
  end

  new_state.flatten.count { |s| is_occupied(s) }
end

def solve_11_1(input)
  solve_11(input, false, 4)
end

def solve_11_2(input)
  solve_11(input, true, 5)
end
