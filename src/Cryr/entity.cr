require "./util.cr"
require "./world.cr"

abstract class Action
  @duration  : UInt32
  @time_left : UInt32

  getter time_left

  def initialize( @duration )
    @time_left = @duration
  end

  def tick( time )
    @time_left = time >= @time_left ? 0u32 : (@time_left - time)
  end

  def finished?
    @time_left == 0
  end

  abstract def perform( e : Entity )
end

class MoveAction < Action
  @direction : Direction

  def initialize( @direction, @duration )
    super @duration
  end

  def perform( e )
    target = e.pos.offset_dir( @direction )
    unless e.world.map.solid_at? target.x, target.y
      e.pos = target
    end
  end

end

class Entity
  @@next_id = 0u32

  @name   : String
  @id     : UInt32
  @active : Bool = true
  @world  : World
  @pos    : Pos = Pos.new 0, 0
  @action : Action | Nil

  getter id, active, world, pos, lowest_time_left, action
  setter pos, world, action

  def self.get_next_id
    old_id = @@next_id
    @@next_id += 1
    old_id
  end

  def initialize( @world, @name = "<unamed entity>" )
    @id = Entity.get_next_id
    @world.add_entity self
  end

  def update( time )
    act = @action
    unless act.nil? || act.finished?
      act.tick time
      if act.finished?
        act.perform self
      end
    end
  end

  def draw( cons )
    cons.put_char ('0' + @id), pos.x, pos.y
  end

  def to_s
    @name + "@" + @id.to_s
  end
end
