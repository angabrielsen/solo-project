module Pts_expiry.Actions exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)

import Material
import Material.Options as Options
import Material.Color as Color
import Material.Textfield as Textfield
import Material.Grid exposing (..)
import Material.Button as Button

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
      , expireAll model
      ]
    ]

extendByDate : Data.Model -> Cell Data.Msg
extendByDate model =
  cell
    []
    [ text "Extend to Date: "
    , Html.br [] []
    , Textfield.render Data.Mdl
      [ 5 ]
      model.mdl
      [ Textfield.label "MM/YY/DDDD"
      , Textfield.onInput Data.UpDateExtend]
    , br [] []
    , Button.render Data.Mdl [ 1 ] model.mdl
      [ Button.raised
      , Button.colored
      , Button.ripple ]
      [ text "Extend by Date" ]
    , br [] []
    , text "Extend to Date:"
    , text(toString(Date.toTime(Date.fromString model.dateExtend |> Result.withDefault Mock_data.epoch)))
    ]

extendByTime : Data.Model -> Cell Data.Msg
extendByTime model =
  cell
    []
    [ text "Extend by Time: "
    , Html.br [] []
    , grid
      []
      [ cell
        [ size All 6 ]
        [ Textfield.render Data.Mdl
          [ 6 ]
          model.mdl
          [ Textfield.label "Days" 
          , Textfield.onInput Data.UpExtendDays ]
        , br [] []
        , text (toString model.extendDays)
        ]
      , cell
        [ size All 6 ]
        [ Textfield.render Data.Mdl
          [ 7 ]
          model.mdl
          [ Textfield.label "Weeks"
          , Textfield.onInput Data.UpExtendWeeks ]
        , br [] []
        , text (toString model.extendWeeks)
        ]
      , cell
        [ size All 6 ]
        [ Textfield.render Data.Mdl
          [ 8 ]
          model.mdl
          [ Textfield.label "Months"
          , Textfield.onInput Data.UpExtendMonths ]
        , br [] []
        , text (toString model.extendMonths)
        ]
      , cell
        [ size All 6 ]
        [ Textfield.render Data.Mdl
          [ 9 ]
          model.mdl
          [ Textfield.label "Years"
          , Textfield.onInput Data.UpExtendYears ]
        , br [] []
        , text (toString model.extendYears)
        ]
      , cell
        [ size All 12 ]
        [ Button.render Data.Mdl [ 2 ] model.mdl
          [ Button.raised
          , Button.colored
          , Button.ripple ]
          [ text "Extend by Time"]
        ]
      ]
    , text "Extend by Time: "
    ]

expireAll : Data.Model -> Cell Data.Msg
expireAll model =
  cell
    []
    [ text "Expire selected: "
    , Html.br [] []
    , Button.render Data.Mdl [ 3 ] model.mdl
      [ Button.raised
      , Button.colored
      , Button.ripple ]
      [ text "Expire Selected" ]
    ]