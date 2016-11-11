module Pts_expiry.Actions exposing (..)

import Html exposing (..)

import Material
import Material.Options as Options
import Material.Color as Color
import Material.Grid exposing (..)

import Pts_expiry.Data as Data

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
    [ Options.div
      [ Options.css "padding" "5px" ]
      [ Html.text "Hey, look some actions!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ Html.text "Hey, look some actions!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ Html.text "Hey, look some actions!" ]
    ]