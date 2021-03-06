#
# Engine Class
#
require 'position'
require "roomba/commands"

module Roomba
  class Engine

    def initialize
      @position = Position.new
      # output list
      @output = Array.new
    end
    
    # Set commands to this engine
    # Accepts only Roomba::Commands instance
    def set_commands(commands)
      if commands.is_a? Commands
        @commands = commands
      else
        raise Roomba::Exceptions::InvalidCommand
      end
      self
    end

    # Turn on the engine
    # Command should be provided by set_commands
    def on
      # This is a flag that is set to true when PLACE command is invoked
      # Reset the flag
      @placed = false
      # Iterate and invoke command
      @commands.each_command(COMMAND_SPEC_LIST) do |command,params|
        # Invoke a command with params
        invoke_command(command,params)
      end
      self
    end

    # Turn off the engine
    # Return outpus generated by REPORT command
    def off
      # Set position to default
      @position.reset!
      # Clone output
      report = @output.clone
      # Clear output
      @output.clear
      # Return output
      report
    end

    private
    
    # This is a list of this engine supporting commands
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
      # Get predicted next Point
      g = @position.next_move
      # Check if its still on the table
      on_table?(g[:x], g[:y])
    end

    # Return if point is still on the table
    def on_table?(x,y)
      (0 <= x && x < GRID_X) && (0 <= y && y < GRID_Y)
    end

    # invoke a command
    def invoke_command(command,params)
      case command
      when COMMAND_SPEC_LIST[:move]
        # MOVE Command
        # Move the position if not falling off the table
        @placed && (@position.move! if movable?)
      when COMMAND_SPEC_LIST[:report]
        # REPORT Command
        # Save the current position in the output list
        # Do not echo now 
        @placed && @output.push("#{@position}")
      when COMMAND_SPEC_LIST[:left]
        # LEFT Command
        # Make a left turn
        @placed && @position.left_turn!
      when COMMAND_SPEC_LIST[:right]
        # RIGHT Command
        # Make a right turn
        @placed && @position.right_turn!
      when COMMAND_SPEC_LIST[:place]
        # PLACE Command
        # First param is Point
        # Second param is Direction
        p = params[0]
        direction = params[1]
        if on_table?(p[:x],p[:y])
          # If Point is on the table
          # Convert string to symbol eg NORTH -> :north
          to = direction.downcase.intern
          @position.move_to!(p, to)
          # Mark valid PLACE is done 
          @placed = true
        end
      else
        raise Roomba::Exceptions::InvalidCommand
      end
    end
  end
end