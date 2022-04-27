local state = {length = 2, x = (love.graphics.getWidth() / 2), y = (love.graphics.getHeight() / 2)}
local unit_size = 20
local speed = 10
local food_x = 120
local food_y = 480
local axis = "x"
local direction = "+"
local function snake_draw()
  love.graphics.setBackgroundColor(0.121, 0.121, 0.157)
  love.graphics.setColor(0.462, 0.58, 0.416)
  return love.graphics.rectangle("fill", state.x, state.y, (state.length * unit_size), unit_size)
end
local function snake_update(deltaTime)
  if (direction == "+") then
    state[axis] = (state[axis] + unit_size)
  else
    state[axis] = (state[axis] - unit_size)
  end
  if (state.x > love.graphics.getWidth()) then
    state["x"] = 0
  elseif (state.x < 0) then
    state["x"] = love.graphics.getWidth()
  else
  end
  if (state.y > love.graphics.getHeight()) then
    state["y"] = 0
    return nil
  elseif (state.y < 0) then
    state["y"] = love.graphics.getHeight()
    return nil
  else
    return nil
  end
end
local function food_draw(x, y)
  love.graphics.setColor(0.863, 0.648, 0.38)
  return love.graphics.rectangle("fill", x, y, unit_size, unit_size)
end
love.load = function()
end
love.update = function(deltaTime)
  speed = (speed - 1)
  if (love.keyboard.isDown("d") or love.keyboard.isDown("a")) then
    axis = "x"
    if love.keyboard.isDown("a") then
      direction = "-"
    else
      direction = "+"
    end
  elseif (love.keyboard.isDown("s") or love.keyboard.isDown("w")) then
    axis = "y"
    if love.keyboard.isDown("s") then
      direction = "+"
    else
      direction = "-"
    end
  else
  end
  if (speed < 0) then
    speed = 10
    return snake_update(deltaTime)
  else
    return nil
  end
end
love.draw = function()
  snake_draw()
  return food_draw(food_x, food_y)
end
return love.draw
