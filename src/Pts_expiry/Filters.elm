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

import Date

import String
import Table exposing (defaultCustomizations)

import Pts_expiry.Data as Data

import Mock_data
import Mock_companies

-- VIEW

viewFilters : Data.Model -> Html Data.Msg
viewFilters model =
  grid
    [ Color.background (Color.accent)
    , Options.css "width" "100%"
    , Options.css "padding" "0px" ]
    [ cell
      [ size All 6 ]
      [ filterCompany model ]
    , cell
      [ size All 6 ]
      [ filterDate model ]
    ]

filterCompany : Data.Model -> Html Data.Msg
filterCompany model =
  Options.div
    []
    [ let
        lowerQuery =
          String.toLower model.query

        acceptableCompany = 
          List.filter (String.contains lowerQuery << String.toLower << .company) Mock_companies.companies
      in
        Options.div
          []
          [ input
            [ placeholder "Search by Company Name or STP", Html.Events.onInput Data.SetQuery, style [ ( "width", "40%" ) ] ]
            []
          , Table.view config model.tableState acceptableCompany
          ]
    ]

config : Table.Config Mock_companies.Company Data.Msg
config =
  Table.customConfig
    { toId = .company
    , toMsg = Data.SetTableState
    , columns =
      [ Table.stringColumn "Company" .company ]
    , customizations =
      { defaultCustomizations
      | rowAttrs = toRowAttrs
      , tableAttrs = toTableAttrs }
    }

toRowAttrs : Mock_companies.Company -> List (Attribute Data.Msg)
toRowAttrs company =
  if company.selectedComp then
    [ style
      [ ( "background-color", "#efefef" )
      , ( "color", "#000") ]
    ]
  else
    [] 

toTableAttrs : List (Attribute Data.Msg)
toTableAttrs =
  [ style
    [ ( "width", "100%" )
    , ( "background-color", "#FFF" )
    , ( "color", "#000" ) ]
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
          , Textfield.onInput Data.UpDateStart]
        , Html.text "Start Date"
        , Html.text <| toString (Date.toTime (Date.fromString model.dateStart |> Result.withDefault Mock_data.epoch))
        ]
      , cell
        []
        [ Textfield.render Data.Mdl
          [ 4 ]
          model.mdl
          [ Textfield.label "MM/YY/DDDD"
          , Textfield.onInput Data.UpDateEnd]
        , text "End Date"
        , Html.text(toString(Date.toTime(Date.fromString model.dateEnd |> Result.withDefault Mock_data.distantFuture)))
        ]
      ]
    ]