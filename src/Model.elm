module Model exposing (..)

import Board exposing (Board)
import Time

type GameState = Running
               | Paused

type alias Model =
    { board: Board
    , state: GameState
    }

type Msg
    = NoOp
    | ToggleTile Int
    | StartSimulation
    | StopSimulation
    | Tick Time.Posix



