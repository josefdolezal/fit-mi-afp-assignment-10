module Update exposing (..)

import Models exposing (Model, Currency, Rate)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.OnFetchCurrencies response ->
            unwrapCurrenciesResponse model response
        
        Msgs.OnFetchRate response ->
            unwrapRateResponse model response

unwrapCurrenciesResponse : Model -> WebData (List Currency) -> (Model, Cmd Msg)
unwrapCurrenciesResponse model response =
    case response of
        RemoteData.Success currencies ->
            ({ model | currencies = currencies}, Cmd.none)

        _ ->
            ({ model | currencies = [] }, Cmd.none)

unwrapRateResponse : Model -> WebData Rate -> (Model, Cmd Msg)
unwrapRateResponse model response =
    case response of
        RemoteData.Success rate ->
            (model, Cmd.none)

        _ ->
            (model, Cmd.none)
