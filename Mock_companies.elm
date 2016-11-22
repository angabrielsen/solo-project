module Mock_companies exposing (..)

type alias Company =
  { company : String
  , selectedComp : Bool
  }

companies : List Company
companies =
  [ Company "O.C. Tanner - 001" False
  , Company "Bank of America - 002" False
  , Company "T.D. Bank - 003" False
  , Company "Dow Chemical - 004" False
  ]