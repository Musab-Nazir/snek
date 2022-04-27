; Init State
(local state {:x 20
              :y 20
              :tail []})

(local unit-size 20)
; Mutable state
(var speed 10)
(var speed-factor 1)
(var food-x 0) 
(var food-y 0)
(var axis :x)
(var direction "+")

(fn snake-draw []
  (love.graphics.setBackgroundColor 0.121 0.121 0.157)
  (love.graphics.setColor 0.462 0.580 0.4160)
  ; head
  (love.graphics.rectangle  "fill" 
                            (* (. state :x) unit-size)
                            (* (. state :y) unit-size)
                            unit-size 
                            unit-size)
  ; tail
  (each [_ value (ipairs (. state :tail))]
    (love.graphics.rectangle "fill" (* (. value 1) unit-size) (* (. value 2) unit-size) unit-size unit-size)))

(fn food-draw [x y]
  (love.graphics.setColor 0.863 0.648 0.38)
  (love.graphics.rectangle "fill" (* food-x unit-size) (* food-y unit-size) unit-size unit-size))

(fn points-draw []
  (love.graphics.setColor 1 1 1)
  (love.graphics.print (.. "Points: " (length (. state :tail))) 10 10 0 1 1 0 0)
)

(fn spawn-food []
  (math.randomseed (os.time))
  (let [newX (math.random 40)
        newY (math.random 40)]
  (set food-x  newX)
  (set food-y newY)))

(fn snake-update [deltaTime]
  (var old-x (. state :x))
  (var old-y (. state :y))
  ; movement
  (if (= direction "+")
      (tset state axis (+ (. state axis) 1))
      (tset state axis (- (. state axis) 1)))
  
  ; out of bounds
  (if (> (* (. state :x) unit-size) (love.graphics.getWidth))
      (tset state :x 0)
      (< (. state :x) 0)
      (tset state :x 50))
  (if (> (* (. state :y) unit-size) (love.graphics.getHeight))
      (tset state :y 0)
      (< (. state :y) 0)
      (tset state :y 40))

  ; tail updates
  (if (> (length (. state :tail)) 0)
    (each [idx value (ipairs (. state :tail))]
      (local x (. value 1))
      (local y (. value 2))
      ; update the tail cords to the head's previous cords
      (table.insert (. state :tail) idx [old-x old-y])
      ; remove the old cords
      (table.remove (. state :tail) (+ idx 1))
      ; update old cords
      (set old-x x)
      (set old-y y)
  ))
  ; self collision
  (each [idx value (ipairs (. state :tail))]
    (if (and (= (. state :x) (. value 1)) (= (. state :y) (. value 2)))
      ; game over
      (love.event.quit)
    )
  )
  ; food collision
  (when (and (= food-x (. state :x)) (= food-y (. state :y)))
    ; spawn food at new location
    (spawn-food)
    ; increase speed
    (set speed-factor (+ 1 speed-factor))
    ; add tail
    (table.insert (. state :tail) [(- (* (. state :x) unit-size) unit-size) (- (* (. state :y) unit-size) unit-size)])))



; Load
(fn love.load []
  (spawn-food))

; Update
(fn love.update [deltaTime]
  "Update state each time step"
  (set speed (- speed speed-factor))
  
  ; handle key presses
  (if (or (love.keyboard.isDown "d") (love.keyboard.isDown "a"))
         (when (= :y axis) 
          (set axis :x)
          (if (love.keyboard.isDown "a") 
            (set direction "-") (set direction "+")))
  (or (love.keyboard.isDown "s") (love.keyboard.isDown "w"))
      (when (= :x axis) 
        (set axis :y)
        (if (love.keyboard.isDown "s") 
          (set direction "+") (set direction "-"))))
  
  (when (<  speed 0) 
    (do 
      (set speed 10)
      (snake-update deltaTime))))

; Render
(fn love.draw []
  "Draw the snake and food"
  (snake-draw)
  (food-draw food-x food-y)
  (points-draw))

