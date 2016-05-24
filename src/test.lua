local function writeTest(name, data)
  GameWrapper.makeFile("AutoBP/tests/" .. name .. ".log", data)
end

function testProduction()
  local tests = {"electronic-circuit", "science-pack-1", "science-pack-2"}

  for _, test in pairs(tests) do
    local item = GameWrapper.getItemByName(test)
    local production = developProduction(item)
    writeTest(test, production:toString())
  end
end

function testBuildFactory()
  local item = "science-pack-2"
  local production = developProduction(GameWrapper.getItemByName(item))
  writeTest(item, production:toString())
  buildFactory(production)
end