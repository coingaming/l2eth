{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module L2eth.Connext.Data.Type
  ( ConnextRestApiClientUrl (..),
    ConnextNetworkManager (..),
    ConnextEnv (..),
    EthAccount (..),
    AssetId (..),
    PublicIdentifier (..),
    ChannelConfig (..),
    BalanceResponse (..),
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

newtype AssetId = AssetId Text

newtype PublicIdentifier = PublicIdentifier Text
  deriving newtype (ToJSON, FromJSON)

--
-- TODO : proper newtypes
--
data ChannelConfig
  = ChannelConfig
      { signerAddress :: Address,
        multisigAddress :: Text,
        nodeUrl :: Text,
        userIdentifier :: PublicIdentifier
      }
  deriving (Generic)

instance FromJSON ChannelConfig

data BalanceResponse
  = BalanceResponse
      { freeBalanceOffChain :: Text,
        freeBalanceOnChain :: Text
      }
  deriving (Generic)

instance FromJSON BalanceResponse

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
