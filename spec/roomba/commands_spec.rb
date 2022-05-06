require 'spec_helper'
require 'roomba/commands'

describe "Validate commands" do

  it "should accept Empty commands" do
    commands = []
    c = Roomba::Commands.new(commands)
    expect(c.commands.length).to eq(0)
  end
  
  it "should accept all commands" do
    commands = ["PLACE 1,1,NORTH","PLACE 1,1,SOUTH","PLACE 1,1,EAST","PLACE 1,1,WEST","MOVE","LEFT","RIGHT","REPORT"]
    c = Roomba::Commands.new(commands)
    expect(c.commands.length).to eq(8)
  end

  it "should reject all commands" do
    commands = ["PLACE 1,1,NORTH-EAST","PLACE 1,1,SOUTHWEST","PLACE1,1,EAST","PLACE 1,WEST","1MOVE","LEFT1","1RIGHT1","_REPORT"]
    c = Roomba::Commands.new(commands)
    expect(c.commands.length).to eq(0)
  end
  
  it "should validate commands" do
    f = File.open("spec/fixtures/test_commands.txt", "r:utf-8")
    c = Roomba::Commands.new(f.readlines)
    expect(c.commands.length).to eq(15)
  end
  
  it "should return each command" do
    commands = ["PLACE 1,1,NORTH","PLACE 1,1,SOUTH","PLACE 1,1,EAST","PLACE 1,1,WEST","MOVE","LEFT","RIGHT","REPORT"]
    c = Roomba::Commands.new(commands)
    p = Point.new(1,1)
    ec = {:place => "_place", :move => "_move", :left => "_left", :right => "_right", :report => "_report"}
    expect { |b| c.each_command(ec, &b) }.to yield_successive_args(["_place", [p, "NORTH"]], ["_place", [p, "SOUTH"]], ["_place", [p, "EAST"]], ["_place", [p, "WEST"]], ["_move", nil], [
"_left", nil], ["_right", nil], ["_report", nil])   
  end
end

