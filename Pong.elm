module Pong where

import Signal
import Window

import Pong.View (view)
import Pong.Model (Input)
import Pong.State (gameState, input)

main =
  Signal.map2 view Window.dimensions gameState

port sendInput : Signal Input
port sendInput = input
