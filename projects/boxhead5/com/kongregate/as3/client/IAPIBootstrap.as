package com.kongregate.as3.client
{
    import flash.display.Stage;
    import flash.events.Event;
    
    public interface IAPIBootstrap
    {
         
        
        function init(param1:Event = null, param2:Stage = null) : void;
        
        function hideLog() : void;
        
        function showLog(param1:int = 0) : void;
    }
}
