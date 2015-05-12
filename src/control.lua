require "requires"

local function getAllRecepies()
  return game.player.force.recipes
end

local function evaluate(recepies, item)
  assert(recepies, "evalulate(recepies = nil)")
  assert(item, "evaluate(item = nil)")
  
  local queue = Queue.create()
  local evaluated = {}
  local result = Production.create(item)
  
  queue:put(result)
  evaluated[item.name] = true

  while not queue:isEmpty() do
    local production = queue:pull()
    local itemName = production.item.name
    local recepie = recepies[itemName]
    
    if recepie then
      for _, ingredient in ipairs(recepie.ingredients) do
        local componentName = ingredient.name
        local component = Production.create(game.itemprototypes[componentName])
        production:addComponent(component)
        
        if not evaluated[componentName] then
          queue:put(component)
          evaluated[componentName] = true
        end
      end
    end
  end
  
  return result
end 

function developProduction(item)
  assert(item, "developProduction(nil)")

  local recepies = getAllRecepies()
  local production = evaluate(recepies, item)
  return production
end

remote.addinterface("AutoBP", 
{
  test = test
})
