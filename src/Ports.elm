port module Ports exposing (openToast, storeApiKey, openDialog, closeDialog)

-- OUTBOUND PORTS


port storeApiKey : String -> Cmd msg


port openToast : () -> Cmd msg


port openDialog : () -> Cmd msg


port closeDialog : () -> Cmd msg
