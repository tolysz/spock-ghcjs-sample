
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

type SessionId = T.Text

main = do
  Just res <- callEndpoint loginUser (LoginReq "alex" "alexcool")
  putStrLn ("Login result was: " ++ show res)

  runWebGUI $ \ webView -> do
    enableInspector webView
    Just doc <- webViewGetDomDocument webView
    Just body <- getBody doc
    setInnerHTML body (Just ("<h1>Hello World</h1>" :: T.Text))
    on doc click $ do
        (x, y) <- mouseClientXY
        Just newParagraph <- createElement doc (Just ("p":: T.Text))
        text <- createTextNode doc $ "Click " ++ show (x, y)
        appendChild newParagraph text
        appendChild body (Just newParagraph)
        return ()
    return ()
