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


unwrapSwitchCase : Input -> Maybe Output
unwrapSwitchCase { maybeString, maybeInt, maybeFloat, maybeList, maybeMaybe } =
    case ( maybeString, maybeInt, maybeFloat ) of
        ( Just string, Just int, Just float ) ->
            case ( maybeList, maybeMaybe ) of
                ( Just list, Just maybe ) ->
                    Just <|
                        Output
                            string
                            int
                            float
                            list
                            maybe

                ( _, _ ) ->
                    Nothing

        ( _, _, _ ) ->
            Nothing
