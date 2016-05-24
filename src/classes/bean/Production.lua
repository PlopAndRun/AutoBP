Production = {}
Production.__index = Production

function Production.create()
  
  local production = {}
  setmetatable(production, Production)
  
  production.things = {}
  production.output = {}
  return production
end

function Production:addComponent(compound, component)
  tassert(compound, "Production:addComponent(thing = nil")
  tassert(component, "Production:addComponent(component = nil)")
  tassert(self.things[compound], "Production does not have " .. compound.name)
  
  compound.addComponent(component)
  table.insert(self.things, component)
end

function Production:addOutput(thing)
  tassert(thing, "Production:addOutput(nil)")
  table.insert(self.things, thing)
  self.output = thing
end

--TODO: implement or delete 
function Production:toString() 
  return "production:toString is not implemented"
end