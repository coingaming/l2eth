module Connext.RPCSpec (spec) where

import Connext.TestEnv
import Connext.TestOrphan ()
import L2eth.Connext
import L2eth.Connext.Import
import Test.Hspec

spec :: Spec
spec = do
  describe "create" $ do
    it "create succeeds" $ do
      env <- newMerchantEnv
      res <- create env
      res `shouldSatisfy` isRight
