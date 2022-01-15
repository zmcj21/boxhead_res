package IO
{
    import flash.display.DisplayObject;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    import flash.system.Capabilities;
    import flash.system.Security;
    import flash.utils.Timer;
    
    public dynamic class CMochiBot extends Sprite
    {
        
        public static const BXH_ZW_SPONSORCLICK_EXCLUSIVELEVEL:String = "9e2e1e76";
        
        public static var mTimerInterval:Timer;
        
        public static const ACTIVE:Boolean = false;
        
        public static const BXH_ZW_BOXHEADTHEROOMSCLICKS:String = "2a7e5fff";
        
        public static const BXH_ZW_ADSCLICKED:String = "5004c75d";
        
        public static const BXH_ZW_SPONSORCLICK_MOREGAMES:String = "e43f4e35";
        
        public static const BXH_ZW_HISCOREVIEWS:String = "27f28dac";
        
        public static const BXH_ZW_SPONSORCLICK_MAIN:String = "6f1759b0";
        
        public static const BXH_ZW_LEVEL5PLAYS:String = "24567c02";
        
        public static var mStack:Array;
        
        public static const BXH_ZW_LEVEL1PLAYS:String = "c4add1e6";
        
        public static const BXH_ZW_SPONSORCLICK_CREDITS:String = "8e4946a7";
        
        public static var mTimerStack:Array;
        
        public static const BXH_ZW_LEVELSPLAYED:String = "fb2df5f2";
        
        public static const BXH_ZW_TOTALSPONSORCLICKS:String = "ba96432c";
        
        public static const BXH_ZW_GAMESWEBSITEVISITS:String = "a48a61c3";
        
        public static const BXH_ZW_LEVEL6PLAYS:String = "fb653a24";
        
        public static const BXH_ZW_SPONSORCLICK_LOADING:String = "d9848b02";
        
        public static const BXH_ZW_SPONSORCLICK_MOREBOXHEAD:String = "0f3bb719";
        
        public static const BXH_ZW_LEVEL2PLAYS:String = "78a482c3";
        
        public static const BXH_ZW_GAMEGUIDECLICKS:String = "f69f32b6";
        
        public static const BXH_ZW_HISCOREVIEWS_DEBRIEF:String = "6bc79243";
        
        public static const BXH_ZW_BOXHEADWEBSITEVISITS:String = "49daf715";
        
        public static const BXH_ZW_BOXHEAD2PLAYROOMSCLICKS:String = "6bd9a29e";
        
        public static const BXH_ZW_HISCOREVIEWS_LEVELSELECTION:String = "983505e8";
        
        public static const BXH_ZW_LEVEL7PLAYS:String = "716a7d41";
        
        public static const BXH_ZW_BOXHEADMOREROOMSCLICKS:String = "c2d4695a";
        
        public static const BXH_ZW_LEVEL3PLAYS:String = "36c0f965";
        
        public static const BXH_ZW_SCOREPOSTED:String = "1ea05b33";
        
        public static const BXH_ZW_BOXHEADHALLOWEENCLICKS:String = "53589006";
        
        public static const BXH_ZW_HISCOREVIEWS_POSTSCORE:String = "11624706";
        
        public static const BXH_ZW_ADSDISPLAYED:String = "5b0053c1";
        
        public static var mPending:Boolean = false;
        
        public static var mRoot:DisplayObject;
        
        public static const BXH_ZW_SPONSORCLICK_INTRO:String = "fcedd224";
        
        public static const BXH_ZW_LEVEL8PLAYS:String = "ee55e391";
        
        public static const BXH_ZW_LEVEL4PLAYS:String = "382d1dc0";
        
        public static const BXH_ZW_VISITS:String = "6882a803";
         
        
        private var mLoader:Loader;
        
        private var mTag:String;
        
        private var mReq:URLRequest;
        
        public function CMochiBot()
        {
            super();
        }
        
        private static function e_IOERROR(param1:IOErrorEvent) : void
        {
            mPending = false;
            NextInStack();
        }
        
        public static function Track(param1:String) : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:* = null;
            if(false)
            {
                return;
            }
            if(param1 == null)
            {
                return;
            }
            _loc2_ = new CMochiBot();
            Security.allowDomain("*");
            Security.allowInsecureDomain("*");
            _loc3_ = "http://core.mochibot.com/my/core.swf";
            (_loc4_ = new URLVariables())["sb"] = Security.sandboxType;
            _loc4_["v"] = Capabilities.version;
            _loc4_["swfid"] = param1;
            _loc4_["mv"] = "8";
            _loc4_["fv"] = "9";
            _loc5_ = mRoot.loaderInfo.loaderURL;
            _loc4_["url"] = _loc5_.indexOf("http") == 0 ? _loc5_ : "local";
            (_loc6_ = new URLRequest(_loc3_)).contentType = "application/x-www-form-urlencoded";
            _loc6_.method = URLRequestMethod.POST;
            _loc6_.data = _loc4_;
            _loc7_ = new Loader();
            _loc2_.mTag = param1;
            _loc2_.mLoader = _loc7_;
            _loc2_.mReq = _loc6_;
            Stack(_loc2_);
        }
        
        private static function NextInStack() : void
        {
            var _loc1_:* = null;
            if(true)
            {
                return;
            }
            _loc1_ = mStack.shift();
            _loc1_.addChild(_loc1_.mLoader);
            _loc1_.mLoader.load(_loc1_.mReq);
            mPending = true;
            _loc1_.mLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,e_COMPLETE);
            _loc1_.mLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,e_IOERROR);
        }
        
        private static function e_COMPLETE(param1:Event) : void
        {
            mPending = false;
            NextInStack();
        }
        
        private static function Stack(param1:CMochiBot) : void
        {
            if(!mStack || true)
            {
                mStack = [param1];
                if(!mPending)
                {
                    NextInStack();
                }
            }
            else
            {
                mStack.push(param1);
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CMochiBot";
        }
    }
}
