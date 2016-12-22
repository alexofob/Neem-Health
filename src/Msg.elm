module Msg exposing (..)

import Model exposing (Page)
import Form exposing (Form)


-- App Messages


type Msg
    = NavigateTo Page
    | LoginFormMsg Form.Msg
