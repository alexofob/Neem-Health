module Decoders exposing (..)

import Types exposing (APIError)
import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, requiredAt, optionalAt)
import Http
import Types exposing (User)


-- Decode login POST response to get token


tokenDecoder : Decode.Decoder String
tokenDecoder =
    --Decode.decodeString Decode.string "id_token"
    Decode.field "id_token" Decode.string



-- Decode login response to get error message


loginErrorDecoder : Decode.Decoder APIError
loginErrorDecoder =
    decode APIError
        |> required "error" Decode.string
        |> required "error_description" Decode.string



-- Decode POST response to get token


userDecoder : Decode.Decoder User
userDecoder =
    decode User
        |> required "picture" Decode.string
        |> required "name" (Decode.maybe Decode.string)
        |> required "email" Decode.string
        |> optionalAt [ "user_metadata", "role" ] (Decode.maybe Decode.string) Nothing
        |> optionalAt [ "user_metadata", "company" ] (Decode.maybe Decode.string) Nothing
        |> optionalAt [ "app_metadata", "password_changed" ] (Decode.bool) False
        |> optionalAt [ "user_metadata", "phone_number" ] (Decode.maybe Decode.string) Nothing
        |> required "user_id" Decode.string


changePwdDecoder : Decode.Decoder Bool
changePwdDecoder =
    Decode.at [ "app_metadata", "passwordChanged" ] Decode.bool



-- Decode Http errors, logs error messages to console and prepares error notification message to user


decodeError : Http.Error -> APIError
decodeError error =
    case error of
        Http.BadUrl errorString ->
            APIError (toString errorString) "Unable to complete operation. Please try again later."
                |> Debug.log "Bad Url"

        Http.Timeout ->
            APIError "" "Operation times out. Please try again later"
                |> Debug.log "Timeout"

        Http.NetworkError ->
            APIError "" "Network Not Available. Please try again later."
                |> Debug.log "NetworkError"

        Http.BadStatus response ->
            Decode.decodeString loginErrorDecoder response.body
                |> Result.withDefault
                    (Debug.log response.body <|
                        APIError
                            ""
                            "Unable to complete operation. Please contact the administrator"
                    )

        Http.BadPayload errorString response ->
            Decode.decodeString loginErrorDecoder response.body
                |> Result.withDefault
                    (Debug.log response.body <|
                        APIError
                            errorString
                            "Unable to complete operation. Please contact the administrator"
                    )
