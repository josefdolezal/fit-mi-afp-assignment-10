module Main exposing (..)

import Html exposing (programWithFlags)
import Models exposing (Model, Flags, initialModel)
import View exposing (view)
import Update exposing (update)
import Commands exposing (fetchCurrencies, fetchRates)
import Msgs exposing (Msg)
import Time exposing (Time, second)


init : Flags -> (Model, Cmd Msg)
init flags =
    (initialModel flags, fetchCurrencies flags)

subscriptions : Model -> Sub Msg
subscriptions model =
    if model.autorefresh
    then Time.every (5 * second) Msgs.AutoRefresh
    else Sub.none

main : Program Flags Model Msg
main =
    programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
