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
  local currentLevel = Queue.create()
  local nextLevel = {}
  currentLevel:put(production)
  repeat
    nextLevel = Queue.create()
    while not currentLevel:isEmpty() do
      currentProduction = currentLevel:pull()
      if not currentProduction.basic then
        GameWrapper.build {
          name = selectAssembler(currentProduction),
          position = currentPos,
          recipe = currentProduction.recipe.name
        }
        currentPos.x = currentPos.x - 4
        for _, component in ipairs(currentProduction.components) do
          nextLevel:put(component)
        end
      end
    end
    currentPos.y = currentPos.y - 4
    currentPos.x = 0
    currentLevel = nextLevel
  until currentLevel:isEmpty()
  return factory
end
