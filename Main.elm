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
    { count : Int
    , mdl :
        Material.Model
    , selectedTab : Int
    }
model : Model
model =
    { count = 0
    , mdl =
        Material.model
    , selectedTab = 0
    }

-- ACTION, UPDATE

type Msg
    = Increase
    | Reset
    | Mdl (Material.Msg Msg)
    | SelectTab Int

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increase ->
            ( { model | count = model.count + 1 }
            , Cmd.none
            )

        Reset ->
            ( { model | count = 0 }
            , Cmd.none
            )

        -- When the `Mdl` messages come through, update appropriately.
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
        , Layout.selectedTab model.selectedTab
        , Layout.onSelectTab SelectTab
        ]
        { header = [ h1 [ style [ ( "padding", "2rem" ) ] ] [ text "Budgeting Tool" ] ]
        , drawer = []
        , tabs = ( [ text "Events", text "Challenges" ], [ Color.background (Color.color Color.Teal Color.S400) ] )
        , main = [ viewCard model ]
        }

viewCard : Model -> Html Msg
viewCard model =
  grid [ Options.css "width" "100%"
       , Options.css "padding" "10px" ]
      [ cell [ size All 4
              , Options.css "padding" "10px" ]
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
      , cell [ size All 4
             , Options.css "padding" "10px" ]
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
      , cell [ size All 4
             , Options.css "padding" "10px" ]
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
      , cell [ size All 12
              , Color.background (Color.color Color.DeepPurple Color.S50)
              , Options.css "padding" "10px" ]
              [ text "Vice franzen echo park seitan, yuccie banjo prism umami cornhole actually cred PBR&B. Blue bottle etsy organic, food truck tote bag typewriter hot chicken. Coloring book fanny pack leggings bitters artisan. Farm-to-table keffiyeh trust fund, hot chicken semiotics gochujang keytar beard. Etsy tattooed polaroid jianbing 8-bit, irony live-edge snackwave godard kogi XOXO la croix af mixtape schlitz. Dreamcatcher mlkshk glossier affogato bushwick, hashtag vegan next level shabby chic 8-bit cardigan organic schlitz. Pinterest mixtape waistcoat paleo mumblecore gentrify. Vice franzen echo park seitan, yuccie banjo prism umami cornhole actually cred PBR&B. Blue bottle etsy organic, food truck tote bag typewriter hot chicken. Coloring book fanny pack leggings bitters artisan. Farm-to-table keffiyeh trust fund, hot chicken semiotics gochujang keytar beard. Etsy tattooed polaroid jianbing 8-bit, irony live-edge snackwave godard kogi XOXO la croix af mixtape schlitz. Dreamcatcher mlkshk glossier affogato bushwick, hashtag vegan next level shabby chic 8-bit cardigan organic schlitz. Pinterest mixtape waistcoat paleo mumblecore gentrify."]
      ]