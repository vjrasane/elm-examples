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
        map : (a -> b) -> NestedMonad a -> NestedMonad b
        map =
            Maybe.map >> RemoteData.map >> Result.map >> Return.map
    in
    map modify monadA
