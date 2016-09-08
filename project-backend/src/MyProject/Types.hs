module MyProject.Types where

import Data.IORef
import Web.Spock

data MySession = EmptySession
data MyAppState = DummyAppState (IORef Int)

type Application a = SpockM () MySession MyAppState a
type Action a = ActionCtxT () (WebStateM () MySession MyAppState) a
