module Lib
  ( someFunc,
  )
where

import L2eth.Import

someFunc :: IO ()
someFunc = putStrLn ("someFunc" :: Text)
