module Models exposing (..)

type alias Model =
    { currencies: List Currency
    , autorefresh: Bool
    }

initialModel : Model
initialModel =
    { currencies = []
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
    { code : CurrencyCode
    , rate : Float
    }