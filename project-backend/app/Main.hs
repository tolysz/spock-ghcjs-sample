{-# LANGUAGE OverloadedStrings #-}
module Main where

import Web.Spock
import Web.Spock.Config

import Control.Monad.Trans
import Data.Monoid
import Data.IORef
import qualified Data.Text as T
import qualified MyProject.Api.User as A
import Network.Wai.Middleware.Static
import Network.Wai.Middleware.Rewrite

import MyProject.Types
import MyProject.Api.Server.User

main :: IO ()
main = do
  ref <- newIORef 0
  spockCfg <- defaultSpockCfg EmptySession PCNoDatabase (DummyAppState ref)
  runSpock 8080 (spock spockCfg app)


app :: Application ()
app = do
  get ("hello" <//> var) $ \name ->
    do (DummyAppState ref) <- getState
       visitorNumber <- liftIO $ atomicModifyIORef' ref $ \i -> (i+1, i+1)
       text ("Hello " <> name <> ", you are visitor number " <> T.pack (show visitorNumber))
  api
  get ("/") $ redirect "index.html"
  middleware (staticPolicy (noDots >-> addBase "static"))

