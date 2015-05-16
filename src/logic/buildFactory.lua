local function selectAssembler(production)
  local ingredients = #production.components
  assert(ingredients <= 6, "selectAssembler: number of components is too large")
  
  if  ingredients <= 2 then return FactoryBuildings.assembling1
  elseif ingredients <= 4 then return FactoryBuildings.assembling2
  elseif ingredients <= 6 then return FactoryBuildings.assembling3
  end
end

function buildFactory(production)
  local currentPos = {x = 0, y = 0}
  local currentProduction = production
  while not currentProduction.basic do
    game.createentity {
      name = selectAssembler(currentProduction),
      position = currentPos,
      force = game.player.force,
      recipe = currentProduction.recipe.name
    }
    currentPos.y = currentPos.y - 2
    game.createentity {
      name = FactoryBuildings.inserter,
      position = currentPos,
      force = game.player.force
    }
    currentPos.y = currentPos.y - 2
    currentProduction = currentProduction.components[1]
  end
  return factory
end
