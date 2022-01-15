package com.kongregate.as3.client.services
{
    import flash.events.IEventDispatcher;
    
    public interface IKongregateServices extends IEventDispatcher
    {
         
        
        function getPlayerInfo(param1:Function) : void;
        
        function connect(param1:Number = -1) : Boolean;
    }
}
