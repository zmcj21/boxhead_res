package com.kongregate.as3.client.services
{
    public class KongregateServiceShadow extends AbstractShadowService implements IKongregateServices
    {
         
        
        public function KongregateServiceShadow()
        {
            super();
        }
        
        public function getName() : String
        {
            alert("IKongregateServices","getName");
            return "Guest";
        }
        
        public function connect(param1:Number = -1) : Boolean
        {
            alert("IKongregateServices","connect",arguments);
            return true;
        }
        
        public function getPlayerInfo(param1:Function) : void
        {
            alert("IKongregateServices","getPlayerInfo");
            param1(new Object());
        }
    }
}
