require "requires"

function getAllRecepies()
  return game.player.force.recipes
end

function evaluate(recepies, production)
  assert(recepies, "evalulate(recepies = nil)")
  assert(production, "evaluate(production = nil)")
  
  local recepie = recepies[production.item.name]
  if recepie ~= nil then
    for _, component in ipairs(recepie.ingredients) do
      local component = Production.create(game.itemprototypes[component.name])
      evaluate(recepies, component)
      production:addComponent(component)
    end
  end
end 

function developProduction(item)
  assert(item, "developProduction(nil)")

  local recepies = getAllRecepies()
  local production = Production.create(item)
  evaluate(recepies, production)
  return production
end

remote.addinterface("AutoBP", 
{
  test = test
})
