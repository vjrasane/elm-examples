module Main exposing (..)

import Task



-- PARENT


type alias ParentModel =
    { childModel : ChildModel
    }


type ParentMsg
    = ChildMsg ChildMsg
    | ParentResult (Result Never ())


parentUpdate : ParentMsg -> ParentModel -> ( ParentModel, Cmd ParentMsg )
parentUpdate msg model =
    case msg of
        ChildMsg childMsg ->
            let
                ( childModel, childCmd ) =
                    childUpdate childMsg model.childModel

                mappedCmd : Cmd ParentMsg
                mappedCmd =
                    Cmd.map ChildMsg childCmd

                parentCmd : Cmd ParentMsg
                parentCmd =
                    Task.attempt ParentResult (Task.succeed ())
            in
            ( { childModel = childModel }
            , Cmd.batch
                [ parentCmd
                , mappedCmd
                ]
            )

        ParentResult _ ->
            ( model, Cmd.none )



-- CHILD


type alias ChildModel =
    {}


type ChildMsg
    = ChildResult (Result Never ())


childUpdate : ChildMsg -> ChildModel -> ( ChildModel, Cmd ChildMsg )
childUpdate msg model =
    case msg of
        ChildResult _ ->
            let
                childCmd : Cmd ChildMsg
                childCmd =
                    Task.attempt ChildResult (Task.succeed ())
            in
            ( model, childCmd )
