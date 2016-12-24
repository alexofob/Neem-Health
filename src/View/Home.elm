module View.Home exposing (view)

import Html exposing (Html, Attribute, text, div, node, h3, p, section, h1, footer)
import Html.Attributes exposing (attribute, style, class, href, value)
import Html.Events exposing (onBlur, onInput, onClick)
import Msg
    exposing
        ( Msg(NavigateTo, LoginForm)
        , LoginFormMsg
            ( Email
            , Password
            , SubmitLogin
            )
        )
import Polymer.App as App
import Polymer.Paper as Paper
import Model exposing (Model, Page(Login), LoginFormModel)
import Polymer.Attributes exposing (icon)
import Regex exposing (regex, contains, find, HowMany(AtMost))
import List


view : Model -> Html Msg
view model =
    App.headerLayout []
        [ header
        , body model
        , footer [ footerStyle ] [ text "© Neem Health" ]
        ]


header : Html Msg
header =
    App.header
        [ attribute "reveals" ""
        , attribute "condenses" ""
        , attribute "effects" "blend-background parallax-background resize-title"
        ]
        [ App.toolbar
            []
            [ div
                [ attribute "condensed-title" ""
                ]
                [ h3 [] [ text "Neem Health" ] ]
            ]
        , App.toolbar
            [ style
                [ ( "height", "148px" )
                ]
            ]
            [ div
                [ attribute "main-title" ""
                ]
                [ h1 [] [ text "Neem Health" ] ]
            ]
        ]


body : Model -> Html Msg
body model =
    div [ class "app-grid" ]
        [ marketingMessage
        , loginForm model
        ]


marketingMessage : Html Msg
marketingMessage =
    section
        [ attribute "role" "contentinfo"
        , style [ ( "padding", "0% 3%" ) ]
        ]
        [ p
            [ class "paper-font-display1"
            , class "light-accent-color"
            ]
            [ text "Reduce your distribution and inventory cost and still sell more."
            ]
        , div []
            [ messageItem
                "editor:monetization-on"
                "Sell More at Low Cost."
                "Be notified when your partner pharmacies run out of stock and supply drugs where it is most needed."
            , messageItem
                "maps:local-pharmacy"
                "Gain control of your inventory."
                "Track your Drug inventory and easily find out where demand is high or low and and focus on high demand shops."
            , messageItem
                "icons:shopping-cart"
                "Empower your partners to order online."
                "Create online Product Catalog and make it easy for your partners to order drugs online."
            ]
        ]


loginForm : Model -> Html Msg
loginForm { loginForm } =
    section
        [ style
            [ ( "padding", "5% 7%" )
            ]
        ]
        [ Paper.card
            [ attribute "heading" "Log in"
            ]
            [ div [ class "card-content" ]
                [ emailInput loginForm
                , passwordInput loginForm
                , loginButton
                , p [ class "paper-font-caption" ]
                    [ text "By proceeding, I agree to the Neem Health Terms of Service." ]
                ]
            ]
        ]


emailInput : LoginFormModel -> Html Msg
emailInput { email } =
    let
        emailRegex =
            "[a-zA-Z0-9\\.]+@[a-zA-Z0-9]+(\\-)?[a-zA-Z0-9]+(\\.)?[a-zA-Z0-9]{2,6}?\\.[a-zA-Z]{2,6}$"

        match =
            find (AtMost 1) (regex emailRegex) email.value

        ( errorMessage, inValid ) =
            if (String.isEmpty email.value && email.isChanged) then
                ( "Your email is required.", attribute "invalid" "" )
            else if (List.isEmpty match && email.isChanged) then
                ( "Please provide a valid email.", attribute "invalid" "" )
            else
                ( "", class "" )
    in
        Paper.input
            [ attribute "label" "email"
            , value email.value
            , onInput <| LoginForm << Email
            , attribute "autocomplete" ""
            , attribute "autofocus" ""
            , inValid
            , attribute "error-message" errorMessage
            ]
            [ iron "icon"
                [ icon "communication:email"
                , loginIconStyle
                , attribute "prefix" ""
                ]
                []
            ]


passwordInput : LoginFormModel -> Html Msg
passwordInput { password } =
    Paper.input
        [ attribute "type" "password"
        , attribute "label" "password"
        , value password.value
        , onInput <| LoginForm << Password
        , attribute "required" ""
        , attribute "auto-validate" "true"
        , attribute "error-message" "Your Password is required."
        ]
        [ iron "icon"
            [ icon "icons:https"
            , loginIconStyle
            , attribute "prefix" ""
            ]
            []
        ]


loginButton : Html Msg
loginButton =
    Paper.button
        [ attribute "raised" ""
        , style [ ( "margin", "15px 0px" ) ]
        , onClick <| LoginForm SubmitLogin
        ]
        [ text "log in" ]


messageItem : String -> String -> String -> Html Msg
messageItem iconType messageTitle messageBody =
    Paper.iconItem [ style [ ( "margin-bottom", "5%" ) ] ]
        [ iron "icon"
            [ icon iconType
            , attribute "item-icon" ""
            , class "big-icon"
            ]
            []
        , Paper.itemBody
            [ attribute "two-line" "" ]
            [ div [ class "paper-font-title" ] [ text messageTitle ]
            , div [ attribute "secondary" "" ] [ text messageBody ]
            ]
        ]


footerStyle : Attribute msg
footerStyle =
    style
        [ ( "height", "50px" )
        , ( "line-height", "50px" )
        , ( "text-align", "center" )
        , ( "background-color", "white" )
        , ( "font-size", "14px" )
        ]


loginIconStyle : Attribute msg
loginIconStyle =
    style
        [ ( "color", "hsl(0, 0%, 50%)" )
        , ( "margin-right", "12px" )
        ]


iron : String -> List (Attribute msg) -> List (Html msg) -> Html msg
iron name =
    "iron-" ++ name |> node
