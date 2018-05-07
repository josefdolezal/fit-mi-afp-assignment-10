module View exposing (..)

import Html exposing (Html, div, text, label, input)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onInput)
import Models exposing (Model, CurrencyAmount)
import Msgs exposing (Msg)

view : Model -> Html Msg
view model =
    div [] (List.map currencyInput model.currencies)

currencyInput : CurrencyAmount -> Html Msg
currencyInput amount =
    div []
        [ label [] [ text (amount.currency.name ++ " " ++ "(" ++ amount.currency.sign ++ ")") ]
        , input
            [ type_ "number"
            , onInput (Msgs.UpdateBase amount.currency.code)
            , value (defaultValue amount)
            ] []
        ]

defaultValue : CurrencyAmount -> String
defaultValue amount =
    amount.amount
        |> Maybe.map (\s -> toString s)
        |> Maybe.withDefault ""
