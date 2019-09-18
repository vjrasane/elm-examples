module Main exposing (..)

import Maybe.Extra
import RemoteData exposing (RemoteData(..))
import Return exposing (Return)


type alias NestedMonad a =
    Return () (Result Never (RemoteData () (Maybe a)))


modifyNestedMonad :
    (a -> b)
    -> NestedMonad a
    -> NestedMonad b
modifyNestedMonad modify monadA =
    let
        get : NestedMonad a -> Maybe a
        get =
            Tuple.first >> Result.toMaybe >> Maybe.andThen RemoteData.toMaybe >> Maybe.Extra.join

        set : Maybe b -> NestedMonad a -> NestedMonad b
        set =
            always >> RemoteData.map >> Result.map >> Return.map
    in
    monadA
        |> get
        |> Maybe.map modify
        |> (\maybeB -> set maybeB monadA)
