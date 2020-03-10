module Main exposing (..)

import Board exposing (fromString)
import Browser
import Css
import Debug exposing (log)
import Dict
import Html.Events exposing (onClick)
import Model exposing (GameState(..), Model, Msg(..))
import Html exposing (Html, button, div, text)
import Time


---- MODEL ----

length = 50

init : ( Model, Cmd Msg )
init =
    (
        { board=fromString (String.repeat (length * length) ".") length
        , state=Paused
        }
    , Cmd.none
    )



---- UPDATE ----
update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case (msg, model) of
        (ToggleTile n, _) -> ( { model | board = ( Board.toggle n model.board ) }, Cmd.none )
        (StartSimulation, _) -> ( { model | state = Running }, Cmd.none)
        (StopSimulation, _) -> ( { model | state = Paused }, Cmd.none)
        (Tick _, _) -> ( { model | board = log "state" (Board.next model.board) }, Cmd.none)
        (_, _) -> ( model, Cmd.none )


----- CSS CLASSES -----

---- VIEW ----
view : Model -> Html Msg
view model =
    div []
        [ createBoardView model
        , createButtonsPanelView
        ]

createBoardView : Model -> Html Msg
createBoardView model =
    let
        toButton idx on =
            case on of
                True -> tileButton idx Css.buttonOn
                False -> tileButton idx Css.buttonOff
        (_, buttons) = Dict.map toButton model.board.state
                |> Dict.toList
                |> List.unzip
    in
        div ( Css.board model.board.size ) ( buttons )



createButtonsPanelView : Html Msg
createButtonsPanelView =
    let
        createButton action btnText =
            button [ onClick action ] [ text btnText ]
    in
        div ( Css.buttonsPanel )
            [ createButton StartSimulation "▶ Play"
            , createButton StopSimulation "❚❚ Pause"
            ]


tileButton idx css =
    button ( onClick ( ToggleTile idx ) :: css ) []

subscriptions : Model -> Sub Msg
subscriptions model =
    case model.state of
        Paused ->
            Sub.none
        Running ->
            Time.every 50 Tick


---- PROGRAM ----
main : Program () Model Msg
main =
    Browser.element
        { view = view
        , init = \_ -> init
        , update = update
        , subscriptions = subscriptions
        }
