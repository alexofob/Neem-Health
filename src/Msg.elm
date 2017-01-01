module Msg exposing (..)

import Types exposing (User, Page)
import Form exposing (Form)
import Http


-- App Messages


type Msg
    = NavigateTo Page
    | LoginFormMsg Form.Msg
    | LoginSucceeded String
    | LoginFailed Http.Error
    | GetUserFailed Http.Error
    | GetUserSucceeded User
    | DropDownClicked
    | Blur
    | ChangePwdFormMsg Form.Msg
    | ChangeUserPwdSucceeded User
    | ChangeUserPwdFailed Http.Error
    | Logout
    | ChangePassword
