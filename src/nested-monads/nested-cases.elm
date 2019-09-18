module Main exposing (..)

import RemoteData exposing (RemoteData(..))
import Return exposing (Return)


modifyNestedMonad :
    (a -> b)
    -> Return msg (Result err (RemoteData fail (Maybe a)))
    -> Return msg (Result err (RemoteData fail (Maybe b)))
modifyNestedMonad modify monadA =
    case monadA of
        ( result, cmd ) ->
            case result of
                Ok remoteData ->
                    case remoteData of
                        Success maybe ->
                            case maybe of
                                Just a ->
                                    ( Ok (Success (Just (modify a))), cmd )

                                Nothing ->
                                    ( Ok (Success Nothing), cmd )

                        Failure failure ->
                            ( Ok (Failure failure), cmd )

                        Loading ->
                            ( Ok Loading, cmd )

                        NotAsked ->
                            ( Ok NotAsked, cmd )

                Err err ->
                    ( Err err, cmd )
