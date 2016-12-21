module Router exposing (delta2url, location2messages)

import Navigation exposing (Location)
import RouteUrl exposing (HistoryEntry(NewEntry), UrlChange)
import Model exposing (Model, Page(Login, Home, LoadingPage, PageNotFound))
import Msg exposing (Msg, Msg(NavigateTo))
import UrlParser exposing (Parser, oneOf, map, s, top, parseHash)


delta2url : Model -> Model -> Maybe UrlChange
delta2url previous current =
    case current.activePage of
        Login ->
            Just <| UrlChange NewEntry "/#login"

        Home ->
            Just <| UrlChange NewEntry ""

        LoadingPage ->
            Just <| UrlChange NewEntry "/#loading"

        PageNotFound ->
            Just <| UrlChange NewEntry "/#404"


routeParser : Parser (Page -> a) a
routeParser =
    oneOf
        [ map Home top
        , map Login (s "login")
        ]


location2messages : Location -> List Msg
location2messages location =
    case parseHash routeParser location of
        Just page ->
            [ NavigateTo page ]

        Nothing ->
            [ NavigateTo PageNotFound ]
