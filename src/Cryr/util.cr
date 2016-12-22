

def max( x : Int, y : Int )
  x >= y ? x : y
end

def min( x : Int, y : Int )
  x <= y ? x : y
end

def nil_min( x : Int | Nil, y : Int )
  x.nil? ? y : min x, y
end

def nil_max( x : Int | Nil, y : Int )
  x.nil? ? y : max x, y
end

enum Direction
  South
  North
  East
  West
  SouthEast
  SouthWest
  NorthEast
  NorthWest
end

struct Pos
  property x, y

  def initialize( @x : Int32, @y : Int32 )
  end

  def offset_dir( dir )
    x, y = 0, 0
    case dir
    when Direction::South
      x, y = 0, -1
    when Direction::North
      x, y = 0, 1
    when Direction::East
      x, y = 1, 0
    when Direction::West
      x, y = -1, 0
    when Direction::SouthWest
      x, y = -1, -1
    when Direction::SouthEast
      x, y = 1, -1
    when Direction::NorthWest
      x, y = -1, 1
    when Direction::NorthEast
      x, y = 1, 1
    end
    Pos.new x: @x + x, y: @y + y
  end
end
