module View.Dashboard exposing (view)

import Html exposing (..)
import Html exposing (..)
import Html.Attributes exposing (style)


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


view : Html msg
view =
    div
        [ style
            [ "width" => "100%"
            , "height" => "100%"
            , "display" => "flex"
            , "flex-direction" => "column"
            , "justify-content" => "center"
            , "align-items" => "center"
            , "background-color" => "#F5F5F5"
            , "color" => "#9A9A9A"
            ]
        ]
        [ text "Loading Dashoard..."
        ]
