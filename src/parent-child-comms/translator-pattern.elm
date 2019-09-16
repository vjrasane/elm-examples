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


translatorDictionary =
    { onInternalMessage = ChildMsg
    , onChangeParentState = ChangeState
    }



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


type alias TranslationDictionary msg =
    { onInternalMessage : InternalMsg -> msg
    , onChangeParentState : State -> msg
    }


type alias Translator parentMsg =
    ChildMsg -> parentMsg


translator : TranslationDictionary parentMsg -> Translator parentMsg
translator { onInternalMessage, onChangeParentState } msg =
    case msg of
        InternalMsg internal ->
            onInternalMessage internal

        ExternalMsg (ChangeParentState state) ->
            onChangeParentState state


childUpdate : InternalMsg -> ChildModel -> ChildModel
childUpdate msg model =
    case msg of
        ChangeOwnState state ->
            { state = state }
