Queue = {}
Queue.__index = Queue

function Queue.create()
  local queue = {}
  setmetatable(queue, Queue)
  
  queue.first = 0
  queue.last = -1
  
  return queue
end

function Queue:isEmpty()
  return self.last < self.first
end

function Queue:put(item)
  self.last = self.last + 1
  self[self.last] = item
end

function Queue:pull()
  self.first = self.first + 1
  return self[self.first - 1]
end