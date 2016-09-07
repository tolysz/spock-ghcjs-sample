
module MyProject.Api.Server.User
    ( api )
where


import MyProject.Types
import qualified MyProject.Api.User as A

import Web.Spock
import Web.Spock.Core
import Web.Spock.Action
import Web.Spock.Api.Server
-- import Network.Wai (Application(..))


api :: Application ()
api = defEndpoint A.loginUser loginHandler

-- loginHandler :: A.LoginReq -> Action A.LoginResp
loginHandler r = pure A.LoginFailed
