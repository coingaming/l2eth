{-# LANGUAGE StandaloneDeriving #-}
{-# OPTIONS_GHC -fno-warn-orphans #-}

module Connext.TestOrphan
  (
  )
where

import L2eth.Connext.Import

deriving instance Show ChannelConfig

deriving instance Show PublicIdentifier

deriving instance Show BalanceResponse
