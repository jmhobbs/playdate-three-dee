import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/timer"

import "matrix"

local offset = { x = 200, y = 120 };

local tris = {
  {
    v1 = { x = 50, y = 50, z = 50 },
    v2 = { x = -50, y = -50, z = 50 },
    v3 = { x = -50, y = 50, z = -50 },
    color = { 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55 }
  },
  {
    v1 = { x = 50, y = 50, z = 50 },
    v2 = { x = -50, y = -50, z = 50 },
    v3 = { x = 50, y = -50, z = -50 },
    color = { 0x00, 0x55, 0x00, 0x55, 0x00, 0x55, 0x00, 0x55 }
  },
  {
    v1 = { x = -50, y = 50, z = -50 },
    v2 = { x = 50, y = -50, z = -50 },
    v3 = { x = 50, y = 50, z = 50 },
    color = { 0xaa, 0x00, 0xaa, 0x00, 0xaa, 0x00, 0xaa, 0x00 }
  },
  {
    v1 = { x = -50, y = 50, z = -50 },
    v2 = { x = 50, y = -50, z = -50 },
    v3 = { x = 50, y = 50, z = 50 },
    color = { 0xff, 0x00, 0xff, 0x00, 0xff, 0x00, 0xff, 0x00 }
  },
}

local gfx = playdate.graphics;
local pitch = 15; -- pitch in degrees
local heading = 0;

local drawFills = false;

local function drawTranslatedTriangle(v1, v2, v3, fill)
    -- infill
    if drawFills then
      gfx.setPattern(fill)
      gfx.fillTriangle(
        v1.x + offset.x, v1.y + offset.y,
        v2.x + offset.x, v2.y + offset.y,
        v3.x + offset.x, v3.y + offset.y
      )
    end

    -- redraw outline
    gfx.setColor(gfx.kColorBlack)
    gfx.drawTriangle(
      v1.x + offset.x, v1.y + offset.y,
      v2.x + offset.x, v2.y + offset.y,
      v3.x + offset.x, v3.y + offset.y
    )
end

local function drawFrame()
  gfx.clear()

  local headingTransform = {
    math.cos(heading), 0, -1 * math.sin(heading),
    0, 1, 0,
    math.sin(heading), 0, math.cos(heading),
  }

  local rPitch = math.rad(pitch)

  local pitchTransform = {
    1, 0, 0,
    0, math.cos(rPitch), math.sin(rPitch),
    0, -1 * math.sin(rPitch), math.cos(rPitch),
  }

  local matrix = MatrixMultiply(headingTransform, pitchTransform)

  for _, t in ipairs(tris) do
    local v1 = MatrixTransform(matrix, t.v1)
    local v2 = MatrixTransform(matrix, t.v2)
    local v3 = MatrixTransform(matrix, t.v3)
    drawTranslatedTriangle(v1, v2, v3, t.color)
  end
end

local function setup()
  gfx.setLineWidth(2)
  local function tick()
    heading = (heading + 0.025) % 365
    drawFrame()
    playdate.timer.new(5, tick)
  end
  playdate.timer.new(5, tick)
  drawFrame()
end

local crankHeading = true;

local inputHandlers = {
  cranked = function(change, acceleratedChange)
    if crankHeading then
      heading = (heading + (change / 182)) % 365
    else
      pitch = (pitch + (change / 4)) % 365
    end
  end,

  AButtonUp = function ()
    if crankHeading then
      crankHeading = false
    else
      crankHeading = true
    end
  end,

  BButtonUp = function ()
    if drawFills then
      drawFills = false
    else
      drawFills = true
    end
  end,
}

setup()
playdate.inputHandlers.push(inputHandlers)

function playdate.update()
  playdate.timer.updateTimers()
  playdate.drawFPS()
end