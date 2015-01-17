module Pong.State where

import Keyboard
import Signal
import Time (..)

import Pong.Model (..)

delta =
  Signal.map inSeconds (fps 35)

input : Signal Input
input =
  Signal.sampleOn delta <|
    Signal.map4 Input
      Keyboard.space
      (Signal.map .y Keyboard.wasd)
      (Signal.map .y Keyboard.arrows)
      delta

gameState : Signal Game
gameState =
  Signal.foldp update defaultGame input

update : Input -> Game -> Game
update {space,dir1,dir2,delta} ({state,ball,player1,player2} as game) =
  let score1 = if ball.x >  halfWidth then 1 else 0
      score2 = if ball.x < -halfWidth then 1 else 0

      newState =
        if  | space            -> Play
            | score1 /= score2 -> Pause
            | otherwise        -> state

      newBall =
        if state == Pause
            then ball
            else updateBall delta ball player1 player2

  in
      { game |
          state <- newState,
          ball <- newBall,
          player1 <- updatePlayer delta dir1 score1 player1,
          player2 <- updatePlayer delta dir2 score2 player2
      }


updateBall : Time -> Ball -> Player -> Player -> Ball
updateBall t ({x,y,vx,vy} as ball) p1 p2 =
  if not (ball.x |> near 0 halfWidth)
    then { ball | x <- 0, y <- 0 }
    else physicsUpdate t
            { ball |
                vx <- stepV vx (ball `within` p1) (ball `within` p2),
                vy <- stepV vy (y < 7-halfHeight) (y > halfHeight-7)
            }


updatePlayer : Time -> Int -> Int -> Player -> Player
updatePlayer t dir points player =
  let player1 = physicsUpdate  t { player | vy <- toFloat dir * 200 }
  in
      { player1 |
          y <- clamp (22-halfHeight) (halfHeight-22) player1.y,
          score <- player.score + points
      }


physicsUpdate t ({x,y,vx,vy} as obj) =
  { obj |
      x <- x + vx * t,
      y <- y + vy * t
  }


near k c n =
    n >= k-c && n <= k+c

within ball paddle =
    near paddle.x 8 ball.x && near paddle.y 20 ball.y


stepV v lowerCollision upperCollision =
  if | lowerCollision -> abs v
     | upperCollision -> 0 - abs v
     | otherwise      -> v
