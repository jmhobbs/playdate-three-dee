import "CoreLibs/graphics"

local screen = { width = 400, height = 240 };
local offset = { x = 200, y = 120 };

local gfx = playdate.graphics;

function RasterizeTriangle(av1, av2, av3, i)
  local v1 = { x = av1.x + offset.x, y = av1.y + offset.y, z = av1.z}
  local v2 = { x = av2.x + offset.x, y = av2.y + offset.y, z = av2.z}
  local v3 = { x = av3.x + offset.x, y = av3.y + offset.y, z = av3.z}

  local minX = math.max(0, math.ceil(math.min(v1.x, math.min(v2.x, v3.x))))
  local maxX = math.min(screen.width - 1, math.floor(math.max(v1.x, math.max(v2.x, v3.x))))

  local minY = math.max(0, math.ceil(math.min(v1.y, math.min(v2.y, v3.y))))
  local maxY = math.min(screen.height - 1, math.floor(math.max(v1.y, math.max(v2.y, v3.y))))

  local area = (v1.y - v3.y) * (v2.x - v3.x) + (v2.y - v3.y) * (v3.x - v1.x);

  for y = minY, maxY, 1 do
    for x = minX, maxX, 1 do
      local b1 = ((y - v3.y) * (v2.x - v3.x) + (v2.y - v3.y) * (v3.x - x)) / area;
      local b2 = ((y - v1.y) * (v3.x - v1.x) + (v3.y - v1.y) * (v1.x - x)) / area;
      local b3 = ((y - v2.y) * (v1.x - v2.x) + (v1.y - v2.y) * (v2.x - x)) / area;
      if b1 >= 0 and b1 <= 1 and b2 >= 0 and b2 <= 1 and b3 >= 0 and b3 <= 1 then
        if (i == 1 and x % 2 == 0) or (i == 2 and y % 2 == 0 ) or (i == 3 and x % 2 ~= 0 ) or i == 4 then
          gfx.drawPixel(x, y);
        end
      end
    end
  end
end