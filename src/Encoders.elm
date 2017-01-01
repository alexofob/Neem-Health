module Encoders exposing (..)

import Json.Encode as Encode exposing (..)
import Types exposing (APIKey, LoginForm, ChangePwdForm)


-- Encode user to construct POST request body (for Log In)


loginInputEncoder : LoginForm -> Encode.Value
loginInputEncoder { email, password } =
    Encode.object
        [ ( "username", Encode.string email )
        , ( "password", Encode.string password )
        , ( "connection", Encode.string "Username-Password-Authentication" )
        , ( "client_id", Encode.string "5KwBxVRdzJU9tz4Aqy2AdUnd2zaoKSyA" )
        , ( "grant_type", Encode.string "password" )
        , ( "scope", Encode.string "openid" )
        ]



-- Encode token to be sent to auth0 to get user profile details


tokenEncoder : String -> Encode.Value
tokenEncoder apiKey =
    Encode.object
        [ ( "id_token", Encode.string apiKey )
        ]



-- Encode token and new password to be sent to auth0 change user password


changePwdEncoder : APIKey -> String -> Encode.Value
changePwdEncoder apiKey newPassword =
    Encode.object
        [ ( "app_metadata", Encode.object [ ( "password_changed", Encode.bool True ) ] )
        , ( "password", Encode.string newPassword )
        , ( "id_token", Encode.string apiKey )
        ]
