module Pong.Server where

import Signal

import Pong.Model (Input)

-- Boilerplate
import Text
main = Text.asText "main"

port receiveInput : Signal Input

port sendInput : Signal Input
port sendInput = receiveInput
