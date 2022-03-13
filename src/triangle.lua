Triangle = { v1 = nil, v2 = nil, v3 = nil, color = 0 }
Triangle.__index = Triangle

function Triangle.new (v1, v2, v3, color)
  local o = {}
  setmetatable(o, Triangle)
  o.v1 = v1 or nil
  o.v2 = v2 or nil
  o.v3 = v3 or nil
  o.color = color or 0
  return o
end