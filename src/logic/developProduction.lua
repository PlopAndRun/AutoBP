local function evaluate(recipes, item)
  tassert(recipes, "evalulate(recipes = nil)")
  tassert(item, "evaluate(item = nil)")
  tassert(item.name, "item name is nil")
  
  local queue = Queue.create()
  local evaluated = {}
  local result = Production.create()
  local rootThing = Thing.create(item.name)
  
  result:addOutput(rootThing)
  queue:put(rootThing)
  evaluated[item.name] = result

  while not queue:isEmpty() do
    local thing = queue:pull()
    local itemName = thing.name
    local recipe = recipes[itemName]
    
    if recipe then
      thing.recipe = recipe
      for _, ingredient in ipairs(recipe.ingredients) do
        local componentName = ingredient.name
        local component = evaluated[componentName]
        if not component then
          component = Thing.create(componentName)
          queue:put(component)
          evaluated[componentName] = component 
        end
        thing:addComponent(component)
      end
    end
  end
  
  return result
end 

function developProduction(item)
  tassert(item, "developProduction(nil)")

  local recipes = GameWrapper.getAllRecipes()
  local production = evaluate(recipes, item)
  return production
end