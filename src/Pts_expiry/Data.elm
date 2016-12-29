module Pts_expiry.Data exposing (..)

import Material
import Material.Color as Color

import Set exposing (Set)

import Table

import Date
import Time
import Task

import Update.Extra as UpdateEx

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

    SelectActionTab num ->
      { model | selectedActionTab = num } ! []

    Mdl msg' ->
      Material.update msg' model

    Toggle idx ->
      { model | selected = toggle idx model.selected } ! []

    ToggleAll ->
      { model
        | selected =
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
        |> UpdateEx.andThen update (UpResults model.data)

    UpDateEnd str ->
      { model | dateEnd = str } ! []
        |> UpdateEx.andThen update (UpResults model.data)

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

    UpResults results ->
      { model | dataFiltered = afterStartDate model.dateStart model.dateEnd model.data } ! []

    SetTime time ->
      { model | currentTime = time } ! []

type alias Model =
  { mdl : Material.Model
  , selected : Set Int
  , selectedTab : Int
  , selectedActionTab : Int
  , data : List Mock_data.Munged_Data
  , dataFiltered : List Mock_data.Munged_Data
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
  , currentTime : Time.Time
  }

type Msg
  = Mdl (Material.Msg Msg)
  | SelectTab Int
  | SelectActionTab Int
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
  | UpResults (List Mock_data.Munged_Data)
  | SetTime (Time.Time)

afterStartDate : String -> String -> List Mock_data.Munged_Data -> List Mock_data.Munged_Data
afterStartDate startDate endDate records =
  List.filter (\record -> ((Date.toTime(record.expiry_date) > (Date.toTime(Mock_data.convertToDate(startDate)))) && (Date.toTime(record.expiry_date) < (Date.toTime(Mock_data.convertToDate(endDate)))))) records

getCurrentTime : Cmd Msg
getCurrentTime =
  Task.perform (always (SetTime 0)) SetTime Time.now

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