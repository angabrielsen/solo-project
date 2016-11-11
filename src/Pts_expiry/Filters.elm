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
    [ Color.background (Color.primary)
    , Options.css "width" "100%"
    , Options.css "padding" "0px" ]
    [ cell
      [ size All 6 ]
      [ grid
        []
        [ cell
          [ size All 6 ]
          [ filterCompany model ]
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
      [ Table.table
        [ Options.css "color" "#000"
        , Options.css "width" "100%" ]
        [ Table.tbody []
          [ Table.tr []
            [ Table.td [] [ text "Select All" ] ]
          , Table.tr []
            [ Table.td [] [ text "O.C. Tanner" ] ]
          , Table.tr []
            [ Table.td [] [ text "Bank of America" ] ]
          , Table.tr []
            [ Table.td [] [ text "T.D. Bank" ] ]
          , Table.tr []
            [ Table.td [] [ text "Dow Chemical" ] ]
          ]
        ]
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