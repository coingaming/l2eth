{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module L2eth.Connext.Data.Type
  ( ConnextNodeUrl (..),
    ConnextNetworkManager (..),
    ConnextEnv (..),
    EthAccount (..),
    ChannelConfig (..),
    newConnextEnv,
  )
where

import L2eth.Connext.Import.External
import Network.Connection (TLSSettings (..))
import Network.HTTP.Client (Manager, newManager)
import Network.HTTP.Client.TLS (mkManagerSettings)
import Network.TLS (defaultParamsClient)

newtype ConnextNodeUrl = ConnextNodeUrl String
  deriving newtype (FromJSON)

newtype ConnextNetworkManager = ConnextNetworkManager Manager

data ConnextEnv
  = ConnextEnv
      { connextNodeUrl :: ConnextNodeUrl,
        connextNetworkManager :: ConnextNetworkManager
      }

newtype EthAccount = EthAccount Text
  deriving newtype (ToJSON, FromJSON)

--
-- TODO : proper field types
--
data ChannelConfig
  = ChannelConfig
      { signerAddress :: Text,
        multisigAddress :: Text,
        nodeUrl :: ConnextNodeUrl,
        userIdentifier :: Text
      }
  deriving (Generic)

instance FromJSON ChannelConfig

newConnextEnv :: ConnextNodeUrl -> IO ConnextEnv
newConnextEnv u = do
  manager <-
    newManager $
      mkManagerSettings
        (TLSSettings $ defaultParamsClient "" "")
        Nothing
  return $
    ConnextEnv
      { connextNodeUrl = u,
        connextNetworkManager = ConnextNetworkManager manager
      }
