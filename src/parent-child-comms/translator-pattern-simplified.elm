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
    | ChildMsg InternalMsg
    | ChangeState State


parentUpdate : ParentMsg -> ParentModel -> ParentModel
parentUpdate msg model =
    case msg of
        OwnMsg ->
            model

        ChildMsg childMsg ->
            { model | childModel = childUpdate childMsg model.childModel }

        ChangeState state ->
            { model | state = state }


translator : ChildMsg -> ParentMsg
translator msg =
    case msg of
        InternalMsg internal ->
            ChildMsg internal

        ExternalMsg (ChangeParentState state) ->
            ChangeState state



-- CHILD


type alias ChildModel =
    { state : State
    }


type ChildMsg
    = ExternalMsg ExternalMsg
    | InternalMsg InternalMsg


type ExternalMsg
    = ChangeParentState State


type InternalMsg
    = ChangeOwnState State


childUpdate : InternalMsg -> ChildModel -> ChildModel
childUpdate msg model =
    case msg of
        ChangeOwnState state ->
            { state = state }
