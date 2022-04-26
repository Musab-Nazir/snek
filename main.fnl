(fn love.draw []
  "Draw the starting snake body and food"
	(let [unit-size 25 
				snake-length 2
				current-width (love.graphics.getWidth)
				current-height (love.graphics.getHeight)
				food-x (math.random current-width)
				food-y (math.random current-height)]
  (love.graphics.rectangle "fill" (/ current-width 2) (/ current-height 2) (* snake-length unit-size) unit-size)
	(love.graphics.rectangle "fill" food-x food-y unit-size unit-size)))
