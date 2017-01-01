module Router exposing (..)

import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(NewEntry), UrlChange)
import Model exposing (Model)
import Msg exposing (Msg, Msg(NavigateTo))
import UrlParser exposing (Parser, oneOf, map, s, top, parseHash)
import Types exposing (Page(..), Route(..))


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    case current.activePage of
        Home ->
            Just <| UrlChange NewEntry "/"

        LoadingPage ->
            Just <| UrlChange NewEntry "/#loading"

        PageNotFound ->
            Just <| UrlChange NewEntry "/#404"

        App Dashboard ->
            Just <| UrlChange NewEntry "/#dashboard"

        App _ ->
            Just <| UrlChange NewEntry "/#dashboard"


routeParser : Parser (Page -> a) a
routeParser =
    oneOf
        [ map Home top
        , map (App Dashboard) (s "dashboard")
        ]


location2messages : Location -> List Msg
location2messages location =
    case parseHash routeParser location of
        Just page ->
            [ NavigateTo page ]

        Nothing ->
            [ NavigateTo PageNotFound ]
