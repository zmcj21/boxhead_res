package com.kongregate.as3.client.services
{
    public class StatServiceShadow extends AbstractShadowService implements IStatServices
    {
         
        
        public function StatServiceShadow()
        {
            super();
        }
        
        public function submitArray(param1:Array) : void
        {
            alert("IStatServices","submitArray",arguments);
        }
        
        public function submit(param1:String, param2:Number) : void
        {
            alert("IStatServices","submitStat",arguments);
        }
    }
}
