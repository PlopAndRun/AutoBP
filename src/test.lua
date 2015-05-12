local function writeTest(name, data)
  game.makefile("AutoBP/tests/" .. name .. ".log", data)
end

local function testProduction()
  local electronicCircuit = game.itemprototypes["electronic-circuit"]
  local electronicCircuitProduction = developProduction(electronicCircuit)
  writeTest("electronicCircuit", electronicCircuitProduction:toString())
  
  local sciencePack2 = game.itemprototypes["science-pack-2"]
  local sciencePack2Production = developProduction(sciencePack2)
  writeTest("sciencePack2", sciencePack2Production:toString())
end

function test()
  testProduction()
end