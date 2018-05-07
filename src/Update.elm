module Update exposing (update)

import Models exposing (Model, Currency, Rate, RateValue, CurrencyAmount)
import Msgs exposing (Msg)
import RemoteData exposing (WebData)
import Commands exposing (fetchRates)
import Maybe.Extra exposing (..)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Msgs.UpdateBase newBase value ->
            let
                fValue = Result.withDefault 0 (String.toFloat value)
                newRate = RateValue newBase fValue
            in
            ({ model | rate = Just newRate }, fetchRates newRate.code)

        Msgs.OnFetchCurrencies response ->
            unwrapCurrenciesResponse model response
        
        Msgs.OnFetchRate response ->
            unwrapRateResponse model response

unwrapCurrenciesResponse : Model -> WebData (List Currency) -> (Model, Cmd Msg)
unwrapCurrenciesResponse model response =
    case response of
        RemoteData.Success currencies ->
            let
                newCurrencies = List.map (\c -> CurrencyAmount c Nothing) currencies
            in
            ({ model | currencies = newCurrencies}, Cmd.none)

        _ ->
            ({ model | currencies = [] }, Cmd.none)

unwrapRateResponse : Model -> WebData Rate -> (Model, Cmd Msg)
unwrapRateResponse model response =
    case response of
        RemoteData.Success rate ->
            let
                newCurrencies = Maybe.map (\r -> updateCurrenciesToRate r rate.rates model.currencies) model.rate
            in
            ({ model | currencies = Maybe.withDefault [] newCurrencies }, Cmd.none)

        _ ->
            (model, Cmd.none)

-- Process currencies mapping

updateCurrenciesToRate : RateValue -> List RateValue -> List CurrencyAmount -> List CurrencyAmount
updateCurrenciesToRate initial rates amounts =
    let
        allRates = rates ++ [RateValue initial.code 1] -- Add missing
        pairs = pairRateValuesToCurrencies amounts allRates
    in
    List.map (updateCurrencyAmountByRate initial) pairs

pairRateValuesToCurrencies : List CurrencyAmount -> List RateValue -> List (CurrencyAmount, RateValue)
pairRateValuesToCurrencies amounts rates =
    amounts
        |> List.map (pairRateValueToCurrency rates)
        |> Maybe.Extra.values

pairRateValueToCurrency : List RateValue -> CurrencyAmount -> Maybe (CurrencyAmount, RateValue)
pairRateValueToCurrency rates amount =
    rates
        |> List.filter (\rate -> rate.code == amount.currency.code)
        |> List.head
        |> Maybe.map (\rate -> (amount, rate))

updateCurrencyAmountByRate : RateValue -> (CurrencyAmount, RateValue) -> CurrencyAmount
updateCurrencyAmountByRate initial (amount, rate) =
    { amount | amount = Just (initial.rate * rate.rate) }