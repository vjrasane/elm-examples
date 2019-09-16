module Main exposing (..)


type alias Out a b =
    ( a, Maybe b )


outMap : (a -> b) -> Out a c -> Out b c
outMap f ( a, c ) =
    ( f a, c )


apply : (a -> b -> a) -> Out a b -> a
apply f ( a, b ) =
    b
        |> Maybe.map (f a)
        |> Maybe.withDefault a



--


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
            childUpdate childMsg model.childModel
                |> outMap
                    (\childModel ->
                        { model | childModel = childModel }
                    )
                |> apply
                    (\updatedModel (ChangeParentState state) ->
                        { updatedModel | state = state }
                    )



-- CHILD


type alias ChildModel =
    { state : State
    }


type OutMsg
    = ChangeParentState State


type ChildMsg
    = ChangeStates State


childUpdate : ChildMsg -> ChildModel -> Out ChildModel OutMsg
childUpdate msg model =
    case msg of
        ChangeStates state ->
            ( { state = state }, Just <| ChangeParentState state )
