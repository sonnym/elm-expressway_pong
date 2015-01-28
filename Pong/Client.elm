module Pong.Client where

import Keyboard
import Signal
import Time (..)
import Window

import Pong.View (view)
import Pong.Model (Input, Game)

import Pong.Decoder (decodeGameState)

main = Signal.map2 view Window.dimensions gameState

port receiveGameState : Signal String

port sendInput : Signal Input
port sendInput = input

gameState : Signal Game
gameState = Signal.map decodeGameState receiveGameState

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
