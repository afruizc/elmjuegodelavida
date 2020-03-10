module Tests exposing (..)

import Board exposing (Board, fromString)
import Expect exposing (Expectation)
import Test exposing (describe, test)


-- Check out https://package.elm-lang.org/packages/elm-explorations/test/latest to learn more about testing in Elm!

assertEqualsString : Board -> String -> Expectation
assertEqualsString board boardStr
    = Expect.equal board (fromString boardStr board.size)


suite =
    describe "Board module"
        [ describe "board treatment" -- Nest as many descriptions as you like.
            [ test "toggles the element at index 1" <|
                \_ ->
                    let
                        s = fromString "...." 2
                    in
                        assertEqualsString (Board.toggle 0 s) "x..."

            , test "toggles the element at index 3" <|
                \_ ->
                    let
                        s = fromString "xxx." 2
                    in
                        assertEqualsString (Board.toggle 3 s) "xxxx"
            ]
        , describe "Get neighbor count"
            [ test "returns number of neighbors when all off" <|
               \_ ->
                    let
                        s = fromString "...." 2
                    in
                        Expect.equal (Board.neighborCount s 0)  0
            , test "returns neigbors one alive" <|
                \_ ->
                    let
                        s = fromString ".x.." 2
                    in
                        Expect.equal (Board.neighborCount s 0)  1
            , test "returns neighbors all alive" <|
                \_ ->
                    let
                        s = fromString ".xxx" 2
                    in
                        Expect.equal (Board.neighborCount s 0)  3
            , test "returns neighbors check all around" <|
                \_ ->
                    let
                        s = fromString ".xxxx.x.." 3
                    in
                        Expect.equal (Board.neighborCount s 4)  4
            ]
        , describe "get new world"
            [ test "returns number of neighbors when all off" <|
                \_ ->
                    let
                        given = fromString ".x..x..x." 3
                        expected = fromString "...xxx..." 3
                    in
                        Expect.equal ( Board.next given ) expected
            ]
        ]
