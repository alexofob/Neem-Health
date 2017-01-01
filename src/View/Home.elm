module View.Home exposing (view)

import Html exposing (Html, Attribute, text, div, node, h3, p, section, h1)
import Html.Attributes exposing (attribute, style, class, href, value, id)
import Msg exposing (Msg(NavigateTo))
import Polymer.App as App
import Polymer.Paper as Paper
import Model exposing (Model)
import Polymer.Attributes exposing (icon)
import Form exposing (Form, InputType(Text), Msg(Input, Focus, Blur))
import Msg exposing (Msg(LoginFormMsg))
import View.FormInputs
    exposing
        ( emailInput
        , passwordInput
        , submitButton
        , submittedButton
        , iron
        )


view : Model -> Html Msg.Msg
view model =
    App.headerLayout []
        [ viewHeader
        , viewBody model
        ]


viewHeader : Html Msg.Msg
viewHeader =
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


viewBody : Model -> Html Msg.Msg
viewBody model =
    div [ class "app-grid" ]
        [ viewMarketingMessage
        , Html.map LoginFormMsg (loginFormView model)
        ]


viewMarketingMessage : Html Msg.Msg
viewMarketingMessage =
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


loginFormView : Model -> Html Form.Msg
loginFormView { loginForm, isSubmitted } =
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
                , if isSubmitted then
                    submittedButton
                  else
                    submitButton "Log in"
                , p [ class "paper-font-caption" ] [ text "By proceeding, I agree to the Neem Health Terms of Service." ]
                ]
            ]
        ]


messageItem : String -> String -> String -> Html Msg.Msg
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
