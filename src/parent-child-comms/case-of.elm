module Main exposing (..)


type State
    = Active
    | Inactive



-- PARENT


type alias ParentModel =
    { childModel : ChildModel
    , state : State
    }


type ParentMsg
    = OwnMsg
    | ChildMsg ChildMsg


parentUpdate : ParentMsg -> ParentModel -> ParentModel
parentUpdate msg model =
    case msg of
        OwnMsg ->
            model

        ChildMsg childMsg ->
            { childModel = childUpdate childMsg model.childModel
            , state =
                case childMsg of
                    ChangeParentState state ->
                        state

                    _ ->
                        model.state
            }



-- CHILD


type alias ChildModel =
    { state : State
    }


type ChildMsg
    = ChangeOwnState State
    | ChangeParentState State


childUpdate : ChildMsg -> ChildModel -> ChildModel
childUpdate msg model =
    case msg of
        ChangeOwnState state ->
            { state = state }

        _ ->
            model
