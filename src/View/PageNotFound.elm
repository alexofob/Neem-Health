module View.PageNotFound exposing (view)

import Html exposing (..)
import Html.Attributes exposing (style, class)


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


view : Html msg
view =
    div
        [ style
            [ "width" => "100%"
            , "height" => "500px"
            , "display" => "flex"
            , "flex-direction" => "column"
            , "justify-content" => "center"
            , "align-items" => "center"
            , "background-color" => "#F5F5F5"
            , "color" => "#9A9A9A"
            ]
        ]
        [ div [ style [ "font-size" => "12em" ] ] [ text "404" ]
        , div [ class "space" ] []
        , div [ style [ "font-size" => "3em" ] ] [ text "Page not found" ]
        ]
