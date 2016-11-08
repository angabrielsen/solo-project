module Pts_expiry.Data exposing (..)

import Material
import Material.Color as Color

import Set exposing (Set)

import Mock_data

type alias Model =
  { mdl : Material.Model
  , selected : Set Int
  , selectedTab : Int
  , data : List Mock_data.Munged_Data
  , primary : Color.Hue
  , accent : Color.Hue
  }

type Msg
  = Mdl (Material.Msg Msg)
  | SelectTab Int
  | Toggle Int
  | ToggleAll

toggle : comparable -> Set comparable -> Set comparable
toggle x set =
  if Set.member x set then
    Set.remove x set
  else
    Set.insert x set

allSelected : Model -> Bool
allSelected model =
  Set.size model.selected == List.length model.data