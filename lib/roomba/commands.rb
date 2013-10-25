require 'point'

module Roomba
  class Commands
    attr_reader :commands
    
    COMMAND_SYNTAX = /^(?<com>PLACE)(\s+)(?<x>\d+),(?<y>\d+),(?<dict>NORTH|SOUTH|EAST|WEST)\Z|^(?<com>MOVE)\Z|^(?<com>LEFT)\Z|^(?<com>RIGHT)\Z|^(?<com>REPORT)\Z/

    def initialize(lines)
      @commands = Array.new
      s = lines.dup
      s.each do |line|
        line.strip!
        @commands.push line if validate_command line
      end
      raise Roomba::Exceptions::InvalidCommand if @commands.empty?
    end

    # Custome Iterator
    # This yields correcpoding engine command
    def each_command(engine_command_list)
      @commands.each do |command|
        COMMAND_SYNTAX =~ command
        if $~[:com].eql?("PLACE")
          param = [Point.new($~[:x],$~[:y]),$~[:dict]]
        end
        engine_command = engine_command_list[$~[:com].downcase.intern]
        if engine_command
          yield engine_command,param
        end
      end
    end

    private

    def validate_command(command)
      COMMAND_SYNTAX =~ command
    end
  end
end