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
import Material.List as Lists
import Material.Typography as Typo
import Material.Textfield as Textfield

import Css exposing (..)

--css = 
--  ( stylesheet )
--    [ body
--      [ color (rgb 7 7 7) ]
--    ]

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
      [ Layout.fixedHeader ]
      { header =
        [ viewFilters model ]
      , drawer = []
      , tabs =
        ( [] , [] )
      , main =
        [ viewDash model ]
      }

viewDash : Model -> Html Msg
viewDash model =
  grid
    [ Options.css "width" "100%"
    , Options.css "padding" "0px"]
    [ Material.Grid.cell
      [ size All 12
      , Options.css "margin" "0px"
      , Options.css "width" "100%"
      , Options.css "text-align" "center"
      , Options.css "padding" "5px" ]
      [  Html.text "Results • All" ]
    , Material.Grid.cell
      [ size All 12
      , Options.css "margin" "0px"
      , Options.css "width" "100%"
      , Options.css "overflow-y" "scroll" ]
      [ viewResults model ]
    , Material.Grid.cell
        [ size All 12
        , Options.css "width" "100%"
        , Options.css "margin" "0px" ]
        [ viewActions model ]
      ]

viewFilters : Model -> Html Msg
viewFilters model =
  grid
    [ Color.background ( Color.color Color.Teal Color.S100 )
    , Options.css "width" "100%" ]
    [ Material.Grid.cell
      [ size All 6 ]
      [ grid
        []
        [ Material.Grid.cell
          [ size All 6 ]
          [ filterCompany model
          , filterSTP model ]
        , Material.Grid.cell
          [ size All 6 ]
          [ p
            [ style [ ( "padding-top", "45px" ), ( "margin", "0px" ) ] ]
            [ Html.text "Select Program:" ]
          , filterProgram model ]
        ]
      ]
    , Material.Grid.cell
      [ size All 6 ]
      [ grid
        []
        [ Material.Grid.cell
          [ size All 12 ]
          [ filterDate model ]
        ]
      ]
    ]

filterCompany : Model -> Html Msg
filterCompany model =
  Options.div
    []
    [ Textfield.render Mdl
      [ 1 ]
      model.mdl
      [ Textfield.label "Choose company:" ]
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

filterSTP : Model -> Html Msg
filterSTP model =
  Options.div
    []
    [ Textfield.render Mdl
      [ 2 ]
      model.mdl
      [ Textfield.label "Search by STP" ] 
    , Options.div
      [ Options.css "height" "50px"
      , Options.css "overflow-y" "scroll" ]
      [ ul
        [ style [ ( "list-style-type", "none" ), ( "background-color", "#FFF" ), ( "padding-left", "10px" ), ( "margin", "0px"), ("color", "#000")  ] ]
        [ li [] [ Html.text "BoA - 9999" ] 
        , li [] [ Html.text "BoA - 9998" ] 
        , li [] [ Html.text "BoA - 9997" ]
        , li [] [ Html.text "BoA - 9996" ] 
        , li [] [ Html.text "BoA - 9995" ]
        ]
      ]
    ]

filterProgram : Model -> Html Msg
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

filterDate : Model -> Html Msg
filterDate model =
  Options.div
    []
    [ grid
      []
      [ Material.Grid.cell
        []
        [ Textfield.render Mdl
          [ 3 ]
          model.mdl
          [ Textfield.label "MM/YY/DDDD"
          , Options.css "padding-bottom" "5px" ]
        , Html.text "Start Date"
        ]
      , Material.Grid.cell
        []
        [ Textfield.render Mdl
          [ 4 ]
          model.mdl
          [ Textfield.label "MM/YY/DDDD"
          , Options.css "padding-bottom" "5px" ]
        , Html.text "End Date"
        ]
      ]
    ]

viewResult : Model -> Html Msg
viewResult model =
  Lists.li
    []
    [ Lists.content
      []
      [ Html.text "Test"]
    ]

viewResults : Model -> Html Msg
viewResults model =
  Lists.ul
    [ Options.css "padding" "15px" ]
    [ viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model 
    , viewResult model ] 

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
      [ Html.text "Hey, look some actions!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ Html.text "Hey, look some actions!" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ Html.text "Hey, look some actions!" ]
    ]
