Thing = {}
Thing.__index = Thing

function Thing.create(name)
  tassert(name, "Thing.create(nil)")
  local thing = {}
  setmetatable(thing, Thing)
  
  thing.productionGraph = nil
  thing.name = name
  thing.basic = true
  thing.components = {}
  thing.compounds = {}
  thing.recepie = {}
  thing.depth = 0
  return thing
end

function Thing:addComponent(thing)
  tassert(thing, "Thing:addComponent(nil)")
  
  table.insert(self.components, thing)
  table.insert(thing.compounds, self)
  thing.depth = math.max(thing.depth, self.depth + 1)
  self.basic = false
end