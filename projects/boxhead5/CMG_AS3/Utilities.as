package CMG_AS3
{
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.system.Capabilities;
    
    public class Utilities
    {
         
        
        public function Utilities()
        {
            super();
        }
        
        public static function trim(param1:String) : String
        {
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            _loc2_ = 0;
            while(param1.charCodeAt(_loc2_) < 33)
            {
                _loc2_++;
            }
            _loc3_ = param1.length - 1;
            while(param1.charCodeAt(_loc3_) < 33)
            {
                _loc3_--;
            }
            return param1.substring(_loc2_,_loc3_ + 1);
        }
        
        public static function goToUrl(param1:String) : void
        {
            var success:Boolean = false;
            var url:String = param1;
            success = false;
            if(false)
            {
                try
                {
                    ExternalInterface.call("window.open",url,"win","");
                    success = true;
                }
                catch(error:Error)
                {
                }
                catch(error:SecurityError)
                {
                }
            }
            if(success != true)
            {
                navigateToURL(new URLRequest(url),"_BLANK");
            }
        }
    }
}
