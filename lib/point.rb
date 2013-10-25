class Point
  attr_accessor :x, :y
  def initialize(x,y)
    @x, @y = x.to_i, y.to_i
  end

  def +(other)
    Point.new(@x + other.x, @y + other.y)
  end

  def add!(p)
    @x += p.x
    @y += p.y
    self
  end

  def add(p)
    q = self.dup
    q.add!(p)
  end

  def [](index)
    case index
    when 0, -2; @x
    when 1, -1; @y
    when :x, "x";
    when :y, "y"; @y
    else nil
    end
  end

  ORIGIN = Point.new(0,0)
  UNIT_X = Point.new(1,0)
  UNIT_Y = Point.new(0,1)
  NEGATIVE_UNIT_X = Point.new(-1,0)
  NEGATIVE_UNIT_Y = Point.new(0,-1)

  def ==(other)
    if other.is_a? Point
    @x==other.x && @y==other.y
    else
    false
    end
  end

  alias eql? ==

  def to_s
    "#{@x},#{@y}"
  end

  def hash
    code = 17
    code = 37*code + @x.hash
    code = 37*code + @y.hash
    code
  end
end