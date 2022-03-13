Vertex = { x = 0, y = 0, z = 0 }
Vertex.__index = Vertex

function Vertex.new(x, y, z)
  local o = {}
  setmetatable(o, Vertex)
  o.x = x or 0
  o.y = y or 0
  o.z = z or 0
  return o
end