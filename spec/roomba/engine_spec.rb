require 'spec_helper'
require 'roomba/engine'
require 'roomba/exceptions'

describe "Validate engine" do
  engine = Roomba::Engine.new
  specify "set_commands" do
    expect {engine.set_commands(["PLACE 0,0,NORTH"])}.to raise_exception Roomba::Exceptions::InvalidCommand
    expect {engine.set_commands(Roomba::Commands.new([]))}.to raise_exception Roomba::Exceptions::InvalidCommand
    expect {engine.set_commands(Roomba::Commands.new(["PLACE 0,0,NORTH"]))}.not_to raise_exception
  end

  specify "no report" do
    engine.set_commands(Roomba::Commands.new(["PLACE 0,0,NORTH"]))
    expect(engine.on.off).to be_empty
  end

  specify "with report" do
    engine.set_commands(Roomba::Commands.new(["PLACE 0,0,NORTH","REPORT"]))
    expect(engine.on.off).to eq(["0,0,NORTH"])
  end

  specify "no place" do
    engine.set_commands(Roomba::Commands.new(["MOVE","LEFT","RIGHT","REPORT"]))
    expect(engine.on.off).to be_empty
  end

  specify "out of table" do
    edges = ["0,0,WEST","0,0,SOUTH",
      "0,4,WEST","0,4,NORTH",
      "4,4,NORTH","4,4,EAST",
      "4,0,SOUTH","4,0,EAST"]
    edges.each do |edge|
      engine.set_commands(Roomba::Commands.new(["PLACE #{edge}","MOVE","REPORT"]))
      expect(engine.on.off).to eq([edge])
    end
  end

  specify "placed out of table" do
    places = ["PLACE -1,0,WEST","PLACE 0,-1,SOUTH",
      "PLACE 0,5,WEST","PLACE 1,5,NORTH",
      "PLACE 5,4,NORTH","PLACE 4,5,EAST",
      "PLACE 5,0,SOUTH","PLACE 4,-1,EAST"]
    places.each do |place|
      engine.set_commands(Roomba::Commands.new(["#{place}","MOVE","LEFT","RIGHT","REPORT","PLACE 0,0,SOUTH","REPORT"]))
      expect(engine.on.off).to eq(["0,0,SOUTH"])
    end
  end
end