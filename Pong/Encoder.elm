module Pong.Encoder where

import List ((::), append)
import Json.Encode (..)

import Pong.Model (State(Play, Pause), Ball, Player, Game)

encodeGameState : Game -> String
encodeGameState game = toValue game |> encode 0

toValue : Game -> Value
toValue game =
  object
    [ ("state", state game.state)
    , ("ball", ball game.ball)
    , ("player1", player game.player1)
    , ("player2", player game.player2)
    ]

state : State -> Value
state state =
  let
    val = case state of
      Play -> "play"
      Pause -> "pause"
  in
    object [("tag", string val)]

ball : Ball -> Value
ball {x,y,vx,vy} = object (append (position x y) (velocity vx vy))

player : Player -> Value
player {x,y,vx,vy,score} =
  object (("score", int score) :: (append (position x y) (velocity vx vy)))

position : Float -> Float -> List (String, Value)
position x y = [("x", float x), ("y", float y)]

velocity : Float -> Float -> List (String, Value)
velocity vx vy = [("vx", float vx), ("vy", float vy)]
