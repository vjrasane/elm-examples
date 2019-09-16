module Main exposing (..)

import Maybe.Extra exposing (andMap)


type alias Input =
    { maybeString : Maybe String
    , maybeInt : Maybe Int
    , maybeFloat : Maybe Float
    , maybeList : Maybe (List ())
    , maybeMaybe : Maybe (Maybe ())
    }


type alias Output =
    { string : String
    , int : Int
    , float : Float
    , list : List ()
    , maybe : Maybe ()
    }



--


unwrapMaybeChaining : Input -> Maybe Output
unwrapMaybeChaining { maybeString, maybeInt, maybeFloat, maybeList, maybeMaybe } =
    Just Output
        |> andMap maybeString
        |> andMap maybeInt
        |> andMap maybeFloat
        |> andMap maybeList
        |> andMap maybeMaybe
