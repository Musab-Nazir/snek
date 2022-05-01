local unit_size = 20
local speed_factor = 1
local snake_state = {x = 20, y = 20, tail = {}, speed = 0, direction = "+", axis = "x"}
local food_state = {x = 0, y = 0}
local function snake_draw()
  love.graphics.setBackgroundColor(0.121, 0.121, 0.157)
  love.graphics.setColor(0.462, 0.58, 0.416)
  love.graphics.rectangle("fill", (snake_state.x * unit_size), (snake_state.y * unit_size), unit_size, unit_size)
  for _, value in ipairs(snake_state.tail) do
    love.graphics.rectangle("fill", (value[1] * unit_size), (value[2] * unit_size), unit_size, unit_size)
  end
  return nil
end
local function food_draw(x, y)
  love.graphics.setColor(0.863, 0.648, 0.38)
  return love.graphics.rectangle("fill", (food_state.x * unit_size), (food_state.y * unit_size), unit_size, unit_size)
end
local function points_draw()
  love.graphics.setColor(1, 1, 1)
  return love.graphics.print(("Points: " .. #snake_state.tail), 10, 10, 0, 1, 1, 0, 0)
end
local function spawn_food()
  local height_limit = math.floor(((love.graphics.getHeight() - 100) / unit_size))
  local width_limit = math.floor((love.graphics.getWidth() / unit_size))
  math.randomseed(os.time())
  local newX = math.random(width_limit)
  local newY = math.random(height_limit)
  do end (food_state)["x"] = newX
  food_state["y"] = newY
  return nil
end
local function snake_update(deltaTime)
  local direction = snake_state.direction
  local axis = snake_state.axis
  local height_limit = math.floor((love.graphics.getHeight() / unit_size))
  local width_limit = math.floor((love.graphics.getWidth() / unit_size))
  local old_x = snake_state.x
  local old_y = snake_state.y
  if (direction == "+") then
    snake_state[axis] = (snake_state[axis] + 1)
  else
    snake_state[axis] = (snake_state[axis] - 1)
  end
  if ((snake_state.x * unit_size) > love.graphics.getWidth()) then
    snake_state["x"] = 0
  elseif (snake_state.x < 0) then
    snake_state["x"] = width_limit
  else
  end
  if ((snake_state.y * unit_size) > love.graphics.getHeight()) then
    snake_state["y"] = 0
  elseif (snake_state.y < 0) then
    snake_state["y"] = height_limit
  else
  end
  if (#snake_state.tail > 0) then
    for idx, value in ipairs(snake_state.tail) do
      local x = value[1]
      local y = value[2]
      table.insert(snake_state.tail, idx, {old_x, old_y})
      table.remove(snake_state.tail, (idx + 1))
      old_x = x
      old_y = y
    end
  else
  end
  for idx, value in ipairs(snake_state.tail) do
    if ((snake_state.x == value[1]) and (snake_state.y == value[2])) then
      love.event.quit()
    else
    end
  end
  if ((food_state.x == snake_state.x) and (food_state.y == snake_state.y)) then
    spawn_food()
    return table.insert(snake_state.tail, {((snake_state.x * unit_size) - unit_size), ((snake_state.y * unit_size) - unit_size)})
  else
    return nil
  end
end
love.load = function()
  return spawn_food()
end
love.update = function(deltaTime)
  local speed = snake_state.speed
  local direction = snake_state.direction
  local axis = snake_state.axis
  snake_state["speed"] = (speed - speed_factor)
  if (love.keyboard.isDown("d") or love.keyboard.isDown("a")) then
    if ("y" == axis) then
      snake_state["axis"] = "x"
      if love.keyboard.isDown("a") then
        snake_state["direction"] = "-"
      else
        snake_state["direction"] = "+"
      end
    else
    end
  elseif (love.keyboard.isDown("s") or love.keyboard.isDown("w")) then
    if ("x" == axis) then
      snake_state["axis"] = "y"
      if love.keyboard.isDown("s") then
        snake_state["direction"] = "+"
      else
        snake_state["direction"] = "-"
      end
    else
    end
  else
  end
  if (speed < 0) then
    if (#snake_state.tail <= 4) then
      snake_state["speed"] = 15
    elseif (#snake_state.tail <= 9) then
      snake_state["speed"] = 10
    elseif (#snake_state.tail <= 14) then
      snake_state["speed"] = 5
    elseif (#snake_state.tail <= 19) then
      snake_state["speed"] = 1
    else
    end
    return snake_update(deltaTime)
  else
    return nil
  end
end
love.draw = function()
  snake_draw()
  food_draw(food_state.x, food_state.y)
  points_draw()
  love.graphics.print(("Food-x: " .. food_state.x .. " Food-y: " .. food_state.y), 10, 50, 0, 1, 1, 0, 0)
  return love.graphics.print(("Snake-head: " .. snake_state.x .. " " .. snake_state.y), 10, 40, 0, 1, 1, 0, 0)
end
return love.draw
