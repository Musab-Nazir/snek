local state = {length = 1, x = 20, y = 20}
local unit_size = 20
local speed = 10
local food_x = 0
local food_y = 0
local axis = "x"
local direction = "+"
local function snake_draw()
  love.graphics.setBackgroundColor(0.121, 0.121, 0.157)
  love.graphics.setColor(0.462, 0.58, 0.416)
  return love.graphics.rectangle("fill", (state.x * unit_size), (state.y * unit_size), (state.length * unit_size), unit_size)
end
local function spawn_food()
  math.randomseed(os.time())
  local newX = math.random(50)
  local newY = math.random(40)
  food_x = newX
  food_y = newY
  return nil
end
local function snake_update(deltaTime)
  if (direction == "+") then
    state[axis] = (state[axis] + 1)
  else
    state[axis] = (state[axis] - 1)
  end
  if ((state.x * unit_size) > love.graphics.getWidth()) then
    state["x"] = 0
  elseif (state.x <= 0) then
    state["x"] = 50
  else
  end
  if ((state.y * unit_size) > love.graphics.getHeight()) then
    state["y"] = 0
  elseif (state.y <= 0) then
    state["y"] = 40
  else
  end
  if ((food_x == state.x) and (food_y == state.y)) then
    return spawn_food()
  else
    return nil
  end
end
local function food_draw(x, y)
  love.graphics.setColor(0.863, 0.648, 0.38)
  return love.graphics.rectangle("fill", (food_x * unit_size), (food_y * unit_size), unit_size, unit_size)
end
love.load = function()
  return spawn_food()
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
