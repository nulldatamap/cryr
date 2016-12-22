
module TileSet
  extend self

  # Bitmask for solids 0x100 (0b100000000)
  SOLID_MASK = 0x100

  enum Tile
    Empty
    Floor
    Wall = SOLID_MASK
    Tree
  end

  def solid?( tile : Tile )
    (tile.to_i) & SOLID_MASK != 0
  end

  def char_of_tile( tile : Tile )
    case tile
    when TileSet::Tile::Floor
      {chr: '.', fg: ColorScheme::DARK_GRAY,   bg: nil}
    when TileSet::Tile::Wall
      {chr: '#', fg: ColorScheme::LIGHT_GRAY,  bg: nil}
    when TileSet::Tile::Tree
      {chr: '\u0005', fg: ColorScheme::LIGHT_GREEN, bg: nil}
    else
      {chr: ' ', fg: nil, bg: nil}
    end
  end
end

class Map
  @tiles  : Array(TileSet::Tile)
  @width  : UInt32
  @height : UInt32

  getter tiles

  def initialize( w : UInt32, h : UInt32 )
    @tiles = Array.new w * h, TileSet::Tile::Empty
    @width, @height = w, h
  end

  def draw( cons )
    @height.times do |y|
      @width.times do |x|
        idx = x + y * @width
        chrinf = TileSet.char_of_tile( @tiles[idx] )
        cons.put_char( chrinf[:chr], x, y, chrinf[:fg], chrinf[:bg] )
      end
    end
  end

  def tile_at( x, y )
    if x < 0 || x >= @width || y < 0 || y >= @height
      nil
    else
      @tiles[x + y * @width]
    end
  end

  def solid_at?( x, y )
    tile = tile_at( x, y )
    if tile.nil?
      true
    else
      TileSet.solid? tile
    end
  end

end
