module Msgs exposing (..)

import Models exposing (Currency, Rate)
import RemoteData exposing (WebData)

type Msg
    = OnFetchCurrencies (WebData (List Currency))
    | OnFetchRate (WebData Rate)