module Pong.Decoder where

import Maybe (withDefault)
import Result (Result(Ok), toMaybe)

import Json.Decode (..)

import Pong.Model (Game, State(Play, Pause), Ball, Player, defaultGame)

decodeGameState : String -> Game
decodeGameState raw = decodeGame raw
  |> toMaybe
  |> withDefault defaultGame

decodeGame : String -> Result String Game
decodeGame raw =
  decodeString
    (object4 Game
      ("state" := decoderState)
      ("ball" := decoderBall)
      ("player1" := decoderPlayer)
      ("player2" := decoderPlayer))
    raw

decoderState : Decoder State
decoderState =
  andThen ("tag" := string) specificState

specificState : String -> Decoder State
specificState tag =
  case tag of
    "pause" -> succeed Pause
    "play" -> succeed Play

decoderBall : Decoder Ball
decoderBall =
  object4 Ball
    ("x" := float)
    ("y" := float)
    ("vx" := float)
    ("vy" := float)

decoderPlayer : Decoder Player
decoderPlayer =
  object5 Player
    ("x" := float)
    ("y" := float)
    ("vx" := float)
    ("vy" := float)
    ("score" := int)
