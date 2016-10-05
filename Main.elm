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
    [ cell
      [ size All 12
      , Options.css "margin" "0px"
      , Options.css "width" "100%"
      , Options.css "text-align" "center"
      , Options.css "padding" "5px" ]
      [  text "Results • All" ]
    , cell
      [ size All 12
      , Options.css "margin" "0px"
      , Options.css "width" "100%" ]
      [ viewResults model ]
    , cell
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
            [ text "Select Program:" ]
          , filterProgram model ]
        ]
      ]
    , cell
      [ size All 6 ]
      [ text "Right" ]
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
        [ li [] [ text "Select All" ] 
        , li [] [ text "Bank of America" ] 
        , li [] [ text "O.C. Tanner" ]
        , li [] [ text "T.D. Bank" ] 
        , li [] [ text "US Bank" ]
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
      [ li [] [ text "Select All" ] 
      , li [] [ text "Redemption" ] 
      , li [] [ text "Achievement" ]
      , li [] [ text "Great Work" ] 
      , li [] [ text "Other Fun Stuff" ]
      ]
    ]

viewResult : Model -> Html Msg
viewResult model =
  Options.div
    []
    [ Options.div
      [ Color.background ( Color.color Color.Teal Color.S50 )
      , Options.css "padding" "5px"]
      [ text "Even Result" ]
    , Options.div
      [ Options.css "padding" "5px" ]
      [ text "Odd Result" ]
    ]

viewResults : Model -> Html Msg
viewResults model =
  Options.div
    [ Options.css "padding-bottom" "90px" ]
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
    , text "END" ] 

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
    ]
