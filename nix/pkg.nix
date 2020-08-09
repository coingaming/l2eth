{ mkDerivation, aeson, async, base, base64-bytestring, bytestring
, chronos, concur-core, concur-replica, conduit, connection
, containers, envparse, esqueleto, extra, file-embed, hpack, hspec
, hspec-wai, http-client, http-client-tls, http-conduit, http-types
, katip, lens, microlens, monad-logger, persistent
, persistent-migration, persistent-postgresql, persistent-template
, replica, resource-pool, retry, stdenv, stm, template-haskell
, text, time, tls, unbounded-delays, universum, unliftio, wai
, wai-middleware-static-embedded, warp, web3, websockets
}:
mkDerivation {
  pname = "l2eth";
  version = "0.1.0.0";
  src = ./..;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    aeson async base base64-bytestring bytestring chronos concur-core
    concur-replica conduit connection containers envparse esqueleto
    extra file-embed hspec hspec-wai http-client http-client-tls
    http-conduit http-types katip lens microlens monad-logger
    persistent persistent-migration persistent-postgresql
    persistent-template replica resource-pool retry stm
    template-haskell text time tls unbounded-delays universum unliftio
    wai wai-middleware-static-embedded warp web3 websockets
  ];
  libraryToolDepends = [ hpack ];
  executableHaskellDepends = [
    aeson async base base64-bytestring bytestring chronos concur-core
    concur-replica conduit connection containers envparse esqueleto
    extra file-embed http-client http-client-tls http-conduit
    http-types katip lens microlens monad-logger persistent
    persistent-migration persistent-postgresql persistent-template
    replica resource-pool retry stm template-haskell text time tls
    unbounded-delays universum unliftio wai
    wai-middleware-static-embedded warp web3 websockets
  ];
  testHaskellDepends = [
    aeson async base base64-bytestring bytestring chronos concur-core
    concur-replica conduit connection containers envparse esqueleto
    extra file-embed hspec hspec-wai http-client http-client-tls
    http-conduit http-types katip lens microlens monad-logger
    persistent persistent-migration persistent-postgresql
    persistent-template replica resource-pool retry stm
    template-haskell text time tls unbounded-delays universum unliftio
    wai wai-middleware-static-embedded warp web3 websockets
  ];
  prePatch = "hpack";
  homepage = "https://github.com/githubuser/l2eth#readme";
  license = stdenv.lib.licenses.bsd3;
}
