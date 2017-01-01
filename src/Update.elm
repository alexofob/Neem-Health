module Update exposing (update)

import RemoteData exposing (RemoteData(NotAsked))
import Model exposing (Model)
import Msg exposing (..)
import RemoteData exposing (..)
import String
import Form exposing (Form)
import Commands exposing (login, getUserProfile, changePassword)
import Decoders
import Ports
import Types exposing (Page(Home, App, LoadingPage), Route(..), Toast)


-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NavigateTo page ->
            let
                ( page_, cmd, user_ ) =
                    case model.apiKey of
                        Just apiKey ->
                            ( page, getUserProfile apiKey, RemoteData.Loading )

                        Nothing ->
                            ( Home, Cmd.none, RemoteData.NotAsked )
            in
                { model | activePage = page_, user = user_ } ! [ cmd ]

        LoginFormMsg formMsg ->
            case ( formMsg, Form.getOutput model.loginForm ) of
                ( Form.Submit, Just loginForm ) ->
                    { model | isSubmitted = True } ! [ login loginForm ]

                _ ->
                    { model | loginForm = Form.update formMsg model.loginForm } ! []

        LoginSucceeded apiKey ->
            { model
                | apiKey = Just apiKey
                , user = RemoteData.Loading
                , isSubmitted = False
            }
                ! [ getUserProfile apiKey
                  , Ports.storeApiKey apiKey
                  ]

        LoginFailed error ->
            { model | isSubmitted = False }
                ! []
                |> andLog "Login failed" (.error_description <| Decoders.decodeError error)

        GetUserSucceeded user ->
            let
                role =
                    Maybe.withDefault "" user.role

                company =
                    Maybe.withDefault "" user.company

                cmd =
                    if user.passwordChanged then
                        Cmd.none
                    else
                        Ports.openDialog ()
            in
                if String.isEmpty role || String.isEmpty company then
                    { model | isSubmitted = False }
                        ! []
                        |> andLog "User Profile is incomplete"
                            "Your profile is not complete. Please contact the administrator"
                else
                    { model | user = Success user, activePage = (App Dashboard) } ! [ cmd ]

        GetUserFailed error ->
            { model | isSubmitted = False, activePage = Home }
                ! []
                |> andLog "Get User Profile failed" (.error_description <| Decoders.decodeError error)

        DropDownClicked ->
            { model | dropDownOpened = not model.dropDownOpened } ! []

        Blur ->
            { model | dropDownOpened = False } ! []

        ChangePwdFormMsg formMsg ->
            let
                userId =
                    case model.user of
                        Success user ->
                            user.userId

                        _ ->
                            ""
            in
                case ( formMsg, Form.getOutput model.changePwdForm, model.apiKey ) of
                    ( Form.Submit, Just changePwdForm, Just apiKey ) ->
                        model ! [ changePassword apiKey userId changePwdForm.newPassword ]

                    _ ->
                        { model | changePwdForm = Form.update formMsg model.changePwdForm } ! []

        ChangeUserPwdSucceeded user ->
            if user.passwordChanged then
                { model | user = Success user, isSubmitted = False } ! [ Ports.closeDialog () ]
            else
                { model | isSubmitted = False }
                    ! []
                    |> andLog "Password could not be changed" "Password could not be changed. Please try again."

        ChangeUserPwdFailed error ->
            { model | isSubmitted = False } ! [] |> andLog "Unable to update your password" (.error_description <| Decoders.decodeError error)

        Logout ->
            { model | apiKey = Nothing, activePage = Home, user = NotAsked } ! [ Ports.storeApiKey "" ]

        ChangePassword ->
            model ! [ Ports.openDialog () ]


andLog : String -> String -> ( Model, Cmd Msg ) -> ( Model, Cmd Msg )
andLog tag errorMessage ( model, cmd ) =
    let
        _ =
            Debug.log tag errorMessage

        toast_ =
            { text = errorMessage
            , style = "error-toast"
            , fitBottom = "fit-bottom"
            , capsule = ""
            }
    in
        { model | toast = toast_ }
            ! [ Ports.openToast ()
              ]
