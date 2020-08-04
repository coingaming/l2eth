module L2eth.Data.Type (LogFormat(..)) where

import L2eth.Import.External

data LogFormat
  = Bracket
  | JSON
  deriving (Read)
