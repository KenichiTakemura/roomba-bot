require 'spec_helper'
require 'position'

describe "Position test" do
  p = Position.new
  specify "LEFT" do
    p.left_turn!.direction.should eq(:west)
    p.left_turn!.direction.should eq(:south)
    p.left_turn!.direction.should eq(:east)
    p.left_turn!.direction.should eq(:north)
    expect {
      p.point[:x].to eq(0)
      p.point[:y].to eq(1)
    } 
  end
  specify "RIGHT" do
    p.right_turn!.direction.should eq(:east)
    p.right_turn!.direction.should eq(:south)
    p.right_turn!.direction.should eq(:west)
    p.right_turn!.direction.should eq(:north)
    expect {
      p.point[:x].to eq(0)
      p.point[:y].to eq(1)
    } 
  end
  specify "MOVE" do
    p.move!.left_turn!.right_turn!.reset!
    p.direction.should eq(:north)
    p.point.should eq(Point::ORIGIN)
    p.move!.move!.move!.point.should eq(Point.new(0,3))
    p.reset!
  end
  specify "NEXT MOVE" do
    p.move!.right_turn!.move!.left_turn!.move!
    q = p.next_move
    p.direction.should eq(:north)
    p.point.should eq(Point.new(1,2))
    q.should eq(Point.new(1,3))
  end
  specify "MOVE TO" do
    p.move_to!(1,2,:north).point.should eq(Point.new(1,2))
    p.move_to!(5,5,:north).point.should eq(Point.new(5,5))
    p.move_to!(-1,-1,:north).point.should eq(Point.new(-1,-1))
  end
end
