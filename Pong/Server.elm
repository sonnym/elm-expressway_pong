module Pong.Server where

import Signal

import Pong.Model (Input, Game, defaultGame)
import Pong.State (update)

-- Boilerplate
import Text
main = Text.asText "main"

gameState : Signal Game
gameState =
  Signal.foldp update defaultGame receiveInput

port receiveInput : Signal Input

port sendGameState : Signal Game
port sendGameState = gameState
