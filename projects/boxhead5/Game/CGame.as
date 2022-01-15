package Game
{
    import IO.CMochiBot;
    import Landscape.CLandscape;
    import STC9.Bitmap.CBitmapData;
    import STC9.IO.CKeyboard;
    import STC9.System.Profiler.CFPS;
    import Screen.CScreen_Pause;
    import Thing.CAppearSmoke;
    import Thing.CDestroySmoke;
    import Thing.CDevil;
    import Thing.CExplosion;
    import Thing.CFire;
    import Thing.CMummy;
    import Thing.CRunner;
    import Thing.CThing;
    import Thing.CThingAudio;
    import Thing.CThingMap;
    import Thing.CVampire;
    import Thing.CZombie;
    import World.CLevelData;
    import World.CWorld;
    import flash.display.Sprite;
    import flash.display.StageQuality;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.ui.Mouse;
    import flash.utils.getTimer;
    
    public class CGame extends Sprite
    {
        
        public static const mScreenHeight:int = 490;
        
        public static const START:String = "START";
        
        public static const mScreenWidth:int = 700;
        
        public static var mHUD:CHUD;
        
        private static var mTimeSlice:int;
        
        public static const SECONDS:int = 25;
        
        private static const fFrameTime:Number = 1000 / SECONDS;
        
        public static var mLevelData:Object;
        
        public static const DISPOSED:String = "DISPOSED";
        
        public static const mScreenAspect:Number = mScreenWidth / mScreenHeight;
        
        public static const DEBUG:Boolean = true;
        
        public static var mFPS:CFPS;
         
        
        private var mTrackOffset:Point;
        
        public var mWorld:CWorld;
        
        private var mKeyboard:CKeyboard;
        
        private var mPauseScreen:Screen_Pause;
        
        private var mFastMode:Boolean;
        
        private var mLoadClasses:Array;
        
        private var mLandscape:CLandscape;
        
        public function CGame()
        {
            super();
            visible = false;
        }
        
        private static function ProcessFrames_Reset() : *
        {
            mTimeSlice = getTimer();
        }
        
        private static function ProcessFrames() : int
        {
            var _loc1_:int = 0;
            _loc1_ = Math.min(10000,(getTimer() - mTimeSlice) / fFrameTime);
            if(_loc1_ > 0)
            {
                mTimeSlice += _loc1_ * fFrameTime;
            }
            return _loc1_;
        }
        
        public function Activate(param1:int) : void
        {
            CThingAudio.mSoundActive = CGlobalData.GetData("Sound","on") == "on" ? true : false;
            CBitmapData.Record();
            CGlobalData.SendData_LevelPlay(param1);
            CMochiBot.Track(CMochiBot["BXH_ZW_LEVEL" + (param1 + 1) + "PLAYS"]);
            CMochiBot.Track(CMochiBot.BXH_ZW_LEVELSPLAYED);
            mLevelData = CLevelData.GetData(param1);
            CGlobalData.AddStat("Total games played",1,"ADD");
            CGlobalData.AddStat("Level \'undefined\' played",1,"ADD");
            mKeyboard = new CKeyboard(stage);
            mFPS = new CFPS("RIGHT");
            ProcessFrames_Reset();
            mHUD = new CHUD();
            mLandscape = new CLandscape();
            mWorld = new CWorld(mLandscape);
            SetGlobals();
            mWorld.Start();
            mTrackOffset = new Point(0,0);
            addChild(mLandscape);
            this.stage.focus = stage;
            mFastMode = CGlobalData.GetData("GameSpeed","normal") == "normal" ? false : true;
            mLoadClasses = [CDevil,CZombie,CMummy,CVampire,CRunner,CDestroySmoke,CAppearSmoke,CExplosion,CFire];
            stage.addEventListener(Event.ENTER_FRAME,e_ENTERFRAME_LOADING);
            stage.quality = StageQuality.LOW;
            if(CGlobalData.GetData("MOUSE","on") == "on")
            {
                Mouse.show();
            }
            else
            {
                Mouse.hide();
            }
        }
        
        private function ProcessDebug() : void
        {
            if(!(CKeyboard.IsDown("SHIFT") && CKeyboard.IsDown("CONTROL")))
            {
                return;
            }
            if(CKeyboard.IsReleased("INSERT"))
            {
                if(contains(mFPS))
                {
                    removeChild(mFPS);
                }
                else
                {
                    addChild(mFPS);
                }
            }
            if(CKeyboard.IsReleased("C"))
            {
                CGlobalData.SetData("MOUSE",CGlobalData.GetData("MOUSE") == "on" ? "off" : "on");
                if(CGlobalData.GetData("MOUSE") == "on")
                {
                    Mouse.show();
                }
                else
                {
                    Mouse.hide();
                }
            }
            if(CKeyboard.IsDown("UP"))
            {
                --0;
            }
            if(CKeyboard.IsDown("DOWN"))
            {
                ++0;
            }
            if(CKeyboard.IsDown("LEFT"))
            {
                --0;
            }
            if(CKeyboard.IsDown("RIGHT"))
            {
                ++0;
            }
            if(CKeyboard.IsDown("HOME"))
            {
                mTrackOffset.x = mTrackOffset.y = 0;
            }
        }
        
        public function Process() : void
        {
            SetGlobals();
            if(false)
            {
                if(CKeyboard.IsPressed("P") || CKeyboard.IsPressed("ESCAPE"))
                {
                    Mouse.show();
                    mWorld.mPause = true;
                    mPauseScreen = new Screen_Pause();
                    mPauseScreen.scaleY = 0.875;
                    mPauseScreen.scaleX = 0.875;
                    addChild(mPauseScreen);
                    mPauseScreen.mGame = this;
                    mPauseScreen.Activate();
                    mPauseScreen.addEventListener(CScreen_Pause.CLOSE,e_PAUSESCREEN_CLOSE);
                    mPauseScreen.addEventListener(CScreen_Pause.EXITGAME,e_PAUSESCREEN_EXITGAME);
                    CThingAudio.PauseAllSounds();
                    return;
                }
            }
            mLandscape.TrackThing(mWorld.mTrackThing,mTrackOffset);
            mWorld.Process();
            mHUD.Process();
        }
        
        public function Draw() : void
        {
            SetGlobals();
            if(false)
            {
                return;
            }
            mLandscape.Draw();
        }
        
        private function e_PAUSESCREEN_EXITGAME(param1:Event) : void
        {
            mPauseScreen.removeEventListener(CScreen_Pause.EXITGAME,e_PAUSESCREEN_EXITGAME);
            mWorld.mState = "CLOSE";
            CThingAudio.StopAllSounds();
        }
        
        private function SetGlobals() : void
        {
            CThingMap.mWorld = mWorld;
            CThingMap.mLandscape = mLandscape;
        }
        
        public function e_ENTERFRAME_LOADING(param1:Event) : void
        {
            var _loc2_:* = null;
            var _loc3_:int = 0;
            if(false)
            {
                stage.removeEventListener(Event.ENTER_FRAME,e_ENTERFRAME_LOADING);
                stage.addEventListener(Event.ENTER_FRAME,e_ENTERFRAME_START);
                return;
            }
            _loc2_ = mLoadClasses.pop();
            _loc3_ = getTimer();
            _loc2_["PrepareClass"]();
        }
        
        public function e_ENTERFRAME(param1:Event) : void
        {
            var _loc2_:int = 0;
            CThing.INDENT = "";
            ProcessDebug();
            mFPS.Update();
            mFPS.StartProfile("A_TOTAL");
            _loc2_ = !!mFastMode ? 1 : int(ProcessFrames());
            if(_loc2_)
            {
                mFPS.StartProfile("A_PROCESS");
                Process();
                mFPS.StopProfile("A_PROCESS");
                CThingAudio.UpdateAllSounds();
                mFPS.StartProfile("A_DRAW");
                Draw();
                mFPS.StopProfile("A_DRAW");
            }
            mFPS.StopProfile("A_TOTAL");
            if(false)
            {
                Dispose();
            }
        }
        
        public function e_ENTERFRAME_START(param1:Event) : void
        {
            visible = true;
            stage.removeEventListener(Event.ENTER_FRAME,e_ENTERFRAME_START);
            dispatchEvent(new Event(START));
            stage.addEventListener(Event.ENTER_FRAME,e_ENTERFRAME);
            mKeyboard.Clear();
        }
        
        public function get _CLASSID_() : String
        {
            return "CGame";
        }
        
        private function e_PAUSESCREEN_CLOSE(param1:Event) : void
        {
            removeChild(mPauseScreen);
            mWorld.mPause = false;
            mPauseScreen.removeEventListener(CScreen_Pause.CLOSE,e_PAUSESCREEN_CLOSE);
            mPauseScreen = null;
            this.stage.focus = stage;
            mKeyboard.Clear();
            CThingAudio.UnpauseAllSounds();
            if(CGlobalData.GetData("MOUSE","on") == "on")
            {
                Mouse.show();
            }
            else
            {
                Mouse.hide();
            }
        }
        
        public function Dispose() : void
        {
            CGlobalData.Flush();
            mKeyboard.Dispose();
            stage.removeEventListener(Event.ENTER_FRAME,e_ENTERFRAME);
            removeChild(mLandscape);
            if(contains(mFPS))
            {
                removeChild(mFPS);
            }
            CThingAudio.StopAllSounds();
            mLandscape.Dispose();
            mWorld.Dispose();
            mLandscape = null;
            mWorld = null;
            CBitmapData.ReleaseAll();
            stage.quality = StageQuality.HIGH;
            dispatchEvent(new Event(DISPOSED));
            Mouse.show();
        }
    }
}
