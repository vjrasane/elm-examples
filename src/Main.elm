module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import RemoteData exposing (RemoteData(..), WebData)
import Return exposing (Return)



-- main =
--   Browser.sandbox { init = init, update = update, view = view }
-- -- MODEL
-- type Validated a =
--   Valid a
--   | Invalid String
-- type alias Model =
--   {
--   message: Maybe String
--   ,number: Int
--   }
-- type alias ValidatedModel =
--   {
--       message: Validated String
--       ,number: Validated Int
--   }
-- type alias Validator input output =
--   input -> Validated output
-- validateMessage : String -> Validator (Maybe String) String
-- validateMessage error input =
--   input |> Maybe.map Valid |> Maybe.withDefault (Invalid error)
-- validateNumber : String -> Validator Int Int
-- validateNumber error input =
--   if input < 5 then
--     Invalid error
--   else
--     Valid input
-- -- verify : (bigger -> smaller)
-- --   -> Validator smaller verified
-- --   -> (bigger -> Validated verified)
-- -- verify accessor verifier input  =
-- --    input |> accessor |> verifier
-- -- validate : Model -> ValidatedModel
-- -- validate =
-- --   ValidatedModel
-- --     <| verify .message (validateMessage "NOT VALID")
-- --     <| verify .number (validateNumber "NOT BIG ENOUGH")
-- -- ok : finally -> Validator input finally
-- -- ok finally _ = Ok finally
-- -- fail : String -> Validator input verified
-- -- fail error _ = Err error
-- -- validate : finally -> (input -> finally)
-- -- validate =
-- -- verify : (bigger -> smaller)
-- --   -> Validator smaller verified
-- --   -> Validator bigger (verified -> finally)
-- --   -> Validator bigger finally
-- -- verify finally first second =
-- --   second |> custom (finally >> first)
-- -- custom :
-- --     Validator input verified
-- --     -> Validator input (verified -> finally)
-- --     -> Validator input finally
-- -- custom v2 v1 input =
-- --     case ( v1 input, v2 input ) of
-- --         ( Ok r1, Ok r2 ) ->
-- --             Ok (r1 r2)
-- --         ( Err ( e1 ), Err ( e2 ) ) ->
-- --             Err ( e1 )
-- --         ( Err e1, _ ) ->
-- --             Err e1
-- --         ( _, Err e2 ) ->
-- --             Err e2
-- -- validator : Validator Model ValidatedModel
-- -- validator model =
-- --   validate ValidatedModel
-- --     |>
-- init : Model
-- init =
--   Model
--     (Nothing)
--     0
-- -- UPDATE
-- type Msg = Toggle
-- toggle : Model -> Model
-- toggle model =
--       model
-- update msg model =
--   case msg of
--     Toggle ->
--       toggle model
-- -- VIEW
-- view : Model -> Html Msg
-- view model =
--   let
--       _ = model |> validate |> Debug.log "VERIFIED"
--   in
--   div [] [  model.message |> Maybe.withDefault "" |> text ]


exampleUltraGood : Return msg (WebData (List (Maybe String))) -> List Int
exampleUltraGood =
    (Return.map << RemoteData.map << List.map << Maybe.andThen)
        String.toInt
        >> (Tuple.first >> RemoteData.withDefault [] >> List.filterMap identity)
