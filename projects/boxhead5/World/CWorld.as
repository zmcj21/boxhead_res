package World
{
    import Game.CGame;
    import Landscape.CLandscape;
    import STC9.IO.CKeyboard;
    import Screen.CScreen_Config;
    import Screen.CScreen_Debrief;
    import Thing.CBambo;
    import Thing.CPeepPlayer;
    import Thing.CThing;
    import Thing.CThingMain;
    import Thing.CThingV3;
    
    public class CWorld
    {
        
        public static const SECONDS:int = 25;
         
        
        public var mThingContainer:CThingMain;
        
        public var mState:String;
        
        public var mPause:Boolean;
        
        public var mTick:int;
        
        public var mTrackThing:CPeepPlayer;
        
        public var mLandscape:CLandscape;
        
        public var mMap:CWorldMap;
        
        public var mLevel:CLevel;
        
        public function CWorld(param1:CLandscape)
        {
            super();
            mLandscape = param1;
            mThingContainer = new CThingMain();
            mTick = 0;
            mPause = false;
            mMap = new CWorldMap(param1.mLSDraw.mCells);
            CThingV3.SetMapSize(mMap.mWidth,mMap.mHeight);
            mLandscape.mLSThingDraw.mWorldMap = mMap;
            mLevel = new CLevel(this);
        }
        
        public function Process() : void
        {
            if(mPause)
            {
                return;
            }
            mMap.Process();
            mLevel.Process();
            mThingContainer.ProcessChildren();
            mMap.NavMapProcess();
            ++mTick;
            if(false)
            {
                if(CKeyboard.IsReleased("G"))
                {
                    CThing.VERBOSE = false;
                }
                if(CKeyboard.IsReleased("F"))
                {
                    CThing.VERBOSE = true;
                }
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CWorld";
        }
        
        public function AddThing(param1:*) : *
        {
            return mThingContainer.AddThing(param1);
        }
        
        public function Start() : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:Boolean = false;
            CThing.Restart();
            _loc2_ = mLandscape.mPlayerInitPositions[0].mPosition;
            _loc3_ = !!_loc2_ ? {"mPosition":_loc2_} : null;
            (_loc4_ = AddThing(new CBambo(_loc3_))).ActivateControl(CScreen_Config.GetPlayerControl(0));
            for each(_loc5_ in mLandscape.mThingInitPositions)
            {
                _loc6_ = false;
                if(CGame.mLevelData.mMode != "DEFENCE")
                {
                    switch(_loc5_.initClass.toString())
                    {
                        case "[class CTree]":
                        case "[class CRock]":
                            _loc6_ = true;
                    }
                }
                else
                {
                    _loc6_ = true;
                }
                if(_loc6_)
                {
                    AddThing(new _loc5_.initClass(_loc5_,_loc4_));
                }
            }
            mTrackThing = _loc4_;
            mLevel.mUpgradePeep = _loc4_;
            mLevel.Start();
        }
        
        public function Dispose() : void
        {
            CScreen_Debrief.SScore = mLevel.mLevelStats.SScore;
            mThingContainer.Dispose();
            mThingContainer = null;
            mLevel = null;
            mMap = null;
        }
    }
}
