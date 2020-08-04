module L2eth.Class
  ( EnvM (..),
  )
where

import L2eth.Data.Env (Env (..))
import L2eth.Import.External

class MonadIO m => EnvM m where
  getEnv :: m Env
