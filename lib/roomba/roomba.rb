require "roomba/version"
require "roomba/engine"

# Roomba module
module Roomba

  # Roomba roams using equipped engine
  def Roomba.roam(engine)
    # Turn on the engine
    engine.on
    # Turn off the engine
    engine.off
  end
  
end