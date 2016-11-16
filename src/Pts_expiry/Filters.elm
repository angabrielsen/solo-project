module Pts_expiry.Filters exposing (..)

import Html exposing (..)
import Html.Attributes exposing (href, class, style, placeholder)
import Html.Events

import Material
import Material.Grid exposing (..)
import Material.Options as Options exposing (..)
import Material.Color as Color
import Material.Textfield as Textfield
import Material.Table as Table
import Material.Toggles as Toggles

import Set exposing (Set)

import String
import Table

import Pts_expiry.Data as Data

import Mock_data
import Mock_companies

-- VIEW

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
filterCompany { company, tableState, query } =
  let
    lowerQuery =
      String.toLower query

    acceptableCompany = 
      List.filter (String.contains lowerQuery << String.toLower << .company) company
  in
    Options.div
      []
      [ input
        [ placeholder "Search by Company Name or STP", Html.Events.onInput Data.SetQuery ]
        []
      , Table.view config tableState acceptableCompany
      ]

config : Table.Config Mock_companies.Company Data.Msg
config =
  Table.config
    { toId = .company
    , toMsg = Data.SetTableState
    , columns =
      [ Table.stringColumn "Company" .company
      , Table.intColumn "STP" .stp
      ]
    }

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