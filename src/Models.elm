module Models exposing (..)

type alias Model =
    { currencies : List CurrencyAmount
    , autorefresh : Bool
    , rate : Maybe RateValue
    , flags: Flags
    }

initialModel : Flags -> Model
initialModel flags =
    { currencies = []
    , autorefresh = False
    , rate = Nothing
    , flags = flags
    }

type alias Flags =
    { url: String
    , authToken: String
    }

type alias CurrencyAmount =
    { currency: Currency
    , amount: Maybe Float
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