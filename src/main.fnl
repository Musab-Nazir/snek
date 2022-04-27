; Init State
(local state {:length 1
              :x 20
              :y 20})

(local unit-size 20)
; Mutable state
(var speed 10)
(var food-x 0) 
(var food-y 0)
(var axis :x)
(var direction "+")

(fn snake-draw []
  (love.graphics.setBackgroundColor 0.121 0.121 0.157)
  (love.graphics.setColor 0.462 0.580 0.4160)
  (love.graphics.rectangle  "fill" 
                            (* (. state :x) unit-size)
                            (* (. state :y) unit-size)
                            (* (. state :length) unit-size) 
                            unit-size))

(fn spawn-food []
  (math.randomseed (os.time))
  (let [newX (math.random 50)
        newY (math.random 40)]
  (set food-x  newX)
  (set food-y newY)))

(fn snake-update [deltaTime]
  ; movement
  (if (= direction "+")
      (tset state axis (+ (. state axis) 1))
      (tset state axis (- (. state axis) 1)))
  
  ; out of bounds
  (if (> (* (. state :x) unit-size) (love.graphics.getWidth))
      (tset state :x 0)
      (<= (. state :x) 0)
      (tset state :x 50))
  (if (> (* (. state :y) unit-size) (love.graphics.getHeight))
      (tset state :y 0)
      (<= (. state :y) 0)
      (tset state :y 40))

  ; collision
  (when (and (= food-x (. state :x)) (= food-y (. state :y)))
    (spawn-food)))

(fn food-draw [x y]
  (love.graphics.setColor 0.863 0.648 0.38)
  (love.graphics.rectangle "fill" (* food-x unit-size) (* food-y unit-size) unit-size unit-size))

(fn love.load []
  (spawn-food))

; Update
(fn love.update [deltaTime]
  "Update state each time step"
  (set speed (- speed 1))
  
  ; handle key presses
  (if (or (love.keyboard.isDown "d") (love.keyboard.isDown "a"))
          (do (set axis :x)
              (if (love.keyboard.isDown "a") 
                  (set direction "-") (set direction "+")))
  (or (love.keyboard.isDown "s") (love.keyboard.isDown "w"))
      (do (set axis :y)
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
  (food-draw food-x food-y))

