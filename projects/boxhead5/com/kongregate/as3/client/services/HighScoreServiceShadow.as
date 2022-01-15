package com.kongregate.as3.client.services
{
    public class HighScoreServiceShadow extends AbstractShadowService implements IHighScoreServices
    {
         
        
        private var mode:String;
        
        public function HighScoreServiceShadow()
        {
            super();
            mode = "";
        }
        
        public function submit(param1:Number, param2:String = null) : void
        {
            alert("IHighScoreServices","submit",arguments);
        }
        
        public function connect() : Boolean
        {
            alert("IKongregateServices","connect");
            return true;
        }
        
        public function requestList(param1:Function) : void
        {
            alert("IHighScoreServices","requestList","","[Mode: " + mode + "]");
            param1({"success":false});
        }
        
        public function setMode(param1:String) : void
        {
            alert("IHighScoreServices","setMode",arguments);
            this.mode = param1;
        }
    }
}
