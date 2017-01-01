module Validations exposing (..)

import Form.Validate as Validate
    exposing
        ( Validation
        , map2
        , field
        , email
        , customValidation
        , string
        , customError
        , andThen
        , fail
        , succeed
        , withCustomError
        )
import String exposing (isEmpty, length, any)
import Char exposing (..)
import Types
    exposing
        ( LoginForm
        , ChangePwdForm
        , CustomError
        , CustomError
            ( Empty
            , LessChars
            , NoNumber
            , NoCapLetter
            , NoSmallLetter
            , PasswordsMustMatch
            )
        )


validateLoginForm : Validation CustomError LoginForm
validateLoginForm =
    map2 LoginForm
        (field "email" email)
        (field "password" validatePassword)


validatePassword : Validation CustomError String
validatePassword =
    customValidation
        string
        (\s ->
            if isEmpty s then
                Err (customError Empty)
            else if not (any isUpper s) then
                Err (customError NoCapLetter)
            else if not (any isDigit s) then
                Err (customError NoNumber)
            else if not (any isLower s) then
                Err (customError NoSmallLetter)
            else if length s <= 7 then
                Err (customError LessChars)
            else
                Ok s
        )


validateChangePwdForm : Validation CustomError ChangePwdForm
validateChangePwdForm =
    map2 ChangePwdForm
        (field "newPassword" validatePassword)
        ((field "newPassword" string) |> andThen validateConfirmation)


validateConfirmation : String -> Validation CustomError String
validateConfirmation password =
    field "confirmPassword"
        (string
            |> andThen
                (\confirmation ->
                    if password == confirmation then
                        succeed confirmation
                    else
                        fail (customError PasswordsMustMatch)
                )
        )
