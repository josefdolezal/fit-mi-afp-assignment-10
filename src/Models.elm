module Models exposing (..)

import Dict exposing (Dict)
import RemoteData exposing (WebData)

type alias Model =
    { currencies: WebData (List Currency)
    , autorefresh: Bool
    }

initialModel : Model
initialModel =
    { currencies = RemoteData.Loading
    , autorefresh = False
    }

type alias CurrencyCode =
    String

type alias Currency =
    { code : CurrencyCode
    , name : String
    , sign : String
    }

type alias Rate =
    { base : CurrencyCode
    , rates : List RateValue
    }

type alias RateValue =
    Dict CurrencyCode Float