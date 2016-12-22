module Update exposing (update)

import RemoteData exposing (RemoteData(NotAsked))
import Model exposing (Model, Page, Page(Login, LoadingPage))
import Msg exposing (Msg, Msg(NavigateTo, LoginFormMsg))
import RemoteData exposing (..)
import String
import Form exposing (Form)


-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo page ->
            let
                page_ =
                    case model.user of
                        RemoteData.Success user ->
                            case model.apiKey of
                                Just apiKey ->
                                    if
                                        String.isEmpty (Maybe.withDefault "" user.role)
                                            || String.isEmpty (Maybe.withDefault "" user.company)
                                            || not user.passwordChanged
                                    then
                                        Login
                                    else if page == Login then
                                        Login
                                    else
                                        page

                                Nothing ->
                                    Login

                        RemoteData.Loading ->
                            LoadingPage

                        RemoteData.Failure err ->
                            Login

                        RemoteData.NotAsked ->
                            Login
            in
                { model | activePage = page_ } ! []

        LoginFormMsg formMsg ->
            case ( formMsg, Form.getOutput model.loginForm ) of
                ( Form.Submit, Just loginForm ) ->
                    model ! []

                _ ->
                    { model | loginForm = Form.update formMsg model.loginForm } ! []
