module Main exposing (..)

import Model exposing (Model, initialModel)
import Router exposing (delta2url, location2messages)
import Update exposing (update)
import View exposing (view)
import Msg exposing (Msg)
import RouteUrl exposing (RouteUrlProgram)


type alias ProgramFlags =
    { apiKey : Maybe String
    }


main : RouteUrlProgram ProgramFlags Model Msg
main =
    RouteUrl.programWithFlags
        { delta2url = delta2url
        , location2messages = location2messages
        , init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


init : ProgramFlags -> ( Model, Cmd Msg )
init programFlags =
    case programFlags.apiKey of
        Nothing ->
            initialModel ! [ Cmd.none ]

        Just apiKey ->
            initialModel ! [ Cmd.none ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
