package IO
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.net.LocalConnection;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    import flash.text.TextField;
    
    public class CProtection extends MovieClip
    {
        
        public static var tfDebug:TextField;
        
        public static var mRoot:DisplayObject;
         
        
        public function CProtection()
        {
            super();
        }
        
        public static function isLOCAL() : Boolean
        {
            var _loc1_:* = null;
            _loc1_ = new LocalConnection().domain.toLowerCase();
            return _loc1_ == "localhost";
        }
        
        public static function NavigateToURL(param1:String, param2:String = "_blank") : void
        {
            var success:Boolean = false;
            var url:String = param1;
            var window:String = param2;
            navigateToURL(new URLRequest(url),"_BLANK");
        }
        
        public static function ShowDebugInfo() : void
        {
        }
        
        public static function isKONGREGATE() : Boolean
        {
            var _loc1_:* = null;
            _loc1_ = new LocalConnection().domain.toLowerCase();
            switch(_loc1_)
            {
                case "a.kongregate.com":
                case "chat.kongregate.com":
                case "www.kongregate.com":
                case "a.kongregatestage.com":
                case "chat.kongregatestage.com":
                case "www.kongregatestage.com":
                case "a.kongregatetrunk.com":
                case "chat.kongregatetrunk.com":
                case "www.kongregatetrunk.com":
                    return true;
                default:
                    return false;
            }
        }
        
        public static function isARMORGAMES() : Boolean
        {
            var _loc1_:* = null;
            _loc1_ = new LocalConnection().domain.toLowerCase();
            switch(_loc1_)
            {
                case "games.armorgames.com":
                case "armorgames.com":
                case "www.games.armorgames.com":
                case "www.armorgames.com":
                    return true;
                default:
                    return false;
            }
        }
        
        public static function get mSHOWAD() : Boolean
        {
            if(isANDKON())
            {
                return false;
            }
            if(isKONGREGATE())
            {
                return false;
            }
            if(isARMORGAMES())
            {
                return false;
            }
            if(isCMG())
            {
                return false;
            }
            if(false)
            {
                return false;
            }
            return true;
        }
        
        public static function isLICENSEE() : Boolean
        {
            var _loc1_:* = null;
            _loc1_ = new LocalConnection().domain.toLowerCase();
            return _loc1_ == "localhost" || _loc1_ == "crazymonkeygames.com" || _loc1_ == "www.crazymonkeygames.com" || _loc1_ == "boxhead.seantcooper.com" || _loc1_ == "www.boxhead.seantcooper.com" || _loc1_ == "www.games.seantcooper.com" || _loc1_ == "www.games.seantcooper.com";
        }
        
        public static function isCMG() : Boolean
        {
            var _loc1_:* = null;
            _loc1_ = new LocalConnection().domain.toLowerCase();
            return _loc1_ == "crazymonkeygames.com" || _loc1_ == "www.crazymonkeygames.com";
        }
        
        public static function isSTC() : Boolean
        {
            var _loc1_:* = null;
            _loc1_ = new LocalConnection().domain.toLowerCase();
            return _loc1_ == "boxhead.seantcooper.com" || _loc1_ == "www.boxhead.seantcooper.com" || _loc1_ == "www.games.seantcooper.com" || _loc1_ == "www.games.seantcooper.com";
        }
        
        public static function GetDomain() : String
        {
            return new LocalConnection().domain.toLowerCase();
        }
        
        public static function isANDKON() : Boolean
        {
            var _loc1_:* = null;
            _loc1_ = new LocalConnection().domain.toLowerCase();
            return _loc1_ == "andkon.com" || _loc1_ == "www.andkon.com";
        }
        
        public function get _CLASSID_() : String
        {
            return "CProtection";
        }
        
        public function Check(param1:DisplayObjectContainer) : void
        {
        }
    }
}
