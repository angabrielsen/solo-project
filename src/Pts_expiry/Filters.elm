module Pts_expiry.Filters exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style)

import Material
import Material.Grid exposing (..)
import Material.Options as Options exposing (..)
import Material.Color as Color
import Material.Textfield as Textfield
import Material.Table as Table
import Material.Toggles as Toggles

import Set exposing (Set)

import Pts_expiry.Data as Data

viewFilters : Data.Model -> Html Data.Msg
viewFilters model =
  grid
    [ Options.css "width" "100%"
    , Options.css "padding" "0px" ]
    [ cell
      [ size All 6 ]
      [ grid
        []
        [ cell
          [ size All 6 ]
          [ filterCompany model ]
        , cell
          [ size All 6 ]
          [ p
            [ style [ ( "padding-top", "45px" ), ( "margin", "0px" ) ] ]
            [ Html.text "Select Program:" ]
          , filterProgram model ]
        ]
      ]
    , cell
      [ size All 6 ]
      [ grid
        []
        [ cell
          [ size All 12 ]
          [ filterDate model ]
        ]
      ]
    , cell
      [ size All 12
      , Options.css "margin" "0px"
      , Options.css "width" "100%" ]
      [ grid
        [ Options.css "padding" "0px"
        , Options.css "background-color" "#FFF"
        , Options.css "width" "100%" ]
        [ cell
          [ size All 12
          , Options.css "text-align" "center"
          , Options.css "background-color" "#FFF"
          , Options.css "color" "#000"
          , Options.css "margin" "0px" ]
          []
        ]
      ]
    ]

filterCompany : Data.Model -> Html Data.Msg
filterCompany model =
  Options.div
    []
    [ Textfield.render Data.Mdl
      [ 1 ]
      model.mdl
      [ Textfield.label "Choose company by name or STP" ]
    , Options.div
      [ Options.css "height" "50px"
      , Options.css "overflow-y" "scroll" ]
      [ ul
        [ style [ ( "list-style-type", "none" ), ( "background-color", "#FFF" ), ( "padding-left", "10px" ), ( "margin", "0px"), ("color", "#000")  ] ]
        [ li [] [ Html.text "Select All" ] 
        , li [] [ Html.text "Bank of America" ] 
        , li [] [ Html.text "O.C. Tanner" ]
        , li [] [ Html.text "T.D. Bank" ] 
        , li [] [ Html.text "US Bank" ]
        ]
      ]
    ]

filterProgram : Data.Model -> Html Data.Msg
filterProgram model =
  Options.div
    [ Options.css "height" "50px"
    , Options.css "width" "100%"
    , Options.css "overflow-y" "scroll"
    , Options.css "color" "#000" ]
    [ ul
      [ style [ ( "list-style-type", "none" ), ( "background-color", "#FFF" ), ( "padding-left", "10px" ), ( "margin", "0px") ] ]
      [ li [] [ Html.text "Select All" ] 
      , li [] [ Html.text "Redemption" ] 
      , li [] [ Html.text "Achievement" ]
      , li [] [ Html.text "Great Work" ] 
      , li [] [ Html.text "Other Fun Stuff" ]
      ]
    ]

filterDate : Data.Model -> Html Data.Msg
filterDate model =
  Options.div
    []
    [ grid
      []
      [ cell
        []
        [ Textfield.render Data.Mdl
          [ 3 ]
          model.mdl
          [ Textfield.label "MM/YY/DDDD"
          , Options.css "padding-bottom" "5px" ]
        , Html.text "Start Date"
        ]
      , cell
        []
        [ Textfield.render Data.Mdl
          [ 4 ]
          model.mdl
          [ Textfield.label "MM/YY/DDDD"
          , Options.css "padding-bottom" "5px" ]
        , Html.text "End Date"
        ]
      ]
    ]