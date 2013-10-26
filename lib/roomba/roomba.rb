require "roomba/version"
require "roomba/engine"

# Roomba module
module Roomba

  # Roomba roams using given engine
  def Roomba.roam(engine)
    engine.on
    engine.off
  end
  
end