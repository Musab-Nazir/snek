; Init State
(local unit-size 20)
(local speed-factor 1)

; Mutable state
(local snake-state {:x 20 
                    :y 20 
                    :tail []
                    :speed 0
                    :direction "+"
                    :axis :x})

(local food-state {:x 0 :y 0})

(fn snake-draw []
  (love.graphics.setBackgroundColor 0.121 0.121 0.157)
  (love.graphics.setColor 0.462 0.580 0.4160)
  ; head
  (love.graphics.rectangle  "fill" 
                            (* (. snake-state :x) unit-size)
                            (* (. snake-state :y) unit-size)
                            unit-size 
                            unit-size)
  ; tail
  (each [_ value (ipairs (. snake-state :tail))]
    (love.graphics.rectangle "fill" 
                              (* (. value 1) unit-size) 
                              (* (. value 2) unit-size) 
                              unit-size 
                              unit-size)))

(fn food-draw [x y]
  (love.graphics.setColor 0.863 0.648 0.38)
  (love.graphics.rectangle "fill" 
                            (* (. food-state :x) unit-size) 
                            (* (. food-state :y) unit-size) 
                            unit-size 
                            unit-size))

(fn points-draw []
  (love.graphics.setColor 1 1 1)
  (love.graphics.print (.. "Points: " (length (. snake-state :tail))) 10 10 0 1 1 0 0))

(fn spawn-food []
  (math.randomseed (os.time))
  (let [newX (math.random 45)
        newY (math.random 39)]
  (tset food-state :x newX)
  (tset food-state :y newY)))

(fn snake-update [deltaTime]
  (let [direction (. snake-state :direction)
        axis (. snake-state :axis)]
  (var old-x (. snake-state :x))
  (var old-y (. snake-state :y))
  ; movement
  (if (= direction "+")
      (tset snake-state axis (+ (. snake-state axis) 1))
      (tset snake-state axis (- (. snake-state axis) 1)))
  
  ; out of bounds
  (if (> (* (. snake-state :x) unit-size) (love.graphics.getWidth))
      (tset snake-state :x 0)
      (< (. snake-state :x) 0)
      (tset snake-state :x 50))
  (if (> (* (. snake-state :y) unit-size) (love.graphics.getHeight))
      (tset snake-state :y 0)
      (< (. snake-state :y) 0)
      (tset snake-state :y 40))

  ; tail updates
  (if (> (length (. snake-state :tail)) 0)
    (each [idx value (ipairs (. snake-state :tail))]
      (local x (. value 1))
      (local y (. value 2))
      ; update the tail cords to the head's previous cords
      (table.insert (. snake-state :tail) idx [old-x old-y])
      ; remove the old cords
      (table.remove (. snake-state :tail) (+ idx 1))
      ; update old cords
      (set old-x x)
      (set old-y y)))

  ; self collision
  (each [idx value (ipairs (. snake-state :tail))]
    (if (and (= (. snake-state :x) (. value 1)) (= (. snake-state :y) (. value 2)))
      ; game over
      (love.event.quit)))
  ; food collision
  (when (and (= (. food-state :x) (. snake-state :x)) (= (. food-state :y) (. snake-state :y)))
    ; spawn food at new location
    (spawn-food)
    ; add tail
    (table.insert (. snake-state :tail) [(- (* (. snake-state :x) unit-size) unit-size) (- (* (. snake-state :y) unit-size) unit-size)]))))



; Load
(fn love.load []
  (spawn-food))

; Update
(fn love.update [deltaTime]
  "Update snake-state each time step"
  (let [speed (. snake-state :speed)
        direction (. snake-state :direction)
        axis (. snake-state :axis)]
  (tset snake-state :speed (- speed speed-factor))
  
  ; handle key presses
  (if (or (love.keyboard.isDown "d") (love.keyboard.isDown "a"))
         (when (= :y axis) 
          (tset snake-state :axis :x)
          (if (love.keyboard.isDown "a") 
            (tset snake-state :direction "-") 
            (tset snake-state :direction "+")))
  (or (love.keyboard.isDown "s") (love.keyboard.isDown "w"))
      (when (= :x axis) 
        (tset snake-state :axis :y)
        (if (love.keyboard.isDown "s") 
          (tset snake-state :direction "+") 
          (tset snake-state :direction "-"))))
  
  (when (< speed 0) 
    (do 
      (if (<= (length (. snake-state :tail)) 4)
        (tset snake-state :speed 15)
      (<= (length (. snake-state :tail)) 9)
        (tset snake-state :speed 10)
      (<= (length (. snake-state :tail)) 14)
        (tset snake-state :speed 5)
      (<= (length (. snake-state :tail)) 19)
        (tset snake-state :speed 1))
      (snake-update deltaTime)))))

; Render
(fn love.draw []
  "Draw the snake and food"
  (snake-draw)
  (food-draw (. food-state :x) (. food-state :y))
  (points-draw)
  (love.graphics.print (.. "FPS: " (love.timer.getFPS)) 10 40 0 1 1 0 0))

