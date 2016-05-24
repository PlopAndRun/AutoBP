local function selectAssembler(production)
  local ingredients = #production.components
  tassert(ingredients <= 6, "selectAssembler: number of components is too large")
  
  if  ingredients <= 2 then return FactoryBuildings.assembling1
  elseif ingredients <= 4 then return FactoryBuildings.assembling2
  elseif ingredients <= 6 then return FactoryBuildings.assembling3
  end
end

function buildFactory(production)
  local currentPos = {x = 0, y = 0}
  local currentThing = production.output
  local currentLevel = Queue.create()
  local nextLevel = {}
  local currentDepth = 0
  local built = {}
  currentLevel:put(currentThing)
  repeat
    nextLevel = Queue.create()
    while not currentLevel:isEmpty() do
      currentThing = currentLevel:pull()
      if not currentThing.basic and currentThing.depth == currentDepth and not built[currentThing] then
        GameWrapper.build {
          name = selectAssembler(currentThing),
          position = currentPos,
          recipe = currentThing.recipe.name
        }
        currentPos.x = currentPos.x - 4
        built[currentThing] = true
        for _, component in ipairs(currentThing.components) do
          nextLevel:put(component)
        end
      end
    end
    currentPos.y = currentPos.y - 4
    currentPos.x = 0
    currentLevel = nextLevel
    currentDepth = currentDepth + 1
  until currentLevel:isEmpty()
  return factory
end
