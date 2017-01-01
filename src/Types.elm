module Types exposing (..)

-- Module Types


type alias LoginForm =
    { email : String
    , password : String
    }


type alias ChangePwdForm =
    { newPassword : String
    , confirmPassword : String
    }


type CustomError
    = LessChars
    | NoCapLetter
    | NoSmallLetter
    | NoNumber
    | Empty
    | PasswordsMustMatch


type alias Toast =
    { text : String
    , style : String
    , fitBottom : String
    , capsule : String
    }


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


type Page
    = Home
    | PageNotFound
    | LoadingPage
    | App Route


type Route
    = Dashboard
    | DrugCatalog
    | NewDrug
    | EditDrug DrugId
    | ShowDrug DrugId
    | OrderManager
    | NewOrder
    | EditOrder OrderId
    | ShowOrder OrderId
    | UserAdmin
    | NewUser
    | EditUser
    | ShowUser
    | Pharmacy
    | NewPharmacy
    | EditPharmacy
    | ShowPharmacy
    | EditProfile


type alias DrugId =
    String


type alias OrderId =
    String



-- App Types


type alias APIError =
    { error : String
    , error_description : String
    }


type alias APIKey =
    String


type alias UserID =
    String


type alias RouteItem =
    { text : String
    , iconName : String
    , route : Route
    , subMenus : List String
    , searchPlaceholder : Maybe String
    }
