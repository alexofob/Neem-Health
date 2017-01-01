module View.Selectors.App exposing (..)

import Model exposing (Model)
import RemoteData
import Types exposing (User, CustomError, ChangePwdForm)
import Form exposing (Form)


drawerSelector : Model -> DrawerViewModel
drawerSelector model =
    let
        user =
            getUser model

        company =
            Maybe.withDefault "NeemHealth" user.company

        isUser =
            RemoteData.isSuccess model.user

        name =
            Maybe.withDefault user.email user.name

        role =
            Maybe.withDefault "" user.role

        displayStyle =
            if model.dropDownOpened then
                ( "display", "block" )
            else
                ( "display", "none" )

        profile =
            { avatarUrl = user.avatarUrl
            , name = name
            , displayStyle = displayStyle
            , company = company
            , role = role
            }
    in
        { isUser = isUser
        , profile = profile
        }


changePwdDialogSelector : Model -> ChangePwdDialogViewModel
changePwdDialogSelector model =
    let
        user =
            getUser model

        dialogType =
            if user.passwordChanged then
                "dialog"
            else
                "modal"

        displayStyleDefaultPwd =
            if user.passwordChanged then
                ( "display", "none" )
            else
                ( "display", "block" )

        changePwdForm =
            { changePwdForm = model.changePwdForm
            , isSubmitted = model.isSubmitted
            , displayStyleDefaultPwd = displayStyleDefaultPwd
            }
    in
        { dialogType = dialogType
        , changePwdForm = changePwdForm
        }


type alias DrawerViewModel =
    { isUser : Bool
    , profile : ProfileViewModel
    }


type alias ProfileViewModel =
    { avatarUrl : String
    , name : String
    , displayStyle : ( String, String )
    , company : String
    , role : String
    }


type alias ChangePwdDialogViewModel =
    { dialogType : String
    , changePwdForm : ChangePwdFormViewModel
    }


type alias ChangePwdFormViewModel =
    { changePwdForm : Form CustomError ChangePwdForm
    , isSubmitted : Bool
    , displayStyleDefaultPwd : ( String, String )
    }


getUser : Model -> User
getUser model =
    model
        |> .user
        |> RemoteData.withDefault
            { avatarUrl = ""
            , name = Nothing
            , email = "Anonymous"
            , role = Nothing
            , company = Nothing
            , passwordChanged = False
            , phoneNumber = Nothing
            , userId = ""
            }
