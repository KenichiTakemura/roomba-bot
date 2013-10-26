require 'position'
require "roomba/commands"

module Roomba
  class Engine

    def initialize
      @position = Position.new
      @output = Array.new
    end
    
    def set_commands(commands)
      if commands.is_a? Commands
        @commands = commands
      else
        raise Roomba::Exceptions::InvalidCommand 
      end
      self
    end

    def on
      # This is a flag that is set to true when PLACE command is invoked
      @@placed = false
      @commands.each_command(COMMAND_SPEC_LIST) do |command,params|
      # Invoke each command with params
        invoke_command(command,params)
      end
      self
    end

    def off
      @position.reset!
      report = @output.clone
      @output.clear
      report
    end

    private
    
    # This is a list for this engine supporting commands
    # Engine supporting command can be different from given command by external
    COMMAND_SPEC_LIST = {
      :place => "place",
      :move => "move",
      :left => "left",
      :right => "right",
      :report => "report"
    }.freeze

    # This engine spec is for 5x5 table
    GRID_X = 5
    GRID_Y = 5

    # Decide if next move is still on table
    def movable?
      # Get predicted next position
      g = @position.next_move
      on_table?(g[:x], g[:y])
    end

    # Return if point is still on table
    def on_table?(x,y)
      (0 <= x && x < GRID_X) && (0 <= y && y < GRID_Y)
    end

    # invoke a command
    def invoke_command(command,params)
      case command
      when COMMAND_SPEC_LIST[:move]
        @@placed && (@position.move! if movable?)
      when COMMAND_SPEC_LIST[:report]
        # Save current position in the list
        @@placed && @output.push("#{@position}")
      when COMMAND_SPEC_LIST[:left]
        @@placed && @position.left_turn!
      when COMMAND_SPEC_LIST[:right]
        @@placed && @position.right_turn!
      when COMMAND_SPEC_LIST[:place]
        p = params[0]
        direction = params[1]
        if on_table?(p[:x],p[:y])
          # Convert string to symbol eg NORTH -> :north
          to = direction.downcase.intern
          @position.move_to!(p,to)
          # Mark valid PLACE is done 
          @@placed = true
        end
      end
    end
  end
end