module View exposing (view)

import Html exposing (Html, div, footer, text, p, section)
import Html.Attributes exposing (attribute, style, class, href, value, id)
import Model exposing (Model)
import View.Home as Home
import View.PageNotFound as PageNotFound
import View.Loading as Loading
import View.App as App
import Msg exposing (Msg(ChangePwdFormMsg))
import Types exposing (Page(..))
import View.Styles.Common as Common
import Polymer.Paper as Paper
import View.Styles.Common as Common
import View.Selectors.App as Selectors
import Form exposing (Form, InputType(Text), Msg(Input, Focus, Blur))
import View.FormInputs
    exposing
        ( newPasswordInput
        , confirmPasswordInput
        , submitButton
        , submittedButton
        )


view : Model -> Html Msg.Msg
view model =
    div []
        [ case model.activePage of
            Home ->
                Home.view model

            PageNotFound ->
                PageNotFound.view

            LoadingPage ->
                Loading.view

            App route ->
                App.view model
        , footer [ style Common.footerStyle ] [ text "© Neem Health" ]
        , Paper.toast
            [ attribute "text" model.toast.text
            , attribute "duration" "5000"
            , id model.toast.style
            , class model.toast.fitBottom
            , class model.toast.capsule
            ]
            []
        , viewChangePwdDialog model
        ]


viewChangePwdDialog : Model -> Html Msg.Msg
viewChangePwdDialog =
    changePwdDialogView << Selectors.changePwdDialogSelector


changePwdDialogView : Selectors.ChangePwdDialogViewModel -> Html Msg.Msg
changePwdDialogView { dialogType, changePwdForm } =
    Paper.dialog
        [ attribute dialogType ""
        , style [ ( "min-width", "350px" ) ]
        ]
        [ p [ class "paper-font-title" ] [ text "Change Password" ]
        , Html.map ChangePwdFormMsg (viewChangePwdForm changePwdForm)
        ]


viewChangePwdForm : Selectors.ChangePwdFormViewModel -> Html Form.Msg
viewChangePwdForm { changePwdForm, isSubmitted, displayStyleDefaultPwd } =
    section
        []
        [ div []
            [ p
                [ class "paper-font-body1"
                , style [ displayStyleDefaultPwd ]
                ]
                [ text "Please change your default password to proceed." ]
            , div []
                [ newPasswordInput changePwdForm
                , confirmPasswordInput changePwdForm
                , if isSubmitted then
                    submittedButton
                  else
                    submitButton "Change Password"
                ]
            ]
        ]
