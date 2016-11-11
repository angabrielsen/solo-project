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