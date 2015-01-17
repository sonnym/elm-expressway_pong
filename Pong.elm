module Pong where

import Signal
import Window

import Pong.View (view)
import Pong.State (gameState)

main =
  Signal.map2 view Window.dimensions gameState
