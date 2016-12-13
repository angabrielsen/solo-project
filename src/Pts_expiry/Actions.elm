module Pts_expiry.Actions exposing (..)

import Html exposing (..)

import Material
import Material.Options as Options
import Material.Color as Color
import Material.Textfield as Textfield
import Material.Grid exposing (..)

import Date

import Pts_expiry.Data as Data
import Mock_data

-- UPDATE

-- VIEW

viewActionsCell : Data.Model -> Cell Data.Msg
viewActionsCell model =
  cell
    [ size All 12
    , Options.css "width" "100%"
    , Options.css "margin" "0px"
    , Options.css "overflow-y" "scroll"
    , Options.css "z-index" "1"]
    [ viewActions model ]

viewActions : Data.Model -> Html Data.Msg
viewActions model =
  Options.div
    [ Options.css "position" "fixed"
    , Options.css "bottom" "0"
    , Options.css "margin" "0px"
    , Options.css "width" "100%"
    , Options.css "background-color" "#efefef"  ]
    [ grid
      []
      [ extendByDate model
      , extendByTime model
      , cell
        []
        [ expireAll model ]
      ]
    ]

extendByDate : Data.Model -> Cell Data.Msg
extendByDate model =
  cell
    []
    [ text "Extend to Date: "
    , Textfield.render Data.Mdl
      [ 5 ]
      model.mdl
      [ Textfield.label "MM/YY/DDDD"
      , Textfield.onInput Data.UpDateExtend]
    , text "Extend to Date:"
    , text(toString(Date.toTime(Date.fromString model.dateExtend |> Result.withDefault Mock_data.epoch)))
    ]

extendByTime : Data.Model -> Cell Data.Msg
extendByTime model =
  cell
    []
    [ text "Extend by Time: " ]

expireAll : Data.Model -> Html Data.Msg
expireAll model =
  text "Expire All"