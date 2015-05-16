Factory = {}
Factory.__index = Factory

function Factory.create()
  local factory = {}
  factory.setmeattable(Factory)
  
  factory.buildings = {}
  return factory
end

function Factory:addBuilding(building)
  table.insert(factory.buildings, building)
end