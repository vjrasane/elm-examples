module Main exposing (..)


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


unwrapIfClause : Input -> Maybe Output
unwrapIfClause { maybeString, maybeInt, maybeFloat, maybeList, maybeMaybe } =
    if
        (maybeString /= Nothing)
            && (maybeInt /= Nothing)
            && (maybeFloat /= Nothing)
            && (maybeList /= Nothing)
            && (maybeMaybe /= Nothing)
    then
        Just
            { string = maybeString |> Maybe.withDefault ""
            , int = maybeInt |> Maybe.withDefault 0
            , float = maybeFloat |> Maybe.withDefault 0
            , list = maybeList |> Maybe.withDefault []
            , maybe = maybeMaybe |> Maybe.withDefault Nothing
            }

    else
        Nothing
