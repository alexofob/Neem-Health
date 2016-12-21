module View exposing (view)

import Html exposing (Html)
import Model exposing (Model, Page(Home, Login, PageNotFound, LoadingPage))
import Msg exposing (Msg)
import View.Home as Home
import View.PageNotFound as PageNotFound
import View.Loading as Loading


view : Model -> Html Msg
view model =
    case model.activePage of
        Home ->
            Home.view model

        Login ->
            Home.view model

        PageNotFound ->
            PageNotFound.view

        LoadingPage ->
            Loading.view
