require "roomba/version"
require "roomba/engine"

module Roomba

  def Roomba.roam(engine)
    engine.on
    engine.off
  end
  
end