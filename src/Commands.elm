module Commands exposing (fetchCurrencies, fetchRates)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing(decode, required)
import Msgs exposing(Msg)
import Models exposing (CurrencyCode, Currency, Rate, RateValue)
import RemoteData

fetchCurrencies : Cmd Msg
fetchCurrencies =
    request fetchCurrenciesUrl currenciesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map  Msgs.OnFetchCurrencies

fetchRates : CurrencyCode -> Cmd Msg
fetchRates code =
    request (fetchRatesUrl code) rateDecoder
        |> RemoteData.sendRequest
        |> Cmd.map  Msgs.OnFetchRate

-- Decoding

currenciesDecoder : Decode.Decoder (List Currency)
currenciesDecoder =
    Decode.list currencyDecoder

currencyDecoder : Decode.Decoder Currency
currencyDecoder =
    decode Currency
        |> required "code" Decode.string
        |> required "name" Decode.string
        |> required "sign" Decode.string

rateDecoder : Decode.Decoder Rate
rateDecoder =
    decode Rate
        |> required "base" Decode.string
        |> required "rates" rateValueDecoder

rateValueDecoder : Decode.Decoder (List RateValue)
rateValueDecoder =
    Decode.map mapPairs (Decode.keyValuePairs Decode.float)

mapPairs : List (String, Float) -> List RateValue
mapPairs list =
    List.map (\(code, rate) -> RateValue code rate) list

-- Requests

request : String -> Decode.Decoder a -> Http.Request a
request url decoder =
    let 
        headers = [ ]
    in
    Http.request
    { method = "GET"
    , headers = headers
    , url = url
    , body = Http.emptyBody
    , expect = Http.expectJson decoder
    , timeout = Nothing
    , withCredentials = False
    }

-- URLs

fetchCurrenciesUrl : String
fetchCurrenciesUrl =
    requestUrl "currencies"

fetchRatesUrl : CurrencyCode -> String
fetchRatesUrl code =
    requestUrl ("exchange-rates/" ++ code)

requestUrl : String -> String
requestUrl path =
    baseUrl ++ "/" ++ path

baseUrl : String
baseUrl =
    "http://dummy-currency-api.herokuapp.com"
