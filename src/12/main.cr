class Ship1
  property pointing, x, y

  def initialize
    @pointing = 0 # east
    @x = 0
    @y = 0
  end

  macro direction(name, var, offset)
    def {{name}}(value)
      @{{var}} += {{offset}} * value
    end
  end

  #   N (+1)
  # W (-1)   E (+1)
  #   S (-1)
  direction north, y, +1
  direction south, y, -1
  direction west, x, -1
  direction east, x, +1

  direction left, pointing, +1
  direction right, pointing, -1

  def forward(value)
    case (pointing % 360) // 90
    when 0 then east value
    when 1 then north value
    when 2 then west value
    when 3 then south value
    end
  end
end

class Ship2
  property x, y
  property wp_x, wp_y

  def initialize
    @x = 0
    @y = 0
    @wp_x = 10
    @wp_y = 1
  end

  macro direction(name, var, offset)
    def {{name}}(value)
      @wp_{{var}} += {{offset}} * value
    end
  end

  direction north, y, +1
  direction south, y, -1
  direction west, x, -1
  direction east, x, +1

  def ninty_degrees
    # (x,y) -> (y,−x).
    tmp = @wp_x
    @wp_x = @wp_y
    @wp_y = -tmp
  end

  def rotate(value)
    ((value % 360) // 90).times { |i| ninty_degrees }
  end

  def left(value)
    rotate -value
  end

  def right(value)
    rotate value
  end

  def forward(value)
    @x += @wp_x * value
    @y += @wp_y * value
  end
end

def solve_12(input, ship)
  input.each do |line|
    acction = line[0]
    value = line[1..].to_i

    case acction
    when 'N' then ship.north value
    when 'S' then ship.south value
    when 'E' then ship.east value
    when 'W' then ship.west value
    when 'F' then ship.forward value
    when 'R' then ship.right value
    when 'L' then ship.left value
    end
  end
end

def solve_12_1(input)
  ship = Ship1.new
  solve_12(input, ship)

  ship.x.abs + ship.y.abs
end

def solve_12_2(input)
  ship = Ship2.new
  solve_12(input, ship)

  ship.x.abs + ship.y.abs
end
