require 'point'

# Position class
# 
# This class has Point and Direction
# 
# Default Point is set to ORIGIN(0,0) and Direction is NORTH
# 
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
  
  # Reset the position
  def reset!
    @direction = DIRECTIONS[:north]
    @point = Point.new(0,0)
  end
  
  # Return the Point for next move
  def next_move
    @point.add(next_point)
  end

  # Move the position one unit forward in the direction it is currently facing
  def move!
    @point.add!(next_point)
    self
  end
  
  # Move the position to Point and change Direction
  def move_to!(p,dict)
    @direction = DIRECTIONS[dict]
    @point = Point.new(p[:x],p[:y])
    self
  end

  # Turn Left
  def left_turn!
    turn(LEFT)
    self
  end

  # Turn Right
  def right_turn!
    turn(RIGHT)
    self
  end

  def to_s
    "#{@point},#{face_to}"
  end
  
  # Return direction symbol
  def direction
    DIRECTIONS.key current_direction
  end
  
  # Return a copy of Point
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
    else
      # nothing
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
    else
      # nothing
    end
  end

end