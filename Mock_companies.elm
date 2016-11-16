module Mock_companies exposing (..)

type alias Mock_Comp =
  { comp_name : String }

mock_comp : List Mock_Comp
mock_comp =
  [ { comp_name = "O.C. Tanner" }
  , { comp_name = "Bank of America" }
  , { comp_name = "T.D. Bank" }
  , { comp_name = "Dow Chemical" }
  ]

type alias Company =
  { company : String
  , stp : Int
  }

companies : List Company
companies =
  [ Company "O.C. Tanner" 001
  , Company "Bank of America" 002
  , Company "T.D. Bank" 003
  , Company "Dow Chemical" 004
  ]