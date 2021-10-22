require 'spec_helper'
require 'position'

describe "Position test" do
  p = Position.new
  specify "LEFT" do
    expect(p.left_turn!.direction).to eq(:west)
    expect(p.left_turn!.direction).to eq(:south)
    expect(p.left_turn!.direction).to eq(:east)
    expect(p.left_turn!.direction).to eq(:north)
    expect {
      p.point[:x].to eq(0)
      p.point[:y].to eq(1)
    } 
  end
  specify "RIGHT" do
    expect(p.right_turn!.direction).to eq(:east)
    expect(p.right_turn!.direction).to eq(:south)
    expect(p.right_turn!.direction).to eq(:west)
    expect(p.right_turn!.direction).to eq(:north)
    expect {
      p.point[:x].to eq(0)
      p.point[:y].to eq(1)
    } 
  end
  specify "MOVE" do
    p.move!.left_turn!.right_turn!.reset!
    expect(p.direction).to eq(:north)
    expect(p.point).to eq(Point::ORIGIN)
    expect(p.move!.move!.move!.point).to eq(Point.new(0,3))
    p.reset!
  end
  specify "NEXT MOVE" do
    p.move!.right_turn!.move!.left_turn!.move!
    q = p.next_move
    expect(p.direction).to eq(:north)
    expect(p.point).to eq(Point.new(1,2))
    expect(q).to eq(Point.new(1,3))
  end
  specify "MOVE TO" do
    expect(p.move_to!(Point.new(1,2),:north).point).to eq(Point.new(1,2))
    expect(p.move_to!(Point.new(5,5),:north).point).to eq(Point.new(5,5))
    expect(p.move_to!(Point.new(-1,-1),:north).point).to eq(Point.new(-1,-1))
  end
end
