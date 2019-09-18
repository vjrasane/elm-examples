module Main exposing (Input, Output, unwrapMultiMap)


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


unwrapMultiMap : Input -> Maybe Output
unwrapMultiMap { maybeString, maybeInt, maybeFloat, maybeList, maybeMaybe } =
    Maybe.map5 Output
        maybeString
        maybeInt
        maybeFloat
        maybeList
        maybeMaybe
