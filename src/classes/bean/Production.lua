Production = {}
Production.__index = Production

function Production.create(item)
  assert(item, "Production.create(nil)")
  
  local production = {}
  setmetatable(production, Production)
  production.item = item
  production.basic = true
  production.components = {}
  return production
end

function Production:addComponent(component)
  assert(component, "Production:addComponent(nil)")
  assert(getmetatable(component) == Production, "Production:addComponent(wrong metatable)")
  
  table.insert(self.components, component)
  self.basic = false
end

local function toString(production, depth, buffer)  
  local row = {}
  if depth > 0 then
    table.insert(row, string.rep("  ", depth))
  end
  table.insert(row, production.item.name)
  if not production.basic then 
    table.insert(row, " =")
  end
    
  table.insert(buffer, table.concat(row))
  for _, production in ipairs(production.components) do
    toString(production, depth + 1, buffer)
  end
end

function Production:toString()
  local buffer = {}
  toString(self, 0, buffer)
  return table.concat(buffer, "\n")
end