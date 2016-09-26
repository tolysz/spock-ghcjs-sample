
module MyProject.Api.User where

import Data.Int
import Web.Spock.Api
import qualified Data.Text as T

data LoginReq
   = LoginReq
   { lr_username :: !T.Text
   , lr_password :: !T.Text
   } deriving (Show, Eq, Generic, NFData, Typeable, ToJSON, FromJSON)

data LoginResp
   = LoginOkay !User
   | LoginFailed
   deriving (Show, Eq, Generic, NFData, Typeable, ToJSON, FromJSON)

data User
   = User
   { u_id :: !Int64
   , u_name :: !T.Text
   , u_email :: !T.Text
   , u_isSuperuser :: !Bool
   } deriving (Show, Eq, Generic, NFData, Typeable, ToJSON, FromJSON)

loginUser :: Endpoint '[] ('Just LoginReq) LoginResp
loginUser = MethodPost Proxy ("api" <//> "user" <//> "auth")

loginUser1 :: Endpoint '[] ('Just LoginReq) LoginResp
loginUser1 = MethodPost Proxy ("api" <//> "user" <//> "auth")
