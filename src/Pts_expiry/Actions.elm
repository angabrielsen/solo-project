module Pts_expiry.Actions exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)

import Material
import Material.Options as Options
import Material.Color as Color
import Material.Textfield as Textfield
import Material.Grid exposing (..)
import Material.Button as Button
import Material.Tabs as Tabs

import Date
import Date.Extra as DateEx
import Time
import String

import Pts_expiry.Data as Data exposing (..)
import Mock_data

-- UPDATE

-- VIEW

viewActionsCell : Data.Model -> Cell Data.Msg
viewActionsCell model =
  cell
    [ size All 12
    , Options.css "width" "100%"
    , Options.css "margin" "0px"
    , Options.css "overflow-y" "scroll"
    , Options.css "z-index" "1"]
    [ viewActions model ]

viewActions : Data.Model -> Html Data.Msg
viewActions model =
  Options.div
    []
    [ grid
      [ Options.css "position" "fixed"
      , Options.css "height" "275px"
      , Options.css "bottom" "0"
      , Options.css "margin" "0px"
      , Options.css "width" "100%"
      , Options.css "background-color" "#efefef" 
      ]
      [ cell
        [ size All 8 ]
        [ Tabs.render Mdl [1] model.mdl
          [ Tabs.ripple
          , Tabs.onSelectTab SelectActionTab
          , Tabs.activeTab model.selectedActionTab ]
          [ Tabs.label
            []
            [ text "Expire by Date" ]
          , Tabs.label
            []
            [ text "Expire by Time" ]
          ]
          [ case model.selectedActionTab of
            0 -> extendByDate model
            1 -> extendByTime model
            _ -> extendByDate model
          ]
        ]
      , cell
        [ size All 4 ]
        [ expireAll model ]
      ]
    ]

extendByDate : Data.Model -> Html Data.Msg
extendByDate model =
  grid
    []
    [ cell
      [ size All 12 ]
      [ Textfield.render Data.Mdl
        [ 5 ]
        model.mdl
        [ Textfield.label "MM/YY/DDDD"
        , Textfield.onInput Data.UpDateExtend]
      , br [] []
      , Button.render Data.Mdl [ 1 ] model.mdl
        [ Button.raised
        , Button.colored
        , Button.ripple ]
        [ text "Extend by Date" ]
      , br [] []
      , text ("Extend to: " ++ toString(Date.fromString model.dateExtend |> Result.withDefault (Date.fromTime(model.currentTime))))
      ]
    ]
    
extendByTime : Data.Model -> Html Data.Msg
extendByTime model =
  grid
    []
    [ cell
      [ size All 12 ]
      [ grid
        [ Options.css "padding" "0px" ]
        [ cell
          [ size All 3 ]
          [ Textfield.render Data.Mdl
            [ 6 ]
            model.mdl
            [ Textfield.label "Days" 
            , Textfield.onInput Data.UpExtendDays
            , Options.css "width" "50%" ]
          ]
        , cell
          [ size All 3 ]
          [ Textfield.render Data.Mdl
            [ 7 ]
            model.mdl
            [ Textfield.label "Weeks"
            , Textfield.onInput Data.UpExtendWeeks
            , Options.css "width" "50%" ]
          ]
        , cell
          [ size All 3 ]
          [ Textfield.render Data.Mdl
            [ 8 ]
            model.mdl
            [ Textfield.label "Months"
            , Textfield.onInput Data.UpExtendMonths
            , Options.css "width" "50%" ]
          ]
        , cell
          [ size All 3 ]
          [ Textfield.render Data.Mdl
            [ 9 ]
            model.mdl
            [ Textfield.label "Years"
            , Textfield.onInput Data.UpExtendYears
            , Options.css "width" "50%" ]
          ]
        , cell
          [ size All 12
          , Options.css "margin" "0px" ]
          [ Button.render Data.Mdl [ 2 ] model.mdl
            [ Button.raised
            , Button.colored
            , Button.ripple ]
            [ text "Extend Selected"]
          ]
        ]
      , text ("Extend to final date of: " ++ (toString(extendByYears (model.extendYears) (extendByMonths (model.extendMonths) (extendByWeeks (model.extendWeeks) (extendByDays (model.extendDays) (model.currentTime)))))))
      ]
    ]

expireAll : Data.Model -> Html Data.Msg
expireAll model =
  grid
    []
    [ cell
      [ size All 12 ]
      [ Button.render Data.Mdl [ 3 ] model.mdl
        [ Button.raised
        , Button.colored
        , Button.ripple ]
        [ text "Expire Selected" ]
      , br [] []
      , text "01-01-15 Before 5: "
      , br [] []
      , text (toString(Date.fromTime(toFloat(getExpireTime(1420113599000)))))
      , br [] []
      , text "01-01-15 After 5: "
      , br [] []
      , text (toString(Date.fromTime(toFloat(getExpireTime(1420113600000)))))
      ]
    ]

-- HELPER FUNCTIONS
extendByDays : String -> Float -> Date.Date
extendByDays days date =
  DateEx.add DateEx.Day (Result.withDefault 0 (String.toInt(days))) (Date.fromTime(date))

extendByWeeks : String -> Date.Date -> Date.Date
extendByWeeks weeks date =
  DateEx.add DateEx.Week (Result.withDefault 0 (String.toInt(weeks))) (date)

extendByMonths : String -> Date.Date -> Date.Date
extendByMonths months date =
  DateEx.add DateEx.Month (Result.withDefault 0 (String.toInt(months))) (date)

extendByYears : String -> Date.Date -> Date.Date
extendByYears years date =
  DateEx.add DateEx.Year (Result.withDefault 0 (String.toInt(years))) (date)

getExpireTime : Time.Time -> Int
getExpireTime time =
  let
    date = Date.fromTime time

    midnight =  (Time.inMilliseconds(time) |> round) - ((Date.hour(date) * 60 * 60) + (Date.minute(date) * 60) + (Date.second(date)) - Date.millisecond(date))
  in 
    if Date.hour date < 5 then
      midnight
    else
      midnight + 24 * 60 * 60 * 1000