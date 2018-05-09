module Msgs exposing (..)

import Models exposing (Currency, CurrencyCode, Rate)
import RemoteData exposing (WebData)
import Time exposing (Time)

type Msg
    = OnFetchCurrencies (WebData (List Currency))
    | OnFetchRate (WebData Rate)
    | UpdateBase CurrencyCode String
    | ToggleAutoRefresh
    | AutoRefresh Time