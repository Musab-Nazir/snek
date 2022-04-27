; Init State
(local state {:length 2
              :x (/ (love.graphics.getWidth) 2)
              :y (/ (love.graphics.getHeight) 2)})

(local unit-size 20)
; Mutable state
(var speed 10)
(var food-x 120) 
(var food-y 480)
(var axis :x)
(var direction "+")

(fn snake-draw []
  (love.graphics.setColor 220 165 97)
  (love.graphics.rectangle  "fill" 
                            (. state :x) 
                            (. state :y) 
                            (* (. state :length) unit-size) 
                            unit-size))

(fn snake-update [deltaTime]
  ; movement
  (if (= direction "+")
      (tset state axis (+ (. state axis) unit-size))
      (tset state axis (- (. state axis) unit-size)))
  
  ; out of bounds
  (if (> (. state :x) (love.graphics.getWidth))
      (tset state :x 0)
      (< (. state :x) 0)
      (tset state :x (love.graphics.getWidth)))
  (if (> (. state :y) (love.graphics.getHeight))
      (tset state :y 0)
      (< (. state :y) 0)
      (tset state :y (love.graphics.getHeight)))

  ; collision
      )

(fn food-draw [x y]
  (love.graphics.setColor 118 148 106)
  (love.graphics.rectangle "fill" x y unit-size unit-size))

(fn love.load []
)

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

