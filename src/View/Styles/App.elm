module View.Styles.App exposing (..)

-- styles for App Layout


dropdownList : List ( String, String )
dropdownList =
    [ ( "position", "absolute" )
    , ( "top", "36px" )
    , ( "box-shadow", "0 1px 2px rgba(0,0,0,.24)" )
    , ( "width", "180px" )
    , ( "z-index", "1" )
    ]


dropdownArrow : List ( String, String )
dropdownArrow =
    [ ( "position", "absolute" )
    , ( "bottom", "15%" )
    , ( "left", "100%" )
    ]


columnContainer : List ( String, String )
columnContainer =
    [ ( "display", "flex" )
    , ( "flex-direction", "column" )
    , ( "align-items", "center" )
    , ( "flex-wrap", "wrap" )
    ]


rowContainer : List ( String, String )
rowContainer =
    [ ( "display", "flex" )
    , ( "justify-content", "center" )
    , ( "position", "relative" )
    ]
