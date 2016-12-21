module Model
    exposing
        ( initialModel
        , Model
        , Page(Login, Home, PageNotFound, LoadingPage)
        , User
        )

import RemoteData exposing (RemoteData(NotAsked), WebData)


-- Model Types


type alias Model =
    { activePage : Page
    , user : WebData User
    , apiKey : Maybe String
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
    }
