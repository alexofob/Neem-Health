module Types exposing (..)

-- Module Types


type alias LoginForm =
    { email : String
    , password : String
    }


type CustomError
    = LessChars
    | NoCapLetter
    | NoSmallLetter
    | NoNumber
    | Empty
    | PasswordsMustMatch



-- App Types


type alias APIError =
    { error : String
    , error_description : String
    }


type alias APIKey =
    String


type alias UserID =
    String
