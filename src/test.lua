local function writeTest(name, data)
  game.makefile("AutoBP/tests/" .. name .. ".log", data)
end

local function testProduction()
  local tests = {"electronic-circuit", "science-pack-2"}

  for _, test in pairs(tests) do
    local item = game.itemprototypes[test]
    local production = developProduction(item)
    writeTest(test, production:toString())
  end
end

function test()
  testProduction()
end