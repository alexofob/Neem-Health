module Model
    exposing
        ( initialModel
        , Model
        , Page(Login, Home, PageNotFound, LoadingPage)
        , User
        )

import RemoteData exposing (RemoteData(NotAsked), WebData)
import Form exposing (Form)
import Types exposing (CustomError, LoginForm)
import Validations exposing (validateLoginForm, validatePassword)


-- Model Types


type alias Model =
    { activePage : Page
    , user : WebData User
    , apiKey : Maybe String
    , loginForm : Form CustomError LoginForm
    }


type Page
    = Login
    | Home
    | PageNotFound
    | LoadingPage


type alias User =
    { avatarUrl : String
    , name : Maybe String
    , email : String
    , role : Maybe String
    , company : Maybe String
    , passwordChanged : Bool
    , phoneNumber : Maybe String
    , userId : String
    }


initialModel : Model
initialModel =
    { activePage = Login
    , user = NotAsked
    , apiKey = Nothing
    , loginForm = Form.initial [] validateLoginForm
    }
