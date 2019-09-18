module Main exposing (..)

import RemoteData exposing (RemoteData(..))
import Return exposing (Return)


modifyNestedMonad :
    (a -> b)
    -> Return msg (Result err (RemoteData fail (Maybe a)))
    -> Maybe b
modifyNestedMonad modify monadA =
    case monadA of
        ( Ok (Success (Just a)), cmd ) ->
            Just (modify a)

        _ ->
            Nothing
