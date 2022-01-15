package Screen
{
    import Game.CGame;
    import Game.CGlobalData;
    import STC9.Bitmap.CBitmapData;
    import STC9.UI.CUISetDefaults;
    import flash.display.Bitmap;
    import flash.display.MovieClip;
    import flash.display.StageQuality;
    import flash.events.Event;
    
    public class CScreenCollection extends MovieClip
    {
        
        public static const mScreenHeight:int = 560;
        
        public static var mReturn:Boolean = false;
        
        public static const mScreenWidth:int = 800;
        
        public static const SECONDS:int = CGame.SECONDS;
         
        
        private var mCurrentScreen:CScreen;
        
        private var mcProtection:Protection;
        
        public var mcDefaultBG:MovieClip;
        
        private var mScreens:Object;
        
        private var rParent;
        
        private var bgBitmap:Bitmap;
        
        public function CScreenCollection()
        {
            super();
            mScreens = new Object();
            AddScreen("MOREGAMES",Screen_MoreGames);
            AddScreen("SELECTLEVEL",Screen_SelectLevel);
            AddScreen("MAIN",Screen_Main);
            AddScreen("DEBRIEF",Screen_Debrief);
            AddScreen("LOADLEVEL",Screen_LoadLevel);
            Activate(!!mReturn ? "DEBRIEF" : "MAIN");
            SetIDefaults(this);
            mcProtection = new Protection();
            CGlobalData.LoadKongregate(this);
            stage.quality = StageQuality.HIGH;
            addEventListener(Event.ENTER_FRAME,e_PROCESS);
        }
        
        public function SetBackground(param1:CScreen) : void
        {
            var _loc2_:* = null;
            ClearBackground();
            _loc2_ = new CBitmapData(mScreenWidth,mScreenHeight,false,0);
            _loc2_.draw(param1);
            bgBitmap = new Bitmap(_loc2_,"auto",true);
            addChild(bgBitmap);
        }
        
        public function Activate(param1:String) : void
        {
            if(mCurrentScreen)
            {
                SetBackground(mCurrentScreen);
                removeChild(mCurrentScreen);
                mCurrentScreen.Deactivate();
            }
            mCurrentScreen = mScreens[param1].screen;
            addChild(mCurrentScreen);
            mCurrentScreen.Activate("FADEIN");
        }
        
        public function ClearBackground() : void
        {
            if(!bgBitmap)
            {
                return;
            }
            removeChild(bgBitmap);
            bgBitmap.bitmapData.dispose();
            bgBitmap.bitmapData = null;
            bgBitmap = null;
        }
        
        private function e_PROCESS(param1:Event) : void
        {
            if(mCurrentScreen)
            {
                if(false)
                {
                    mCurrentScreen.TransitionProcess();
                }
                mcProtection.Check(this);
            }
        }
        
        private function AddScreen(param1:String, param2:Class) : void
        {
            var _loc3_:* = null;
            _loc3_ = new param2();
            _loc3_.mScreenCollection = this;
            mScreens[param1] = {
                "id":param1,
                "screen":_loc3_,
                "screenClass":param2
            };
            SetIDefaults(_loc3_);
            _loc3_.visible = false;
        }
        
        public function SetIDefaults(param1:*) : void
        {
            CUISetDefaults.SetField(param1,"tabEnabled",false,true);
        }
        
        public function get _CLASSID_() : String
        {
            return "CScreenCollection";
        }
        
        public function Pause() : void
        {
            rParent = parent;
            removeEventListener(Event.ENTER_FRAME,e_PROCESS);
            visible = false;
            rParent.removeChild(this);
        }
        
        public function Unpause() : void
        {
            rParent.addChild(this);
            addEventListener(Event.ENTER_FRAME,e_PROCESS);
            visible = true;
        }
    }
}
