require "./Cryr/*"

world = World.new
e1 = Entity.new world
e1.pos.x = 3
e2 = Entity.new world
e2.pos.y = 3
e3 = Entity.new world
e3.action = MoveAction.new Direction::East, 3u32
world.map.tiles[8] = TileSet::Tile::Tree

root = Console.new 80, 40, false
root.game_loop do
  world.update 10u32
  root.clear
  world.draw root
  root.flush
  (LibTCOD.console_wait_for_keypress true).vk == LibTCOD::KeycodeT::TCODK_ESCAPE
end

module Cryr
  # TODO Put your code here
end
