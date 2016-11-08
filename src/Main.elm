module Main exposing (..)

import Html.App as App
import Html exposing (..)

import Material
import Material.Scheme as Scheme
import Material.Options as Options exposing (..)
import Material.Color as Color
import Material.Layout as Layout
import Material.Options as Options
import Material.Grid exposing (..)

import Set exposing (Set)

import Mock_data

import Pts_expiry.Actions as Actions
import Pts_expiry.Results as Results
import Pts_expiry.Data as Data
import Pts_expiry.Filters as Filters

-- MODEL

init : Data.Model
init =
  { mdl = Material.model
  , selectedTab = 0
  , selected = Set.empty
  , data = Mock_data.mockData
  , primary = Color.Teal
  , accent = Color.Purple
  }

-- VIEW

main : Program Never
main =
  App.program
    { init = ( init, Cmd.none )
    , view = view
    , subscriptions = always Sub.none
    , update = Results.update
    }

view : Data.Model -> Html Data.Msg
view model =
  Scheme.topWithScheme model.primary model.accent <|
    Layout.render Data.Mdl
      model.mdl
      [ Layout.fixedHeader
      , Layout.onSelectTab Data.SelectTab ]
      { header =
        [ Filters.viewFilters model ]
      , drawer = []
      , tabs =
        ( [ text "All", text "Filtered", text "Successful", text "Failed" ] , [ Color.background (Color.accent) ] )
      , main =
        [ viewDash model ]
      }

viewDash : Data.Model -> Html Data.Msg
viewDash model =
  grid
    [ Options.css "width" "100%"
    , Options.css "padding" "0px"
    , Options.css "overflow-y" "scroll" ]
    [ Results.viewResultsTabs model
    , Actions.viewActionsCell model
    ]