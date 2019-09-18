module Main exposing (..)

import RemoteData exposing (RemoteData(..))
import Return exposing (Return)


modifyNestedMonad :
    (a -> b)
    -> Return msg (Result err (RemoteData fail (Maybe a)))
    -> Return msg (Result err (RemoteData fail (Maybe b)))
modifyNestedMonad modify monadA =
    Return.map
        (Result.map
            (RemoteData.map
                (Maybe.map modify)
            )
        )
        monadA
