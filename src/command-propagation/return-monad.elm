module Main exposing (..)

import Return exposing (Return)
import Task



-- PARENT


type alias ParentModel =
    { childModel : ChildModel
    }


type ParentMsg
    = ChildMsg ChildMsg
    | ParentResult (Result Never ())


parentUpdate : ParentMsg -> ParentModel -> Return ParentMsg ParentModel
parentUpdate msg model =
    case msg of
        ChildMsg childMsg ->
            let
                parentCmd : Cmd ParentMsg
                parentCmd =
                    Task.attempt ParentResult (Task.succeed ())
            in
            childUpdate childMsg model.childModel
                |> Return.map (\childModel -> { childModel = childModel })
                |> Return.mapCmd ChildMsg
                |> Return.command parentCmd

        ParentResult _ ->
            Return.singleton model



-- CHILD


type alias ChildModel =
    {}


type ChildMsg
    = ChildResult (Result Never ())


childUpdate : ChildMsg -> ChildModel -> Return ChildMsg ChildModel
childUpdate msg model =
    case msg of
        ChildResult _ ->
            let
                childCmd : Cmd ChildMsg
                childCmd =
                    Task.attempt ChildResult (Task.succeed ())
            in
            ( model, childCmd )
