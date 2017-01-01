module View.App exposing (..)

import Html exposing (Html, text, div, hr, img, p, footer, h2, section, span)
import Html.Attributes exposing (attribute, style, class, href, src, alt, id)
import Html.Events exposing (onWithOptions)
import Polymer.App as App
import Polymer.Paper as Paper
import Model exposing (Model)
import Msg exposing (Msg(..))
import Json.Decode as Decode
import View.Styles.App as Styles
import View.Selectors.App as Selectors
import Types exposing (Page(..), Route(..), RouteItem)
import View.FormInputs exposing (iron)
import Polymer.Attributes exposing (icon)
import View.Routes as Route


view : Model -> Html Msg.Msg
view model =
    App.drawerLayout
        []
        [ viewDrawer model
        , viewBody model
        ]


viewDrawer : Model -> Html Msg.Msg
viewDrawer =
    drawerView << Selectors.drawerSelector


drawerView : Selectors.DrawerViewModel -> Html Msg.Msg
drawerView { isUser, profile } =
    App.drawer
        [ class "drawer-contents"
        ]
        [ if isUser then
            viewProfile profile
          else
            Paper.spinner [ attribute "active" "" ] []
        , hr [] []
        , Paper.menu [ style Styles.columnContainer ]
            (List.map drawerMenuItem menuItems)
        ]


viewProfile : Selectors.ProfileViewModel -> Html Msg.Msg
viewProfile { avatarUrl, name, displayStyle, company, role } =
    section
        [ style Styles.columnContainer ]
        [ p [ class "paper-font-title" ] [ text company ]
        , img [ src avatarUrl, alt "profile picture", class "avatar-container" ] []
        , div
            [ style Styles.rowContainer
            ]
            [ p
                [ class "paper-font-body2"
                , style [ ( "margin-top", "4%" ) ]
                ]
                [ text name ]
            , Paper.iconButton
                [ attribute "icon" "arrow-drop-down"
                , onClick DropDownClicked
                , style Styles.dropdownArrow
                ]
                []
            , Paper.menu [ style <| displayStyle :: Styles.dropdownList ]
                (List.map
                    (\( item, msg ) ->
                        Paper.item
                            [ onClick msg
                            , class "menu-item"
                            ]
                            [ text item ]
                    )
                    [ ( "Edit Profile", NavigateTo <| App EditProfile )
                    , ( "Change Password", ChangePassword )
                    , ( "Log out", Logout )
                    ]
                )
            ]
        , p
            [ class "paper-font-caption"
            , style [ ( "margin-top", "-5%" ) ]
            , class "secondary-text-color"
            ]
            [ text role ]
        ]


drawerMenuItem : RouteItem -> Html Msg
drawerMenuItem routeItem =
    Paper.iconItem
        [ onClick (NavigateTo <| App routeItem.route)
        , class "menu-item"
        ]
        [ iron "icon"
            [ icon routeItem.iconName
            , attribute "item-icon" ""
            ]
            []
        , span
            []
            [ text routeItem.text
            ]
        ]


menuItems : List RouteItem
menuItems =
    [ Route.dashboard
    , Route.drugCatalog
    , Route.orderManager
    , Route.pharmacies
    , Route.userAdmin
    ]


viewBody : Model -> Html Msg.Msg
viewBody model =
    App.headerLayout
        []
        [ App.header
            [ attribute "effects" "waterfall"
            , attribute "fixed" ""
            ]
            [ App.toolbar
                []
                [ Paper.iconButton
                    [ attribute "icon" "menu"
                    , attribute "drawer-toggle" ""
                    ]
                    []
                , div
                    [ class "paper-font-title" ]
                    [ text "Thousands of Spoons" ]
                ]
            ]
        , div
            []
            []
        ]



-- helper to cancel click anywhere


onClick : msg -> Html.Attribute msg
onClick message =
    onWithOptions
        "click"
        { stopPropagation = True
        , preventDefault = False
        }
        (Decode.succeed message)
