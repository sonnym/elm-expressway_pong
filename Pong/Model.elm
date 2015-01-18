module Pong.Model where

import Time (..)

(gameWidth,gameHeight) = (600,400)
(halfWidth,halfHeight) = (300,200)

type alias Ball =
  { x:Float, y:Float, vx:Float, vy:Float }

type alias Player =
  { x:Float, y:Float, vx:Float, vy:Float, score:Int }

type alias Game =
  { ball:Ball, player1:Player, player2:Player }


player : Float -> Player
player x =
  { x = x, y = 0, vx = 0, vy = 0, score = 0 }

defaultGame : Game
defaultGame =
  { ball    = { x=0, y=0, vx=200, vy=200 }
  , player1 = player (20-halfWidth)
  , player2 = player (halfWidth-20)
  }


type alias Input =
    { space : Bool
    , dir1 : Int
    , dir2 : Int
    , delta : Time
    }
