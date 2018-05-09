module View exposing (..)

import Html exposing (Html, div, text, label, input, h3)
import Html.Attributes exposing (type_, value, checked)
import Html.Events exposing (onInput, onClick)
import Models exposing (Model, CurrencyAmount)
import Msgs exposing (Msg)

view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text "Conversion" ]
        , div [] (List.map currencyInput model.currencies)
        , h3 [] [ text "Settings" ]
        , autorefreshToggle model.autorefresh
        ]

autorefreshToggle : Bool -> Html Msg
autorefreshToggle enabled =
    div []
        [ label [] [ text "Refresh automatically" ]
        , input [ type_ "checkbox", checked enabled, onClick Msgs.ToggleAutoRefresh] []
        ]

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
