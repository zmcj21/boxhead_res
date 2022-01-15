package CMG_AS3
{
    import flash.events.Event;
    
    public class ServerResponseEvent extends Event
    {
         
        
        public var returnCode:uint;
        
        public function ServerResponseEvent(param1:String, param2:uint)
        {
            super(param1,false,false);
            returnCode = param2;
        }
    }
}
