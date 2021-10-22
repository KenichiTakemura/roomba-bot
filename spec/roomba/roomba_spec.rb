require 'spec_helper'
require 'roomba/roomba'

describe "Roomba" do
  it "should roam straight" do
    engine = Roomba::Engine.new
    commands = Roomba::Commands.new(["PLACE 0,0,NORTH","MOVE","MOVE","MOVE","MOVE","REPORT"])
    expect(Roomba.roam(engine.set_commands(commands))).to eq(["0,4,NORTH"])
    commands = Roomba::Commands.new(["PLACE 0,4,EAST","MOVE","MOVE","MOVE","MOVE","REPORT"])
    expect(Roomba.roam(engine.set_commands(commands))).to eq(["4,4,EAST"])
    commands = Roomba::Commands.new(["PLACE 4,4,SOUTH","MOVE","MOVE","MOVE","MOVE","REPORT"])
    expect(Roomba.roam(engine.set_commands(commands))).to eq(["4,0,SOUTH"])
    commands = Roomba::Commands.new(["PLACE 4,0,WEST","MOVE","MOVE","MOVE","MOVE","REPORT"])
    expect(Roomba.roam(engine.set_commands(commands))).to eq(["0,0,WEST"])
  end

  it "should be back to origin" do
    engine = Roomba::Engine.new
    commands = Roomba::Commands.new(["PLACE 0,0,NORTH","MOVE","MOVE","MOVE","MOVE","RIGHT","MOVE","MOVE","MOVE","MOVE","RIGHT","MOVE","MOVE","MOVE","MOVE","RIGHT","MOVE","MOVE","MOVE","MOVE","RIGHT","REPORT"])
    expect(Roomba.roam(engine.set_commands(commands))).to eq(["0,0,NORTH"])
  end

  it "should ignore all invalid place command" do
    engine = Roomba::Engine.new
    commands = Roomba::Commands.new(["PLACE 5,0,NORTH","PLACE 0,5,NORTH","PLACE -1,0,SOUTH","MOVE","LEFT","RIGHT","REPORT","PLACE 4,4,WEST","REPORT"])
    expect(Roomba.roam(engine.set_commands(commands))).to eq(["4,4,WEST"])
  end

  it "should test sample data" do
    engine = Roomba::Engine.new
    expect(Roomba.roam(engine.set_commands(
    Roomba::Commands.new(File.open("spec/fixtures/sample_commands_1.txt", "r:utf-8").readlines)))).to eq(["0,1,NORTH"])
    expect(Roomba.roam(engine.set_commands(
    Roomba::Commands.new(File.open("spec/fixtures/sample_commands_2.txt", "r:utf-8").readlines)))).to eq(["0,0,WEST"])
    expect(Roomba.roam(engine.set_commands(
    Roomba::Commands.new(File.open("spec/fixtures/sample_commands_3.txt", "r:utf-8").readlines)))).to eq(["3,3,NORTH"])
    expect(Roomba.roam(engine.set_commands(
    Roomba::Commands.new(File.open("spec/fixtures/sample_commands_4.txt", "r:utf-8").readlines)))).to eq(["4,4,NORTH"])
    expect(Roomba.roam(engine.set_commands(
    Roomba::Commands.new(File.open("spec/fixtures/sample_commands_5.txt", "r:utf-8").readlines)))).to eq(["1,1,NORTH"])
    expect(Roomba.roam(engine.set_commands(
    Roomba::Commands.new(File.open("spec/fixtures/test_commands.txt", "r:utf-8").readlines)))).to eq(["2,3,WEST"])

  end
end
