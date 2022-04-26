love.draw = function()
  local unit_size = 25
  local snake_length = 2
  local current_width = love.graphics.getWidth()
  local current_height = love.graphics.getHeight()
  local food_x = math.random(current_width)
  local food_y = math.random(current_height)
  love.graphics.rectangle("fill", (current_width / 2), (current_height / 2), (snake_length * unit_size), unit_size)
  return love.graphics.rectangle("fill", food_x, food_y, unit_size, unit_size)
end
return love.draw
