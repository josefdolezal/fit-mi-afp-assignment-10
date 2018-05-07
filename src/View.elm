module View exposing (..)

import Html exposing (Html, div, text, label, input)
import Html.Attributes exposing (type_)
import Models exposing (Model, Currency)
import Msgs exposing (Msg)

view : Model -> Html Msg
view model =
    div [] (List.map currencyInput model.currencies)

currencyInput : Currency -> Html Msg
currencyInput currency =
    div []
        [ label [] [ text (currency.name ++ " " ++ "(" ++ currency.sign ++ ")") ]
        , input [ type_ "number"] []
        ]
