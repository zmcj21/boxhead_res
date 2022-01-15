package com.kongregate.as3.client.events
{
    import flash.events.Event;
    
    public class KongregateEvent extends Event
    {
        
        public static const COMPLETE:String = "component_api_available";
         
        
        public function KongregateEvent(param1:String)
        {
            super(param1);
        }
    }
}
