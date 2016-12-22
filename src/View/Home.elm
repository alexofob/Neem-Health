module View.Home exposing (view)

import Html exposing (Html, Attribute, text, div, node, h3, p, section, h1, footer)
import Html.Attributes exposing (attribute, style, class, href, value)
import Html.Events exposing (onClick)
import Msg exposing (Msg(NavigateTo))
import Polymer.App as App
import Polymer.Paper as Paper
import Model exposing (Model, Page(Login))
import Polymer.Attributes exposing (icon)
import Form exposing (Form)
import Form.Error exposing (Error)
import Msg exposing (Msg(LoginFormMsg))


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
loginForm model =
    let
        -- error presenter
        emailError =
            case email.liveError of
                Just error ->
                    case error of
                        Form.Error.Empty ->
                            "Your Email is required."

                        _ ->
                            "Please provide a valid Email."

                Nothing ->
                    ""

        passwordError =
            case password.liveError of
                Just error ->
                    case error of
                        Form.Error.Empty ->
                            "Your Password is required."

                        _ ->
                            "Please provide a valid Password."

                Nothing ->
                    ""

        -- fields states
        email =
            Form.getFieldAsString "email" model.loginForm

        password =
            Form.getFieldAsBool "password" model.loginForm
    in
        section
            [ style
                [ ( "padding", "5% 7%" )
                ]
            ]
            [ Paper.card
                [ attribute "heading" "Log in"
                ]
                [ div [ class "card-content" ]
                    [ Paper.input
                        [ attribute "label" "email"
                        , value <| Maybe.withDefault "" email.value
                        , attribute "error-message" emailError
                        ]
                        [ iron "icon"
                            [ icon "communication:email"
                            , loginIconStyle
                            , attribute "prefix" ""
                            ]
                            []
                        ]
                    , Paper.input
                        [ attribute "type" "password"
                        , attribute "label" "password"
                        , attribute "required" ""
                        , attribute "auto-validate" ""
                        , attribute "error-message" passwordError
                        ]
                        [ iron "icon"
                            [ icon "icons:https"
                            , loginIconStyle
                            , attribute "prefix" ""
                            ]
                            []
                        ]
                    , Paper.button
                        [ attribute "raised" ""
                        , style [ ( "margin", "15px 0px" ) ]
                        ]
                        [ text "log in" ]
                    , p [ class "paper-font-caption" ] [ text "By proceeding, I agree to the Neem Health Terms of Service." ]
                    ]
                ]
            ]


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
