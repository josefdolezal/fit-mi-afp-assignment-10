module Commands exposing (fetchCurrencies, fetchRates)

import Http
import Json.Decode as Decode
import Json.Decode.Pipeline exposing(decode, required)
import Msgs exposing(Msg)
import Models exposing (CurrencyCode, Currency, Rate, RateValue, Flags)
import RemoteData

fetchCurrencies : Flags -> Cmd Msg
fetchCurrencies flags =
    request flags "currencies" currenciesDecoder
        |> RemoteData.sendRequest
        |> Cmd.map  Msgs.OnFetchCurrencies

fetchRates : Flags -> CurrencyCode -> Cmd Msg
fetchRates flags code =
    request flags ("exchange-rates/" ++ code) rateDecoder
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

request : Flags -> String -> Decode.Decoder a -> Http.Request a
request flags path decoder =
    let 
        headers = [ authorization flags ]
    in
    Http.request
    { method = "GET"
    , headers = headers
    , url = flags.url ++ "/" ++ path
    , body = Http.emptyBody
    , expect = Http.expectJson decoder
    , timeout = Nothing
    , withCredentials = False
    }

authorization : Flags -> Http.Header
authorization flags =
    Http.header "Authorization" ("token " ++ flags.authToken)
