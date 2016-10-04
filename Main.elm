module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Attributes exposing (href, class, style)
import Html.Events exposing (onMouseEnter)
import Material
import Material.Scheme
import Material.Button as Button
import Material.Options exposing (css)
import Material.Layout as Layout
import Material.Color as Color
import Material.Card as Card
import Material.Elevation as Elevation
import Material.Options as Options
import Material.Grid exposing (..)
import Material.Tabs as Tabs
import Material.Icon as Icon

main : Program Never
main =
  App.program
    { init = ( model, Cmd.none )
    , view = view
    , subscriptions = always Sub.none
    , update = update
    }

-- MODEL

type alias Model =
  { mdl : Material.Model
  , selectedTab : Int
  }

model : Model
model =
  { mdl = Material.model
  , selectedTab = 0
  }

-- ACTION, UPDATE

type Msg
  = Mdl (Material.Msg Msg)
  | SelectTab Int

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    Mdl msg' ->
      Material.update msg' model

    SelectTab num ->
      { model | selectedTab = num } ! []


-- VIEW

type alias Mdl =
  Material.Model

view : Model -> Html Msg
view model =
  Material.Scheme.topWithScheme Color.Teal Color.LightGreen <|
    Layout.render Mdl
      model.mdl
      [ Layout.fixedHeader
      , Layout.onSelectTab SelectTab]
      { header =
        [ h1
          [ style
            [ ( "margin", "10px" ) ]
          ]
          [ text "Points Expiration" ]
          ]
      , drawer = []
      , tabs =
        ( [] , [] )
      , main =
        [ viewBody model ]
      }

viewBody : Model -> Html Msg
viewBody model =
  case model.selectedTab of
    0 ->
      viewDash model
    _ ->
      text "404"

viewDash : Model -> Html Msg
viewDash model =
  grid
    [ Options.css "width" "100%"
    , Options.css "padding" "0px"]
    [ cell
      [ size All 12
      , Options.css "width" "100%"
      , Options.css "margin" "0px"
      , Options.css "position" "fixed"
      , Options.css "top" "0px"
      , Color.background ( Color.color Color.Teal Color.S100 ) ]
      [ viewFilters model ]
    , cell
      [ size All 12
      , Options.css "text-align" "center"
      , Options.css "padding" "5px"
      , Options.css "margin-top" "90px" ]
      [ text "Results • All" ]
    , cell
      [ size All 12
      , Options.css "width" "100%"
      , Options.css "margin" "0px" ]
      [ viewResults model
      , viewResults model
      , viewResults model
      , viewResults model
      , viewResults model
      , viewResults model
      , viewResults model
      , viewResults model ]
    , cell
        [ size All 12
        , Options.css "width" "100%"
        , Options.css "margin" "0px" ]
        [ viewActions model ]
      ]

viewFilters : Model -> Html Msg
viewFilters model =
  Options.div
    []
    [ Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some filters!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some filters!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some filters!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some filters!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some filters!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some filters!" ]
    ]

viewResults : Model -> Html Msg
viewResults model =
  Options.div
    []
    [ Options.div
      [ Color.background ( Color.color Color.Teal Color.S50 )
      , Options.css "padding" "5px" ]
      [ text "Even Result" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Odd Result" ]
    , Options.div
      [ Color.background ( Color.color Color.Teal Color.S50 )
      , Options.css "padding" "5px" ]
      [ text "Even Result" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Odd Result" ]
    ]

viewActions : Model -> Html Msg
viewActions model =
  Options.div
    [ Options.css "position" "fixed"
    , Options.css "bottom" "0"
    , Options.css "margin" "0px"
    , Options.css "width" "100%"
    , Color.background ( Color.color Color.Teal Color.S100 )  ]
    [ Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some actions!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some actions!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some actions!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some actions!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Hey, look some actions!" ]
    ]
