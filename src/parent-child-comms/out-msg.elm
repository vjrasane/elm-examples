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
            let
                ( childModel, outMsg ) =
                    childUpdate childMsg model.childModel
            in
            { childModel = childModel
            , state =
                case outMsg of
                    Just (ChangeParentState s) ->
                        s

                    _ ->
                        model.state
            }



-- CHILD


type alias ChildModel =
    { state : State
    }


type OutMsg
    = ChangeParentState State


type ChildMsg
    = ChangeStates State


childUpdate : ChildMsg -> ChildModel -> ( ChildModel, Maybe OutMsg )
childUpdate msg model =
    case msg of
        ChangeStates state ->
            ( { state = state }, Just <| ChangeParentState state )
