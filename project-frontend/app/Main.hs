{-# Language CPP,QuasiQuotes #-}

module Main (
    main
) where

import MyProject.Api.User
import Web.Spock.Api.Client
import qualified Data.Text as T

import Control.Applicative ((<$>))
import GHCJS.DOM
       (enableInspector, webViewGetDomDocument, runWebGUI)
import GHCJS.DOM.Document (getBody, createElement, createTextNode, click)
import GHCJS.DOM.Element (setInnerHTML)
import GHCJS.DOM.Node (appendChild)
import GHCJS.DOM.EventM (on, mouseClientXY)
import Data.String.QM

type SessionId = T.Text

main = do
  compileInfo
  res <- callEndpoint loginUser (LoginReq "alex" "alexcool")
  putStrLn ("Login result was: " ++ show res)

  runWebGUI $ \ webView -> do
    enableInspector webView
    Just doc <- webViewGetDomDocument webView
    Just body <- getBody doc
    setInnerHTML body (Just ("<h1>Hello World</h1>" :: T.Text))
    addP doc body ("Login result was: " ++ show res)
    addPre doc body ([qq|
  ghc: VERSION_ghc
  ghc: VERSION_ghcjs
  base: VERSION_base
  ghcjs-base: VERSION_ghcjs_base
  ghcjs-dom: VERSION_ghcjs_dom
  aeson: VERSION_aeson
  mtl: VERSION_mtl
  |] :: T.Text)

    on doc click $ do
        (x, y) <- mouseClientXY
        addP doc body $ "Click " ++ show (x, y)
        return ()
    return ()

addP doc body txt = do
        Just newParagraph <- createElement doc (Just ("p":: T.Text))
        text <- createTextNode doc txt
        appendChild newParagraph text
        appendChild body (Just newParagraph)

addPre doc body txt = do
        Just newParagraph <- createElement doc (Just ("pre":: T.Text))
        text <- createTextNode doc txt
        appendChild newParagraph text
        appendChild body (Just newParagraph)


compileInfo = do
   putStrLn [qq|
            __DATE__
            __TIME__
            __GLASGOW_HASKELL__
            base: VERSION_base
            ghcjs-base: VERSION_ghcjs_base
            ghcjs-dom: VERSION_ghcjs_dom
            aeson: VERSION_aeson
            mtl: VERSION_mtl
   |]
