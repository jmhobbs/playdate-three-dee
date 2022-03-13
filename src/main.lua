import "CoreLibs/object"
import "CoreLibs/graphics"
import "CoreLibs/timer"

import "matrix"
import "shapes"

local offset = { x = 200, y = 120 };

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

  local headingTransform = Matrix.new({
    math.cos(heading), 0, -1 * math.sin(heading),
    0, 1, 0,
    math.sin(heading), 0, math.cos(heading),
  })

  local rPitch = math.rad(pitch)

  local pitchTransform = Matrix.new({
    1, 0, 0,
    0, math.cos(rPitch), math.sin(rPitch),
    0, -1 * math.sin(rPitch), math.cos(rPitch),
  })

  local matrix = headingTransform:Multiply(pitchTransform)

  for _, t in ipairs(Tris) do
    local v1 = matrix:Transform(t.v1)
    local v2 = matrix:Transform(t.v2)
    local v3 = matrix:Transform(t.v3)
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