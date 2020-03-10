module Css exposing (..)

import Html
import Html.Attributes exposing (style)
import Model exposing (Msg)

board : Int -> List (Html.Attribute Msg)
board tiles =
    let repeatTiles = String.concat ["repeat(", String.fromInt tiles, ", 1fr)"]
    in
    [ style "margin" "3rem auto"
    , style "display" "grid"
    , style "grid-template-rows" repeatTiles
    , style "grid-template-columns" repeatTiles
    , style "width" "600px"
    , style "height" "600px"
    , style "border" "1px solid black"
    ]


buttonOn : List (Html.Attribute Msg)
buttonOn =
    style "background-color" "#000" :: button


buttonOff : List (Html.Attribute Msg)
buttonOff =
    style "background-color" "#fff" :: button


button =
    [ style "min-width" "1px"
    , style "min-height" "1px"
    , style "border" ".5px solid black"
    ]

buttonsPanel : List (Html.Attribute Msg)
buttonsPanel =
    [ style "display" "grid"
    , style "grid-template-rows" "1fr"
    , style "grid-template-columns" "repeat(2, 1fr)"
    , style "width" "500px"
    , style "height" "50px"
    , style "margin" ".5rem auto"
    , style "border" "1px solid black"
    ]

