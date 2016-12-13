module Pts_expiry.Data exposing (..)

import Material
import Material.Color as Color

import Set exposing (Set)

import Table

import Date

import Task

import Mock_data
import Mock_companies

resultsKey : Mock_data.Munged_Data -> Int
resultsKey =
  .user_transaction_id

-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
  case msg of
    SelectTab num ->
      { model | selectedTab = num } ! []

    Mdl msg' ->
      Material.update msg' model

    Toggle idx ->
      { model | selected = toggle idx model.selected } ! []

    ToggleAll ->
      { model | selected =
        if allSelected model then
          Set.empty
        else
          List.map resultsKey model.data |> Set.fromList
      } ! []

    ToggleComp company ->
      ( { model | companies = List.map (toggleComp company) model.companies }
      , Cmd.none
      )

    SetQuery newQuery ->
      ( { model | query = newQuery }
      , Cmd.none
      )

    SetTableState newState ->
      ( { model | tableState = newState }
      , Cmd.none
      )

    UpDateStart str ->
      { model | dateStart = str } ! []

    UpDateEnd str ->
      { model | dateEnd = str } ! []

    UpDateExtend str ->
      { model | dateExtend = str } ! []

    UpExtendDays str ->
      { model | extendDays = str } ! []

    UpExtendWeeks str ->
      { model | extendWeeks = str } ! []

    UpExtendMonths str ->
      { model | extendMonths = str } ! []

    UpExtendYears str ->
      { model | extendYears = str } ! []

    SetDate maybeDate ->
      case maybeDate of
        Nothing -> model ! []
        Just date ->
          { model | currentDate = Just date } ! []

type alias Model =
  { mdl : Material.Model
  , selected : Set Int
  , selectedTab : Int
  , data : List Mock_data.Munged_Data
  , comp : List Mock_data.Comp
  , companies : List Mock_companies.Company
  , tableState : Table.State
  , query : String
  , dateStart : String
  , dateEnd : String
  , dateExtend : String
  , extendDays : String
  , extendWeeks : String
  , extendMonths : String
  , extendYears : String
  , currentDate : Maybe Date.Date
  }

type Msg
  = Mdl (Material.Msg Msg)
  | SelectTab Int
  | Toggle Int
  | ToggleAll
  | ToggleComp String
  | SetQuery String
  | SetTableState Table.State
  | UpDateStart String
  | UpDateEnd String
  | UpDateExtend String
  | UpExtendDays String
  | UpExtendWeeks String
  | UpExtendMonths String
  | UpExtendYears String
  | SetDate (Maybe Date.Date)

currentTime : Cmd Msg
currentTime =
  Task.perform (always (SetDate Nothing)) (Just >> SetDate) Date.now

toggle : comparable -> Set comparable -> Set comparable
toggle x set =
  if Set.member x set then
    Set.remove x set
  else
    Set.insert x set

toggleComp : String -> Mock_companies.Company -> Mock_companies.Company
toggleComp company item =
  if item.company == company then
    { item | selectedComp = not item.selectedComp }

  else
    item

allSelected : Model -> Bool
allSelected model =
  Set.size model.selected == List.length model.data