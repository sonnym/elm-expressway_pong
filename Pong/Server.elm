module Pong.Server where

import Signal

import Pong.Model (Input, Game, defaultGame)
import Pong.State (update)

import Pong.Encoder (encodeGameState)

-- Boilerplate
import Text
main = Text.asText "main"

gameState : Signal Game
gameState =
  Signal.foldp update defaultGame receiveInput

port receiveInput : Signal Input

port sendGameState : Signal String
port sendGameState = Signal.map encodeGameState gameState
