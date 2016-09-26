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
        { header = [ h1 [ style [ ( "padding", "10px 0px 0px 10px" ), ( "margin", "0px" ) ] ] [ text "Budgeting Tool" ] ]
        , drawer = []
        , tabs = ( [text "Dashboard", text "Budget", text "Events", text "Challenges"], [] )
        , main = [ viewBody model ]
        }

viewBody : Model -> Html Msg
viewBody model =
  case model.selectedTab of
    0 ->
      viewDash model
    1 ->
      viewBudget model
    2 ->
      viewEvents model
    3 ->
      viewChallenges model
    _ ->
      text "404"

viewFilters : Model -> Html Msg
viewFilters model =
  Options.div [] []

viewDash : Model -> Html Msg
viewDash model =
  grid [ Options.css "width" "100%"
       , Options.css "padding" "0px"]
      [ cell [ size All 3 ]
              [ Card.view
                [ Elevation.e4
                , css "width" "100%"
                , css "height" "100%"
                , css "color" "white"
                , Color.background (Color.color Color.Pink Color.S500)
                ]
                [ Card.title [] [ text "Titleholder"
                                , Card.subhead [] [ text "Subheadholder" ] 
                                ]
                , Card.media [] [ Options.img [ Options.css "max-width" "100%" ] [ Html.Attributes.src "assets/images/ash.jpg" ] ]
                , Card.text [ ] [ text "Textholder" ]
                , Card.actions [ ] [ text "Actionholder" ]
                ]
              ]
      , cell [ size All 9 ]
             [ Card.view
                [ Elevation.e4
                , css "width" "100%"
                , css "height" "100%"
                , css "color" "white"
                , Color.background (Color.color Color.Pink Color.S500)
                ]
                [ Card.title [] [ text "Titleholder"
                                , Card.subhead [] [ text "Subheadholder" ] 
                                ]
                , Card.media [] [ Options.img [ Options.css "max-width" "100%" ] [ Html.Attributes.src "assets/images/ash.jpg" ] ]
                , Card.text [ ] [ text "Textholder" ]
                , Card.actions [ ] [ text "Actionholder" ]
                ]
              ]
        ]

viewBudget : Model -> Html Msg
viewBudget model =
  grid [ Options.css "width" "100%"
       , Options.css "padding" "0px" ]
      [ cell [ size All 12
              , Color.background (Color.color Color.DeepPurple Color.S50)
              , Options.css "padding" "10px" ]
              [ text "Budget"]
      ]

viewEvents : Model -> Html Msg
viewEvents model =
  grid [ Options.css "width" "100%"
       , Options.css "padding" "0px" ]
      [ cell [ size All 12
              , Color.background (Color.color Color.DeepPurple Color.S50)
              , Options.css "padding" "10px" ]
              [ text "Events"]
      ]

viewChallenges : Model -> Html Msg
viewChallenges model =
  grid [ Options.css "width" "100%"
       , Options.css "padding" "0px" ]
      [ cell [ size All 12
              , Color.background (Color.color Color.DeepPurple Color.S50)
              , Options.css "padding" "10px" ]
              [ text "Challenges"]
      ]