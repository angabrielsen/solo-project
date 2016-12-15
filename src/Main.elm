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

import Table

import Set exposing (Set)

import Mock_data
import Mock_companies

import Pts_expiry.Actions as Actions
import Pts_expiry.Results as Results
import Pts_expiry.Data as Data
import Pts_expiry.Filters as Filters

-- MODEL

init : ( Data.Model, Cmd Data.Msg )
init =
  { mdl = Material.model
  , selectedTab = 0
  , selected = Set.empty
  , data = Mock_data.mockData
  , comp = Mock_data.mockedComp
  , companies = Mock_companies.companies
  , query = ""
  , tableState = Table.initialSort "Company"
  , dateStart = ""
  , dateEnd = ""
  , dateExtend = ""
  , extendDays = ""
  , extendWeeks = ""
  , extendMonths = ""
  , extendYears = ""
  , currentTime = 0
  } ! [ Data.getCurrentTime ]

-- VIEW

main : Program Never
main =
  App.program
    { init = init
    , view = view
    , subscriptions = \_ -> Sub.none
    , update = Data.update
    }

view : Data.Model -> Html Data.Msg
view model =
  Scheme.topWithScheme Color.Blue Color.Indigo <|
    Layout.render Data.Mdl
      model.mdl
      [ Layout.fixedHeader
      , Layout.onSelectTab Data.SelectTab ]
      { header =
        [ Filters.viewFilters model ]
      , drawer = []
      , tabs =
        ( [ text "Results"
          , text "Successful"
          , text "Failed" ] 
        , []
        )
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