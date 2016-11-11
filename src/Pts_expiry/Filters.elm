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

import Mock_data

key : Mock_data.Comp -> Int
key =
  .comp_id

-- UPDATE

update : Data.Msg -> Data.Model -> ( Data.Model, Cmd Data.Msg )
update msg model =
  case msg of
    Data.SelectTab num ->
      { model | selectedTab = num } ! []

    Data.Mdl msg' ->
      Material.update msg' model

    Data.Toggle idx ->
      { model | selected = Data.toggle idx model.selected } ! []

    Data.ToggleAll ->
      { model | selected =
        if Data.allSelected model then
          Set.empty
        else
          List.map key model.comp |> Set.fromList
      } ! []

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
          ( model.comp
            |> List.indexedMap (\idx item ->
              Table.tr
                [ Table.selected `when` Set.member (key item) model.selected ]
                [ Table.td [] [ text item.comp_name ]
              ]
            )
          )
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