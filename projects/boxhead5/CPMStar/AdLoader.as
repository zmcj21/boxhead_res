package CPMStar
{
    import IO.CMochiBot;
    import flash.display.DisplayObjectContainer;
    import flash.display.Loader;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.system.Security;
    
    public class AdLoader
    {
        
        private static var cpmstarLoader:Loader;
        
        private static var mParent:DisplayObjectContainer;
        
        private static var mRetries:int = 5;
         
        
        public function AdLoader()
        {
            super();
        }
        
        public static function LoadAd(param1:DisplayObjectContainer = null) : void
        {
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            var _loc4_:* = null;
            mParent = !!param1 ? param1 : mParent;
            _loc2_ = 1051;
            _loc3_ = 1;
            Security.allowDomain("server.cpmstar.com");
            _loc4_ = "http://server.cpmstar.com/adviewas3.swf";
            cpmstarLoader = new Loader();
            cpmstarLoader.load(new URLRequest(_loc4_ + "?poolid=" + _loc2_ + "&subpoolid=" + _loc3_));
            cpmstarLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,e_COMPLETE);
            cpmstarLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,e_IOERROR);
        }
        
        public static function e_COMPLETE(param1:Event) : void
        {
            mParent.addChild(cpmstarLoader);
            CMochiBot.Track(CMochiBot.BXH_ZW_ADSDISPLAYED);
        }
        
        public static function e_IOERROR(param1:IOErrorEvent) : void
        {
            if(--mRetries > 0)
            {
                LoadAd();
            }
        }
    }
}
