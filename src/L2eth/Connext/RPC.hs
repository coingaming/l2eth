{-# LANGUAGE DuplicateRecordFields #-}
{-# LANGUAGE NamedFieldPuns #-}

module L2eth.Connext.RPC
  ( create,
    balance,
  )
where

import Data.ByteString.Lazy as BL (ByteString)
import Data.Text as T
import L2eth.Connext.Import
import Network.HTTP.Client
  ( RequestBody (RequestBodyLBS),
    Response (..),
    httpLbs,
    method,
    parseRequest,
    queryString,
    requestBody,
    requestHeaders,
    responseStatus,
  )
import Network.HTTP.Types.Method (StdMethod (..), renderStdMethod)
import Network.HTTP.Types.Status (ok200)
import Network.HTTP.Types.URI (Query, renderQuery)

data RpcArgs a
  = RpcArgs
      { rpcEnv :: ConnextEnv,
        rpcMethod :: StdMethod,
        rpcUrlPath :: String,
        --
        -- TODO : remove it if url query string is
        -- not used in Eclair API
        --
        rpcUrlQuery :: Query,
        rpcReqBody :: Maybe a
      }

rpc ::
  (ToJSON a, FromJSON b) =>
  RpcArgs a ->
  IO (Either (Response BL.ByteString) b)
rpc
  RpcArgs
    { rpcEnv,
      rpcMethod,
      rpcUrlPath,
      rpcUrlQuery,
      rpcReqBody
    } = do
    req0 <-
      parseRequest $
        coerce (connextRestApiClientUrl rpcEnv) <> rpcUrlPath
    let req1 =
          req0
            { method = renderStdMethod rpcMethod,
              queryString = renderQuery False rpcUrlQuery,
              requestHeaders = [("Content-Type", "application/json")]
            }
    let req2 =
          maybe
            req1
            (\b -> req1 {requestBody = RequestBodyLBS $ encode b})
            rpcReqBody
    res <- httpLbs req2 $ coerce $ connextNetworkManager rpcEnv
    return $
      if responseStatus res == ok200
        then first (const res) $ eitherDecode $ responseBody res
        else Left res

create :: ConnextEnv -> IO (Either (Response BL.ByteString) ChannelConfig)
create env =
  rpc $
    RpcArgs
      { rpcEnv = env,
        rpcMethod = POST,
        rpcUrlPath = "/create",
        rpcUrlQuery = [],
        rpcReqBody = Just VoidRequest
      }

balance ::
  ConnextEnv ->
  AssetId ->
  IO (Either (Response BL.ByteString) BalanceResponse)
balance env aid =
  rpc $
    RpcArgs
      { rpcEnv = env,
        rpcMethod = GET,
        rpcUrlPath = "/balance/" <> (T.unpack $ coerce aid),
        rpcUrlQuery = [],
        rpcReqBody = Just VoidRequest
      }
