module Main exposing (..)

import Html exposing (program)
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Commands exposing (fetchCurrencies, fetchRates)
import Msgs exposing (Msg)
import Time exposing (Time, second)


init : (Model, Cmd Msg)
init =
    (initialModel, fetchCurrencies)

subscriptions : Model -> Sub Msg
subscriptions model =
    if model.autorefresh
    then Time.every (5 * second) Msgs.AutoRefresh
    else Sub.none

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
