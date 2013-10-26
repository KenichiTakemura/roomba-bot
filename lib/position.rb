require 'point'

# Position class
# This class has Point and direction
class Position

  DIRECTIONS = {
     :north => 1,
     :south => 3,
     :east => 0,
     :west => 2
   }.freeze

  def initialize
    reset!
  end
  
  def reset!
    @direction = DIRECTIONS[:north]
    @point = Point.new(0,0)
  end
  
  def next_move
    @point.add(next_point)
  end

  def move!
    @point.add!(next_point)
    self
  end
  
  def move_to!(p,dict)
    @direction = DIRECTIONS[dict]
    @point = Point.new(p[:x],p[:y])
    self
  end

  def left_turn!
    turn(LEFT)
    self
  end

  def right_turn!
    turn(RIGHT)
    self
  end

  def to_s
    "#{@point},#{face_to}"
  end
  
  def direction
    DIRECTIONS.key current_direction
  end
  
  def point
    @point.dup
  end

  private

  LEFT = 1
  RIGHT = 3
  
  def current_direction
    @direction % 4
  end
  
  def next_point
    case current_direction
    when DIRECTIONS[:north]
      Point::UNIT_Y
    when DIRECTIONS[:south]
      Point::NEGATIVE_UNIT_Y
    when DIRECTIONS[:east]
      Point::UNIT_X
    when DIRECTIONS[:west]
      Point::NEGATIVE_UNIT_X
    end
  end

  def turn(to)
    @direction += to
  end

  def face_to
    case current_direction
    when DIRECTIONS[:north]
      return :north.upcase
    when DIRECTIONS[:south]
      return :south.upcase
    when DIRECTIONS[:east]
      return :east.upcase
    when DIRECTIONS[:west]
      return :west.upcase
    end
  end

end