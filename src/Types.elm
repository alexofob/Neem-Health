module Types exposing (..)

-- App Types


type alias APIError =
    { error : String
    , error_description : String
    }


type alias APIKey =
    String


type alias UserID =
    String
