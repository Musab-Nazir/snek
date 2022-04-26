; Init State
(local state {:length 2
              :x (/ (love.graphics.getWidth) 2)
              :y (/ (love.graphics.getHeight) 2)
              :speed 150})

(local unit-size 20)
; Mutable state
(var food-x 50)
(var food-y 50)
(var axis :x)
(var direction "+")

(fn snake-draw []
  (love.graphics.rectangle "fill" (. state :x) (. state :y) (* (. state :length) unit-size) unit-size))

(fn snake-update [deltaTime]
  (if (or (love.keyboard.isDown "d") (love.keyboard.isDown "a"))
          (do (set axis :x)
              (if (love.keyboard.isDown "a") 
                  (set direction "-") (set direction "+")))
  (or (love.keyboard.isDown "s") (love.keyboard.isDown "w"))
      (do (set axis :y)
          (if (love.keyboard.isDown "s") 
              (set direction "+") (set direction "-"))))
  (if (= direction "+")
      (tset state axis (+ (. state axis) (* deltaTime (. state :speed))))
      (tset state axis (- (. state axis) (* deltaTime (. state :speed)))))

  (if (> (. state :x) (love.graphics.getWidth))
      (tset state :x 0)
      (< (. state :x) 0)
      (tset state :x (love.graphics.getWidth)))

  (if (> (. state :y) (love.graphics.getHeight))
      (tset state :y 0)
      (< (. state :y) 0)
      (tset state :y (love.graphics.getHeight))))

(fn food-draw [x y]
  (love.graphics.rectangle "fill" x y unit-size unit-size))

; Update
(fn love.update [deltaTime]
  (snake-update deltaTime))

; Render
(fn love.draw []
  "Draw the snake and food"
  (snake-draw)
  (food-draw food-x food-y))

