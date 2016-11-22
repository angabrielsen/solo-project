module Pts_expiry.Data exposing (..)

import Material
import Material.Color as Color

import Set exposing (Set)

import Table

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

type alias Model =
  { mdl : Material.Model
  , selected : Set Int
  , selectedTab : Int
  , data : List Mock_data.Munged_Data
  , comp : List Mock_data.Comp
  , companies : List Mock_companies.Company
  , tableState : Table.State
  , query : String
  }

type Msg
  = Mdl (Material.Msg Msg)
  | SelectTab Int
  | Toggle Int
  | ToggleAll
  | ToggleComp String
  | SetQuery String
  | SetTableState Table.State

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