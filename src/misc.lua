function tassert(condition, message)
  if not condition then
    local fullMessage = message .. "\n" .. debug.traceback()
    GameWrapper.makeFile("AutoBP/lasterror.log", fullMessage)
    assert(false, message)
  end
end