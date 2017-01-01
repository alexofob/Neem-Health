module View.FormInputs exposing (..)

import Html exposing (Html, Attribute, text, div, node, h3, p, section, h1, footer)
import Html.Attributes exposing (attribute, style, class, href, value)
import Html.Events exposing (onClick, onInput, onBlur, onFocus)
import Polymer.Paper as Paper
import Polymer.Attributes exposing (icon)
import Form exposing (Form, InputType(Text), Msg(Input, Focus, Blur))
import Form.Error exposing (Error)
import Form.Field as Field exposing (Field, FieldValue(String))
import Types exposing (LoginForm, ChangePwdForm, CustomError(..))


{-| Untyped input, first param is `type` attribute.
-}
baseInput : String -> (String -> FieldValue) -> InputType -> Input e String
baseInput t toFieldValue inputType state attrs htmlList =
    let
        formAttrs =
            [ attribute "type" t
            , value (state.value |> Maybe.withDefault "")
            , onInput (toFieldValue >> (Input state.path inputType))
            , onFocus (Focus state.path)
            , onBlur (Blur state.path)
            ]
    in
        Paper.input
            (formAttrs ++ attrs)
            htmlList


type alias Input e a =
    Form.FieldState e a -> List (Attribute Form.Msg) -> List (Html Form.Msg) -> Html Form.Msg


emailInput : Form CustomError LoginForm -> Html Form.Msg
emailInput loginForm =
    let
        email =
            Form.getFieldAsString "email" loginForm

        -- error presenter
        ( emailError, invalid ) =
            case email.liveError of
                Just error ->
                    case error of
                        Form.Error.Empty ->
                            ( "Your Email is required.", attribute "invalid" "" )

                        _ ->
                            ( "Please provide a valid Email.", attribute "invalid" "" )

                Nothing ->
                    ( "", class "" )
    in
        baseInput "text"
            String
            Text
            email
            [ attribute "label" "email"
            , attribute "error-message" emailError
            , attribute "autocomplete" ""
            , invalid
            ]
            [ iron "icon"
                [ icon "communication:email"
                , loginIconStyle
                , attribute "suffix" ""
                ]
                []
            ]


passwordInput : Form CustomError LoginForm -> Html Form.Msg
passwordInput loginForm =
    let
        password =
            Form.getFieldAsString "password" loginForm

        ( passwordError, invalid ) =
            case password.liveError of
                Just error ->
                    case error of
                        Form.Error.Empty ->
                            ( "Your Password is required.", attribute "invalid" "" )

                        _ ->
                            ( "Please provide a valid Password.", attribute "invalid" "" )

                Nothing ->
                    ( "", class "" )
    in
        baseInput "password"
            String
            Text
            password
            [ attribute "label" "password"
            , attribute "error-message" passwordError
            , invalid
            ]
            [ iron "icon"
                [ icon "icons:https"
                , loginIconStyle
                , attribute "suffix" ""
                ]
                []
            ]


newPasswordInput : Form CustomError ChangePwdForm -> Html Form.Msg
newPasswordInput changePwdForm =
    let
        password =
            Form.getFieldAsString "newPassword" changePwdForm

        ( passwordError, invalid ) =
            case password.error of
                Just error ->
                    case error of
                        Form.Error.Empty ->
                            ( "Your Password is required.", attribute "invalid" "" )

                        Form.Error.CustomError NoCapLetter ->
                            ( "Your Password should have at least 1 capital case.", attribute "invalid" "" )

                        Form.Error.CustomError NoNumber ->
                            ( "Your Password should have at least 1 digit.", attribute "invalid" "" )

                        Form.Error.CustomError NoSmallLetter ->
                            ( "Your Password should have at least 1 lower case.", attribute "invalid" "" )

                        Form.Error.CustomError LessChars ->
                            ( "Your Password should be at least 8 characters.", attribute "invalid" "" )

                        _ ->
                            ( "Please provide your Password.", attribute "invalid" "" )

                Nothing ->
                    ( "", class "" )
    in
        baseInput "password"
            String
            Text
            password
            [ attribute "label" "New password"
            , attribute "error-message" passwordError
            , invalid
            ]
            [ iron "icon"
                [ icon "icons:https"
                , loginIconStyle
                , attribute "suffix" ""
                ]
                []
            ]


confirmPasswordInput : Form CustomError ChangePwdForm -> Html Form.Msg
confirmPasswordInput changePwdForm =
    let
        password =
            Form.getFieldAsString "confirmPassword" changePwdForm

        ( passwordError, invalid ) =
            case password.liveError of
                Just errorValue ->
                    case errorValue of
                        Form.Error.Empty ->
                            ( "Please confirm your password.", attribute "invalid" "" )

                        Form.Error.CustomError PasswordsMustMatch ->
                            ( "Passwords do no much.", attribute "invalid" "" )

                        _ ->
                            ( "Passwords do no much.", attribute "invalid" "" )

                Nothing ->
                    ( "", class "" )
    in
        baseInput "password"
            String
            Text
            password
            [ attribute "label" "Confirm Password"
            , attribute "error-message" passwordError
            , invalid
            ]
            [ iron "icon"
                [ icon "icons:https"
                , loginIconStyle
                , attribute "suffix" ""
                ]
                []
            ]


submitButton : String -> Html Form.Msg
submitButton label =
    Paper.button
        [ attribute "raised" ""
        , style [ ( "margin", "15px 0px" ) ]
        , onClick Form.Submit
        ]
        [ text label
        ]


submittedButton : Html Form.Msg
submittedButton =
    Paper.button
        [ attribute "disabled" ""
        , style [ ( "margin", "15px 0px" ) ]
        ]
        [ Paper.spinner
            [ attribute "active" ""
            ]
            []
        ]


iron : String -> List (Attribute msg) -> List (Html msg) -> Html msg
iron name =
    "iron-" ++ name |> node


loginIconStyle : Attribute msg
loginIconStyle =
    style
        [ ( "color", "hsl(0, 0%, 50%)" )
        , ( "margin-right", "12px" )
        ]
