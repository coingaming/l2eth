{-# LANGUAGE BangPatterns #-}

module L2eth.Data.Env
  ( Env (..),
    RawConfig (..),
    rawConfig,
    newEnv
  )
where

import L2eth.Data.Type
import L2eth.Import.External
import Env ((<=<), auto, header, help, keep, nonempty, parse, str, var)

data Env
  = Env
      { -- general
        envEndpointPort :: Int,
        -- logging
        envKatipNS :: Namespace,
        envKatipCTX :: LogContexts,
        envKatipLE :: LogEnv
      }

data RawConfig
  = RawConfig
      { -- general
        rawConfigEndpointPort :: Int,
        -- katip
        rawConfigLogEnv :: Text,
        rawConfigLogFormat :: LogFormat,
        rawConfigLogVerbosity :: Verbosity
      }

rawConfig :: IO RawConfig
rawConfig =
  parse (header "L2eth config") $
    RawConfig
      <$> var (auto <=< nonempty) "L2ETH_ENDPOINT_PORT" op
      <*> var (str <=< nonempty) "L2ETH_LOG_ENV" op
      <*> var (auto <=< nonempty) "L2ETH_LOG_FORMAT" op
      <*> var (auto <=< nonempty) "L2ETH_LOG_VERBOSITY" op
    where
      op = keep <> help ""

newEnv :: RawConfig -> KatipContextT IO Env
newEnv !rc = do
  le <- getLogEnv
  ctx <- getKatipContext
  ns <- getKatipNamespace
  return $
    Env
      { -- general
        envEndpointPort = rawConfigEndpointPort rc,
        -- logging
        envKatipLE = le,
        envKatipCTX = ctx,
        envKatipNS = ns
      }
