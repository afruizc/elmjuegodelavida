module Board exposing (..)


import Dict exposing (Dict)
import Maybe exposing (Maybe)

type alias Board =
    { state : Dict Int Bool
    , size: Int
    }

next : Board -> Board
next board =
    let
        newState
            = Dict.map (\idx val -> ((neighborCount board idx), val)) board.state
            |> Dict.map deadOrAlive
    in
        { board | state = newState }


getAtInt : Int -> Board -> Int
getAtInt idx board =
    case getAt idx board of
        True -> 1
        False -> 0


getAt : Int -> Board -> Bool
getAt idx board =
    case Dict.get idx board.state of
        Just x -> x
        Nothing -> False

-- Index must be in bounds
from1Dto2D : Int -> Int -> (Int, Int)
from1Dto2D width idx =
    let
        x = idx // width
        y = idx - (width * x)
    in
        (x, y)

-- Index must be in bounds
from2Dto1D : Int -> (Int, Int) -> Int
from2Dto1D width (x, y) =
    width * x + y


-- Toggle at index
toggle : Int -> Board -> Board
toggle index model =
    let
        currVal = getAt index model

        upd val =
            case val of
                (Just _) -> (Just (not currVal))
                Nothing -> Nothing
        newState =
            Dict.update index upd model.state
    in
        { model | state = newState }



dx = [-1, -1, -1, 0, 0, 1, 1, 1]
dy = [-1, 0, 1, -1, 1, -1, 0, 1]

neighborCount : Board -> Int -> Int
neighborCount board idx =
    let
        addTo (x, y) dxx dyy =
            (x + dxx, y + dyy)

        inside (x, y) =
            x >= 0 && x < board.size
                && y >= 0 && y < board.size

        isAliveAtInt (x, y) =
            getAtInt (from2Dto1D board.size (x, y)) board
    in
        List.map2 (addTo (from1Dto2D board.size idx)) dx dy
            |> List.filter inside
            |> List.map isAliveAtInt
            |> List.sum

deadOrAlive : Int -> (Int, Bool)  -> Bool
deadOrAlive _ ( nCount, cell ) =
    case ( nCount, cell ) of
        (3, _) -> True
        (_, False) -> False
        (2, _) -> True
        (_, _) -> False



fromString : String -> Int -> Board
fromString s size =
    let
        toBool char =
            case char of
                'x' -> True
                _ -> False
        dict = String.toList s
             |> List.map toBool
             |> List.indexedMap Tuple.pair
             |> Dict.fromList
    in
        { state=dict, size=size }
