{-# LANGUAGE DeriveGeneric #-}

module L2eth.Connext.Data.Void
  ( VoidRequest (..),
    VoidResponse (..),
  )
where

import L2eth.Connext.Import.External

data VoidRequest
  = VoidRequest {}
  deriving (Generic)

data VoidResponse
  = VoidResponse {}
  deriving (Generic)

instance QueryLike VoidRequest where
  toQuery = const []

instance ToJSON VoidRequest where
  toJSON = const $ object []

instance FromJSON VoidResponse where
  parseJSON _ = pure VoidResponse
