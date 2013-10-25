require 'position'
require "roomba/commands"

module Roomba
  class Engine

    # This engine spec is for 5x5 table
    GRID_X = 5
    GRID_Y = 5

    # This is a list for this engine supporting commands
    # Engine supporting command can be different from given command by external
    COMMAND_SPEC_LIST = {
      :place => "place",
      :move => "move",
      :left => "left",
      :right => "right",
      :report => "report"
    }.freeze

    def initialize
      @position = Position.new
      @output = Array.new
    end
    
    def set_commands(commands)
      if commands.is_a? Commands
        @commands = commands
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
    end

    def off
      @position.reset!
      report = @output.clone
      @output.clear
      report
    end

    private

    # Decide if next step is still on table
    def movable?
      # Get predicted next position
      g = @position.next_move
      on_table?(g[:x], g[:y])
    end

    def on_table?(x,y)
      (0 <= x && x < GRID_X) && (0 <= y && y < GRID_Y)
    end

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
        x = params[0].to_i
        y = params[1].to_i
        direction = params[2]
        if on_table?(x,y)
          @position.move_to!(x,y,direction)
          # Mark valid PLACE is done 
          @@placed = true
        end
      end
    end
  end
end