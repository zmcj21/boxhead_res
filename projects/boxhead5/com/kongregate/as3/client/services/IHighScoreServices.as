package com.kongregate.as3.client.services
{
    public interface IHighScoreServices
    {
         
        
        function setMode(param1:String) : void;
        
        function submit(param1:Number, param2:String = null) : void;
        
        function requestList(param1:Function) : void;
    }
}
