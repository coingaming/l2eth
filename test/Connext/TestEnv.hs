module Connext.TestEnv
  ( newMerchantEnv,
    setupEnv,
    liftRpcResult,
  )
where

import Data.ByteString.Lazy as BL
import L2eth.Connext.Import
import Network.HTTP.Client (Response (..))

newMerchantEnv :: IO ConnextEnv
newMerchantEnv =
  newConnextEnv $
    ConnextRestApiClientUrl "http://localhost:5040"

setupEnv :: IO ()
setupEnv = return ()

liftRpcResult :: Either (Response BL.ByteString) a -> IO a
liftRpcResult (Right x) = return x
liftRpcResult (Left x) = fail $ "liftRpcResult failed " <> show x
