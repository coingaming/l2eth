{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module L2eth.Connext.Data.Type
  ( ConnextRestApiClientUrl (..),
    ConnextNetworkManager (..),
    ConnextEnv (..),
    EthAccount (..),
    ChannelConfig (..),
    newConnextEnv,
  )
where

import Data.Solidity.Prim.Address (Address)
import L2eth.Connext.Import.External
import Network.Connection (TLSSettings (..))
import Network.HTTP.Client (Manager, newManager)
import Network.HTTP.Client.TLS (mkManagerSettings)
import Network.TLS (defaultParamsClient)

newtype ConnextRestApiClientUrl = ConnextRestApiClientUrl String

newtype ConnextNetworkManager = ConnextNetworkManager Manager

data ConnextEnv
  = ConnextEnv
      { connextRestApiClientUrl :: ConnextRestApiClientUrl,
        connextNetworkManager :: ConnextNetworkManager
      }

newtype EthAccount = EthAccount Text
  deriving newtype (ToJSON, FromJSON)

--
-- TODO : proper newtypes
--
data ChannelConfig
  = ChannelConfig
      { signerAddress :: Address,
        multisigAddress :: Text,
        nodeUrl :: Text,
        userIdentifier :: Text
      }
  deriving (Generic)

instance FromJSON ChannelConfig

newConnextEnv :: ConnextRestApiClientUrl -> IO ConnextEnv
newConnextEnv u = do
  manager <-
    newManager $
      mkManagerSettings
        (TLSSettings $ defaultParamsClient "" "")
        Nothing
  return $
    ConnextEnv
      { connextRestApiClientUrl = u,
        connextNetworkManager = ConnextNetworkManager manager
      }
