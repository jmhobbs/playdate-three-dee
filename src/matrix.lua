function MatrixMultiply(a, b)
  local result = {
    0, 0, 0,
    0, 0, 0,
    0, 0, 0,
  }
  for row = 0, 2, 1 do
    for col = 0, 2, 1 do
      for i = 0, 2, 1 do
        result[row * 3 + col + 1] =
          result[row * 3 + col + 1]
          + a[ row * 3 + i + 1]
          * b[i * 3 + col + 1]
      end
    end
  end
  return result
end

function MatrixTransform(matrix, vertex)
  local x = vertex.x
  local y = vertex.y
  local z = vertex.z

  return {
    x = (x * matrix[1] + y * matrix[4] + z * matrix[7]),
    y = (x * matrix[2] + y * matrix[5] + z * matrix[8]),
    z = (x * matrix[3] + y * matrix[6] + z * matrix[9]),
  }
end
