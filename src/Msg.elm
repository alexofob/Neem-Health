module Msg exposing (..)

import Model exposing (Page)


-- App Messages


type Msg
    = NavigateTo Page
    | LoginForm LoginFormMsg


type LoginFormMsg
    = Email String
    | Password String
    | SubmitLogin
