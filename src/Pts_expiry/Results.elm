module Pts_expiry.Results exposing (..)

import Html exposing (..)

import Material
import Material.Grid exposing (..)
import Material.Options as Options exposing (..)
import Material.Table as Table
import Material.Toggles as Toggles

import Set exposing (Set)

import Pts_expiry.Data as Data

import Mock_data

-- VIEW

viewResultsTabs : Data.Model -> Cell Data.Msg
viewResultsTabs model =
  cell
    [ size All 12
    , Options.css "margin" "0px"
    , Options.css "width" "100%"
    , Options.css "overflow-y" "scroll" ]
    [ case model.selectedTab of
      0 -> viewAllResults model
      1 -> viewFilteredResults model
      2 -> viewSuccessfulResults model
      3 -> viewFailedResults model
      _ -> viewNoResults model
    ]

viewAllResults : Data.Model -> Html Data.Msg
viewAllResults model =
  Options.div
    [] 
    [ allResults model ]

viewFilteredResults : Data.Model -> Html Data.Msg
viewFilteredResults model =
  Options.div
    [] 
    [ filteredResults model ]

viewSuccessfulResults : Data.Model -> Html Data.Msg
viewSuccessfulResults model =
  Options.div
    [] 
    [ text "Succesful Expiration Changes" ]

viewFailedResults : Data.Model -> Html Data.Msg
viewFailedResults model =
  Options.div
    [] 
    [ text "Failed Expiration Changes" ]

viewNoResults : Data.Model -> Html Data.Msg
viewNoResults model =
  Options.div
    [] 
    [ text "No Results Found" ]

allResults : Data.Model -> Html Data.Msg
allResults model =
  Table.table
    [ Options.css "width" "100%"]
    [ Table.thead []
      [ Table.tr []
        [ Table.th []
          [ Toggles.checkbox Data.Mdl [-1] model.mdl
            [ Toggles.onClick Data.ToggleAll
            , Toggles.value (Data.allSelected model)
            ] []
          ]
        , Table.th [] [ text "Last Name" ]
        , Table.th [] [ text "First Name" ]
        , Table.th [] [ text "Current Status" ]
        , Table.th [] [ text "Pts. Remaining" ]
        , Table.th [] [ text "Expiration Date" ]
        , Table.th [] [ text "Pts. Type" ]
        ]
      ]
    , Table.tbody []
      ( model.data
        |> List.indexedMap (\idx item ->
          Table.tr
            [ Table.selected `when` Set.member (Data.resultsKey item) model.selected ]
            [ Table.td []
              [ Toggles.checkbox Data.Mdl [idx] model.mdl
                [ Toggles.onClick (Data.Toggle <| Data.resultsKey item)
                , Toggles.value <| Set.member (Data.resultsKey item) model.selected
                ] []
              ]
            , Table.td [] [ text item.last_name ]
            , Table.td [] [ text item.first_name ]
            , Table.td [] [ text <| toString item.current_status_code ]
            , Table.td [] [ text <| toString item.points_remaining ]
            , Table.td [] [ text item.expiry_date ]
            , Table.td [] [ text item.points_status_ind ]
          ]
        )
      )
    ]

filteredResults : Data.Model -> Html Data.Msg
filteredResults model =
  text "All Filtered Results"