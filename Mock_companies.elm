module Mock_companies exposing (..)

type alias Company =
  { company : String
  }

companies : List Company
companies =
  [ Company "O.C. Tanner - 001"
  , Company "Bank of America - 002"
  , Company "T.D. Bank - 003"
  , Company "Dow Chemical - 004"
  ]