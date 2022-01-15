package com.kongregate.as3.client.services
{
    import flash.events.EventDispatcher;
    
    public class AbstractShadowService extends EventDispatcher
    {
         
        
        public function AbstractShadowService()
        {
            super();
        }
        
        protected function alert(param1:String, param2:String, param3:* = "", param4:String = "") : void
        {
            trace("Kongregate API: " + param1 + "." + param2 + "(" + param3 + ") " + param4);
        }
    }
}
