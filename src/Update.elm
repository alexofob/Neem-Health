module Update exposing (update)

import RemoteData exposing (RemoteData(NotAsked))
import Model exposing (Model, Page, Page(Login, LoadingPage), LoginFormModel)
import Msg
    exposing
        ( Msg
        , Msg(NavigateTo, LoginForm)
        , LoginFormMsg
        , LoginFormMsg(Email, Password, SubmitLogin)
        )
import RemoteData exposing (..)
import String


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

        LoginForm loginFormMsg ->
            let
                ( loginFormModel, loginFormCmd ) =
                    updateLoginForm loginFormMsg model.loginForm
            in
                ( { model | loginForm = loginFormModel }
                , loginFormCmd
                )


updateLoginForm : LoginFormMsg -> LoginFormModel -> ( LoginFormModel, Cmd Msg )
updateLoginForm msg model =
    case msg of
        Email email_ ->
            let
                emailField =
                    { value = email_, isChanged = True }
            in
                { model
                    | email =
                        emailField
                }
                    ! [ Cmd.none ]

        Password password_ ->
            let
                passwordField =
                    { value = password_, isChanged = True }
            in
                { model
                    | password =
                        passwordField
                }
                    ! [ Cmd.none ]

        SubmitLogin ->
            model ! []
