package CMG_AS3
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.net.URLLoader;
    import flash.net.URLRequest;
    import flash.net.URLRequestMethod;
    import flash.net.URLVariables;
    
    public class ScoreSubmitter extends EventDispatcher
    {
        
        public static const RETURNCODE_SUCCESS = 1;
        
        public static var gameVersion:String = "";
        
        public static var gameValidationCode:String = "";
        
        public static const RETURNCODE_REJECTED = 2;
        
        public static const RETURNCODE_INTERNALERROR = 5;
        
        public static const URL_SUBMITSCORE = "http://scores.crazymonkeygames.com/hs/regscores2.php";
        
        public static const URL_UPDATEGAME = "http://scores.crazymonkeygames.com/hs/pleaseupdate.php";
        
        public static var gameId:uint = 0;
        
        public static const SCORE_RESPONSE:String = "score_response";
        
        public static const RETURNCODE_WORKING = 0;
        
        public static const RETURNCODE_WRONGVERSION = 3;
        
        public static const URL_VIEWSCORES = "http://scores.crazymonkeygames.com/hs/listscores.php";
        
        public static const RETURNCODE_NETWORKERROR = 4;
         
        
        private var m_UrlLoader:URLLoader = null;
        
        public function ScoreSubmitter()
        {
            m_UrlLoader = null;
            super();
        }
        
        public static function loadHighScorePage() : void
        {
            Utilities.goToUrl(URL_VIEWSCORES + "?id=" + gameId);
        }
        
        public static function loadUpdatePage() : *
        {
            Utilities.goToUrl(URL_VIEWSCORES + "?id=" + gameId);
        }
        
        private function onIoError(param1:Event) : *
        {
            dispatchEvent(new ServerResponseEvent(SCORE_RESPONSE,RETURNCODE_NETWORKERROR));
        }
        
        public function submitScore(param1:String, param2:Number, param3:String = null) : void
        {
            var _loc4_:* = undefined;
            var _loc5_:* = null;
            param1 = Utilities.trim(param1);
            gameVersion = Utilities.trim(gameVersion);
            if(param3 == null)
            {
                param3 = "";
            }
            else
            {
                param3 = Utilities.trim(param3);
            }
            gameValidationCode = Utilities.trim(gameValidationCode);
            if(gameId < 1 || gameVersion == "" || gameValidationCode == "")
            {
                dispatchEvent(new ServerResponseEvent(SCORE_RESPONSE,RETURNCODE_REJECTED));
                return;
            }
            dispatchEvent(new ServerResponseEvent(SCORE_RESPONSE,RETURNCODE_WORKING));
            (_loc4_ = new URLVariables()).name = param1;
            _loc4_.score = param2;
            _loc4_.gameId = gameId;
            _loc4_.gameVersion = gameVersion;
            _loc4_.special = param3;
            _loc4_.key = MD5.encrypt(param1 + "|" + param2 + "|" + gameId + "|" + param3 + "|" + gameValidationCode);
            (_loc5_ = new URLRequest(URL_SUBMITSCORE)).method = URLRequestMethod.POST;
            _loc5_.data = _loc4_;
            m_UrlLoader = new URLLoader();
            m_UrlLoader.addEventListener("complete",onComplete);
            m_UrlLoader.addEventListener("ioError",onIoError);
            m_UrlLoader.load(_loc5_);
        }
        
        private function onComplete(param1:Event) : void
        {
            var _loc2_:* = null;
            var _loc3_:* = undefined;
            _loc2_ = new URLVariables(m_UrlLoader.data.replace("&",""));
            _loc3_ = Utilities.trim(_loc2_.ok);
            if(_loc3_ == 1)
            {
                dispatchEvent(new ServerResponseEvent(SCORE_RESPONSE,RETURNCODE_SUCCESS));
            }
            else if(_loc3_ == 0)
            {
                dispatchEvent(new ServerResponseEvent(SCORE_RESPONSE,RETURNCODE_REJECTED));
            }
            else if(_loc3_ == 2)
            {
                dispatchEvent(new ServerResponseEvent(SCORE_RESPONSE,RETURNCODE_WRONGVERSION));
            }
            else
            {
                dispatchEvent(new ServerResponseEvent(SCORE_RESPONSE,RETURNCODE_INTERNALERROR));
            }
        }
    }
}
