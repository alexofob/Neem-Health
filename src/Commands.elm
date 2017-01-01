module Commands exposing (..)

import Time
import Http
import HttpBuilder exposing (..)
import Decoders
import Encoders
import Msg exposing (Msg(..))
import Types exposing (LoginForm, User, ChangePwdForm)


-- Login Command configuration


loginUrl : String
loginUrl =
    "https://neemhealth.auth0.com/oauth/ro"


login : LoginForm -> Cmd Msg
login loginForm =
    HttpBuilder.post loginUrl
        |> withJsonBody (Encoders.loginInputEncoder loginForm)
        |> withTimeout (10 * Time.second)
        |> withExpect (Http.expectJson Decoders.tokenDecoder)
        |> send handleLoginComplete


handleLoginComplete : Result Http.Error String -> Msg
handleLoginComplete result =
    case result of
        Ok tokenId ->
            LoginSucceeded tokenId

        Err error ->
            LoginFailed error



-- GetUserProfile Command configuration


profileUrl : String
profileUrl =
    "https://neemhealth.auth0.com/tokeninfo"


getUserProfile : String -> Cmd Msg
getUserProfile apiKey =
    HttpBuilder.post profileUrl
        |> withJsonBody (Encoders.tokenEncoder apiKey)
        |> withTimeout (10 * Time.second)
        |> withExpect (Http.expectJson Decoders.userDecoder)
        |> send handleGetUserProfileComplete


handleGetUserProfileComplete : Result Http.Error User -> Msg
handleGetUserProfileComplete result =
    case result of
        Ok user ->
            GetUserSucceeded user

        Err error ->
            GetUserFailed error



-- GetUserProfile Command configuration


changePasswordUrl : String
changePasswordUrl =
    "https://rgc43vj24h.execute-api.us-east-1.amazonaws.com/dev/users/changePassword/"


changePassword : String -> String -> String -> Cmd Msg
changePassword apiKey userId newPassword =
    HttpBuilder.patch (changePasswordUrl ++ userId)
        |> withJsonBody (Encoders.changePwdEncoder apiKey newPassword)
        |> withTimeout (10 * Time.second)
        |> withExpect (Http.expectJson Decoders.userDecoder)
        |> send handleChangePwdComplete


handleChangePwdComplete : Result Http.Error User -> Msg
handleChangePwdComplete result =
    case result of
        Ok user ->
            ChangeUserPwdSucceeded user

        Err error ->
            ChangeUserPwdFailed error
