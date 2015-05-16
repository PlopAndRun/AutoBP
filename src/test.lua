local function writeTest(name, data)
  game.makefile("AutoBP/tests/" .. name .. ".log", data)
end

function testProduction()
  local tests = {"electronic-circuit", "science-pack-1", "science-pack-2"}

  for _, test in pairs(tests) do
    local item = game.itemprototypes[test]
    local production = developProduction(item)
    writeTest(test, production:toString())
  end
end

function testBuildFactory()
  print("testing build factory")
  local item = "science-pack-2"
  local production = developProduction(game.itemprototypes[item])
  buildFactory(production)
end