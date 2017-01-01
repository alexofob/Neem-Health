module Model
    exposing
        ( initialModel
        , Model
        )

import RemoteData exposing (RemoteData(NotAsked), WebData)
import Form exposing (Form)
import Types exposing (CustomError, LoginForm, ChangePwdForm, Toast, User, Page(..))
import Validations exposing (validateLoginForm, validateChangePwdForm)


-- Model Types


type alias Model =
    { activePage : Page
    , user : WebData User
    , apiKey : Maybe String
    , loginForm : Form CustomError LoginForm
    , toast : Toast
    , isSubmitted :
        Bool
        -- Required to show spinner after making API request
    , dropDownOpened : Bool
    , changePwdForm : Form CustomError ChangePwdForm
    }


initialModel : Model
initialModel =
    { activePage = Home
    , user = NotAsked
    , apiKey = Nothing
    , loginForm = Form.initial [] validateLoginForm
    , toast = Toast "" "" "" ""
    , isSubmitted = False
    , dropDownOpened = False
    , changePwdForm = Form.initial [] validateChangePwdForm
    }
