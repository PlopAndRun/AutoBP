local function evaluate(recipes, item)
  assert(recipes, "evalulate(recipes = nil)")
  assert(item, "evaluate(item = nil)")
  assert(item.name, "item name is nil")
  
  local queue = Queue.create()
  local evaluated = {}
  local result = Production.create(item)
  
  queue:put(result)
  evaluated[item.name] = true

  while not queue:isEmpty() do
    local production = queue:pull()
    local itemName = production.item.name
    local recipe = recipes[itemName]
    
    if recipe then
      production.recipe = recipe
      for _, ingredient in ipairs(recipe.ingredients) do
        local componentName = ingredient.name
        local component = Production.create(GameWrapper.getItemByName(componentName))
        production:addComponent(component)
      
        queue:put(component)
      end
    end
  end
  
  return result
end 

function developProduction(item)
  assert(item, "developProduction(nil)")

  local recipes = GameWrapper.getAllRecipes()
  local production = evaluate(recipes, item)
  return production
end