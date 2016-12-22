require "./entity.cr"
require "./map.cr"

class World
  @entities : Array(Entity)
  @map      : Map
  getter map

  def initialize
    @map = Map.new 80u32, 40u32
    @entities = Array(Entity).new
  end

  def add_entities( es : Enumerable(Entity) )
    es.each do |e|
      add_entity( e )
    end
  end

  def add_entity( e )
    @entities << e
    e.world = self
  end

  def lowest_time_left
    @entities.reduce( nil ) do |lowest, e|
      act = e.action
      if act.nil? || act.finished?
        lowest
      else
        nil_min lowest, act.time_left
      end
    end
  end

  def update( time )
    while time > 0u32
      time_step = nil_min lowest_time_left, time
      @entities.each do |entity|
        if entity.active
          entity.update time
        end
      end
      time -= time_step
    end
  end

  def draw( cons )
    @map.draw cons
    @entities.each do |entity|
      if entity.active
        entity.draw cons
      end
    end
  end
end
