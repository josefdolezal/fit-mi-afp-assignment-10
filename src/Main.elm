module Main exposing (..)

import Html exposing (program)
import Models exposing (Model, initialModel)
import View exposing (view)
import Update exposing (update)
import Commands exposing (fetchCurrencies, fetchRates)
import Msgs exposing (Msg)


init : (Model, Cmd Msg)
init =
    (initialModel, fetchCurrencies)

main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = always Sub.none
        }
