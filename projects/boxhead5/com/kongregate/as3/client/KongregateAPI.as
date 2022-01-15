package com.kongregate.as3.client
{
    import com.kongregate.as3.client.events.KongregateEvent;
    import com.kongregate.as3.client.services.HighScoreServiceShadow;
    import com.kongregate.as3.client.services.IHighScoreServices;
    import com.kongregate.as3.client.services.IKongregateServices;
    import com.kongregate.as3.client.services.IStatServices;
    import com.kongregate.as3.client.services.IUserServices;
    import com.kongregate.as3.client.services.KongregateServiceShadow;
    import com.kongregate.as3.client.services.StatServiceShadow;
    import com.kongregate.as3.client.services.UserServiceShadow;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.errors.IOError;
    import flash.errors.IllegalOperationError;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.TimerEvent;
    import flash.net.URLRequest;
    import flash.system.ApplicationDomain;
    import flash.system.LoaderContext;
    import flash.system.Security;
    import flash.system.SecurityDomain;
    import flash.utils.Timer;
    
    public class KongregateAPI extends Sprite
    {
        
        private static var _connected:Boolean;
        
        private static var kUser:IUserServices;
        
        private static const CLASS_USER:String = "com.kongregate.as3.client.services.UserServices";
        
        private static const CLASS_STATS:String = "com.kongregate.as3.client.services.StatServices";
        
        private static var _loaded:Boolean;
        
        private static const CLASS_SERVICES:String = "com.kongregate.as3.client.services.KongregateServices";
        
        private static const CLASS_SCORES:String = "com.kongregate.as3.client.services.HighScoreServices";
        
        private static var kServices:IKongregateServices;
        
        private static var kScores:IHighScoreServices;
        
        private static var mInstance:KongregateAPI;
        
        private static var kStats:IStatServices;
        
        private static var kAPI:IAPIBootstrap;
        
        private static const DEBUG_API_URL:String = "//Linuxpc/kongregate/public/flash/API_AS3.swf";
         
        
        private var loader:Loader;
        
        private var loadedDomain:ApplicationDomain;
        
        private const VERSION:Number = 1;
        
        public function KongregateAPI()
        {
            super();
            if(mInstance != null)
            {
                throw new Error("Warning: KongregateAPI has been added to stage more than once or accessed improperly. Use getInstance() or a stage reference to access.");
            }
            mInstance = this;
            this.addEventListener(Event.ADDED_TO_STAGE,init,false,0,true);
        }
        
        public static function getInstance() : KongregateAPI
        {
            if(!mInstance)
            {
                throw new IllegalOperationError("You must add the Kongregate API component to the stage before attempting to access it.");
            }
            return mInstance;
        }
        
        public function get loaded() : Boolean
        {
            return _loaded;
        }
        
        public function get connected() : Boolean
        {
            return _connected;
        }
        
        private function alertConnected(param1:TimerEvent = null) : void
        {
            var _loc2_:* = null;
            var _loc3_:Boolean = false;
            _loc2_ = new KongregateEvent(KongregateEvent.COMPLETE);
            _loc3_ = this.dispatchEvent(_loc2_);
        }
        
        private function init(param1:Event) : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            this.removeEventListener(Event.ADDED_TO_STAGE,init);
            _loaded = false;
            _connected = false;
            _loc2_ = LoaderInfo(root.loaderInfo).parameters;
            _loc3_ = _loc2_.api_path;
            if(_loc3_ == null)
            {
                trace("Alert: Kongregate API could not be loaded, due to local testing. API will load when the game is uploaded.");
                createShadowServices();
                return;
            }
            Security.allowDomain("*.kongregate.com");
            Security.allowDomain("kongregatetrunk.com");
            _loc4_ = new URLRequest(_loc3_);
            (_loc5_ = new LoaderContext(false)).applicationDomain = ApplicationDomain.currentDomain;
            _loc5_.securityDomain = SecurityDomain.currentDomain;
            loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE,loadComplete);
            loader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
            loader.load(_loc4_,_loc5_);
        }
        
        public function get api() : IAPIBootstrap
        {
            return kAPI;
        }
        
        private function loadComplete(param1:Event) : void
        {
            getServices();
        }
        
        public function get scores() : IHighScoreServices
        {
            return kScores;
        }
        
        private function ioErrorHandler(param1:IOErrorEvent) : void
        {
            throw new IOError("API file not found. " + param1);
        }
        
        public function get services() : IKongregateServices
        {
            return kServices;
        }
        
        public function get stats() : IStatServices
        {
            return kStats;
        }
        
        private function createShadowServices() : void
        {
            var _loc1_:* = null;
            trace(">>> Kongregate Shadow Services instantiated for local development..");
            kServices = new KongregateServiceShadow();
            kScores = new HighScoreServiceShadow();
            kStats = new StatServiceShadow();
            kUser = new UserServiceShadow();
            _loc1_ = new Timer(200,1);
            _loc1_.addEventListener(TimerEvent.TIMER_COMPLETE,alertConnected);
            _loc1_.start();
            _connected = true;
        }
        
        public function get user() : IUserServices
        {
            return kUser;
        }
        
        private function getServices() : void
        {
            var _loc1_:* = null;
            var _loc2_:* = undefined;
            var _loc3_:* = undefined;
            var _loc4_:* = undefined;
            var _loc5_:* = undefined;
            _loc1_ = ApplicationDomain.currentDomain;
            kAPI = IAPIBootstrap(loader.getChildAt(0));
            this.addChild(loader);
            _loc2_ = _loc1_.getDefinition(CLASS_SERVICES);
            trace(_loc2_);
            kServices = _loc2_.getInstance();
            _loc3_ = _loc1_.getDefinition(CLASS_SCORES);
            kScores = _loc3_.getInstance();
            _loc4_ = _loc1_.getDefinition(CLASS_STATS);
            kStats = _loc4_.getInstance();
            _loc5_ = _loc1_.getDefinition(CLASS_USER);
            kUser = _loc5_.getInstance();
            kServices.connect(VERSION);
            _loaded = true;
            _connected = true;
            alertConnected();
        }
    }
}
