module Pong.View where

import Color (..)
import Graphics.Element (..)
import Graphics.Collage (..)
import Text

import Pong.Model (..)

view : (Int,Int) -> Game -> Element
view (w,h) {ball,player1,player2} =
  let scores : Element
      scores = txt (Text.height 50) (toString player1.score ++ "  " ++ toString player2.score)
  in
      container w h middle <|
      collage gameWidth gameHeight
        [ rect gameWidth gameHeight
            |> filled pongGreen
        , oval 15 15
            |> make ball
        , rect 10 40
            |> make player1
        , rect 10 40
            |> make player2
        , toForm scores
            |> move (0, gameHeight/2 - 40)
        , toForm (txt identity msg)
            |> move (0, 40 - gameHeight/2)
        ]

pongGreen = rgb 60 100 60

textGreen = rgb 160 200 160

txt f = Text.fromString >> Text.color textGreen >> Text.monospace >> f >> Text.leftAligned

msg = "SPACE to start, WS and &uarr;&darr; to move"

make obj shape =
    shape
      |> filled white
      |> move (obj.x,obj.y)

