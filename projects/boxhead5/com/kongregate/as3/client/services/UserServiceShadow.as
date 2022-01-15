package com.kongregate.as3.client.services
{
    public class UserServiceShadow extends AbstractShadowService implements IUserServices
    {
         
        
        public function UserServiceShadow()
        {
            super();
        }
        
        public function getName() : String
        {
            alert("UserService","getName");
            return "Guest";
        }
        
        public function getPlayerInfo(param1:Function) : void
        {
            alert("UserService","getPlayerInfo");
            param1({
                "isGuest":true,
                "name":"Guest",
                "points":0,
                "level":0,
                "isMode":false,
                "isAdmin":false,
                "isDeveloper":false,
                "avatarPath":"",
                "chatAvatarPath":""
            });
        }
    }
}
