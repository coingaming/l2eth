module Connext.TestEnv
  ( newMerchantEnv,
    newCustomerEnv,
    setupEnv,
    liftRpcResult,
  )
where

import Data.ByteString.Lazy as BL
import L2eth.Connext
import L2eth.Connext.Import
import Network.Ethereum
import qualified Network.Ethereum.Api.Eth as Eth
import Network.Ethereum.Api.Types
import Network.HTTP.Client (Response (..))
import Network.Web3

--import qualified Prelude

minBalance :: Quantity
minBalance = 1000000

newMerchantEnv :: IO ConnextEnv
newMerchantEnv =
  newConnextEnv $
    ConnextRestApiClientUrl "http://localhost:5040"

newCustomerEnv :: IO ConnextEnv
newCustomerEnv =
  newConnextEnv $
    ConnextRestApiClientUrl "http://localhost:5041"

setupEnv :: IO ()
setupEnv = do
  mEnv <- newMerchantEnv
  mAddr <- signerAddress <$> (create mEnv >>= liftRpcResult)
  res <- runWeb3 $ do
    mBalance <- Eth.getBalance mAddr Latest
    when (mBalance < minBalance) $ do
      let donation = fromWei minBalance :: Ether
      withAccount () $ do
        _ <- withParam (value .~ donation) $ do
          withParam (to .~ mAddr) $ send ()
        return ()
    return mBalance
  print res
  return ()

liftRpcResult :: Either (Response BL.ByteString) a -> IO a
liftRpcResult = \case
  Right x -> return x
  Left x -> fail $ "liftRpcResult failed " <> show x
