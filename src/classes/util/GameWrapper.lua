GameWrapper = {}

function GameWrapper.playerForce()
  return game.player.force
end

function GameWrapper.makeFile(name, data)
  return game.write_file(name, data)
end

function GameWrapper.getAllRecipes()
  return game.player.force.recipes
end

function GameWrapper.getItemByName(name)
  tassert(name, "GameWrapper.getItemByName(nil)")
  local result = game.item_prototypes[name]
  tassert(result, "no such item: " .. name)
  return result
end

function GameWrapper.build(params)
  params.force = GameWrapper.playerForce()
  return game.get_surface(1).create_entity(params)
end

function GameWrapper.print(text)
  game.player.print(tostring(text))
end