Matrix = {
  0, 0, 0,
  0, 0, 0,
  0, 0, 0,
}
Matrix.__index = Matrix

function Matrix.new(t)
  local o = {}
  setmetatable(o, Matrix)
  if t then
    for i, v in ipairs(t) do
      o[i] = v
    end
  end
  return o
end

function Matrix:Multiply(b)
  local result = Matrix.new()

  for row = 0, 2, 1 do
    for col = 0, 2, 1 do
      for i = 0, 2, 1 do
        result[row * 3 + col + 1] =
          result[row * 3 + col + 1]
          + self[row * 3 + i + 1]
          * b[i * 3 + col + 1]
      end
    end
  end

  return result
end

function Matrix:Transform(vertex)
  local x = vertex.x
  local y = vertex.y
  local z = vertex.z

  return {
    x = (x * self[1] + y * self[4] + z * self[7]),
    y = (x * self[2] + y * self[5] + z * self[8]),
    z = (x * self[3] + y * self[6] + z * self[9]),
  }
end
