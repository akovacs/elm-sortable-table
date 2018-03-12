module Main exposing (..)

import Css exposing (Color, backgroundColor, rgb)
import Html.Styled exposing (Html, br, button, div, input, li, program, span, text, ul)
import Html.Styled.Attributes as Attr
import Html.Styled.Events exposing (onInput)
import Table


-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init colors
        , update = update
        , view = view
        , subscriptions = always Sub.none
        }



-- MODEL


type alias ColorVariant =
    { hexcode : String
    , color : Color
    , name : String
    }


colors : List ColorVariant
colors =
    [ ColorVariant "FF00FF" (rgb 255 0 255) "magenta"
    , ColorVariant "FF0000" (rgb 255 0 0) "red"
    , ColorVariant "FF681F" (rgb 255 104 31) "orange"
    , ColorVariant "FFC0CB" (rgb 255 192 203) "pink"
    , ColorVariant "FFE5B4" (rgb 255 229 180) "peach"
    , ColorVariant "FFFF00" (rgb 255 255 0) "yellow"
    , ColorVariant "BFFF00" (rgb 191 255 0) "lime"
    , ColorVariant "00FF00" (rgb 0 255 0) "green"
    , ColorVariant "00FFFF" (rgb 0 255 255) "cyan"
    , ColorVariant "06C2AC" (rgb 6 194 172) "turquoise"
    , ColorVariant "008080" (rgb 0 128 128) "teal"
    , ColorVariant "0000FF" (rgb 0 0 255) "blue"
    , ColorVariant "4F69C6" (rgb 79 105 198) "indigo"
    , ColorVariant "660099" (rgb 102 0 153) "purple"
    , ColorVariant "240A40" (rgb 36 10 64) "violet"
    , ColorVariant "000000" (rgb 0 0 0) "black"
    , ColorVariant "808080" (rgb 128 128 128) "gray"
    , ColorVariant "964B00" (rgb 150 75 0) "brown"
    ]


type alias Model =
    { colors : List ColorVariant
    , search : String
    , tableState : Table.State
    }


config : Table.Config ColorVariant Msg
config =
    Table.config
        { toId = .name
        , toMsg = SetTableState
        , columns =
            [ Table.stringColumn "Name" .name
            , colorColumn
            ]
        }


init : List ColorVariant -> ( Model, Cmd Msg )
init colors =
    let
        model =
            { colors = colors
            , search = ""
            , tableState = Table.initialSort "HexCode"
            }
    in
    ( model, Cmd.none )



-- MESSAGES


type Msg
    = UpdateColor String
    | SetTableState Table.State



-- VIEW


view : Model -> Html Msg
view { colors, search, tableState } =
    let
        matchingColors =
            if String.length search > 0 then
                List.filter (String.contains search << .name) colors
            else
                colors
    in
    div []
        [ input
            [ Attr.value search
            , onInput (\inputString -> UpdateColor (String.toLower inputString))
            ]
            []
        , br [] []
        , Table.view config tableState matchingColors
        ]


viewColor : ColorVariant -> Table.HtmlDetails Msg
viewColor color =
    Table.HtmlDetails []
        [ span [ Attr.css [ backgroundColor color.color ] ] [ text "    " ]
        , text (" #" ++ color.hexcode)
        ]


colorColumn : Table.Column ColorVariant Msg
colorColumn =
    Table.veryCustomColumn
        { name = "Color"
        , viewData = viewColor
        , sorter = Table.increasingOrDecreasingBy .hexcode
        }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdateColor colorname ->
            ( { model | search = colorname }, Cmd.none )

        SetTableState newState ->
            ( { model | tableState = newState }, Cmd.none )
