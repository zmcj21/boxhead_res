package IO
{
    import STC9.IO.CKeyboard;
    import flash.events.EventDispatcher;
    
    public class CPlayerControl extends EventDispatcher
    {
         
        
        public var mShootUp:int;
        
        public var mWEAPON1:Object;
        
        public var mWEAPON2:Object;
        
        public var mWEAPON3:Object;
        
        public var mWEAPON4:Object;
        
        public var mWEAPON5:Object;
        
        public var mWEAPON0:Object;
        
        public var mWEAPON9:Object;
        
        public var mWEAPON6:Object;
        
        public var mWEAPON8:Object;
        
        public var mShootDown:int;
        
        public var mWEAPON7:Object;
        
        public var mAngle256:uint;
        
        public var mSelectIndex:int;
        
        public var mSHOOT:Object;
        
        public var mPREVWEAPON:Object;
        
        public var mShoot:Boolean;
        
        public var mMOVELEFT:Object;
        
        public var mType:String = "NORMAL";
        
        private var mActive:Boolean;
        
        public var Process:Function;
        
        public var mMOVEUP:Object;
        
        public var mMOVEDOWN:Object;
        
        public var mDeltaX:int;
        
        public var mDeltaY:int;
        
        public var mSelectDelta:int;
        
        public var mNEXTWEAPON:Object;
        
        public var mMOVERIGHT:Object;
        
        public function CPlayerControl()
        {
            mType = "NORMAL";
            super();
        }
        
        public static function Define_NORMAL(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:Boolean = true) : CPlayerControl
        {
            var _loc9_:* = null;
            (_loc9_ = new CPlayerControl()).mType = "NORMAL";
            _loc9_.mMOVELEFT = CreateControl_NORMAL(param1);
            _loc9_.mMOVERIGHT = CreateControl_NORMAL(param2);
            _loc9_.mMOVEUP = CreateControl_NORMAL(param3);
            _loc9_.mMOVEDOWN = CreateControl_NORMAL(param4);
            _loc9_.mSHOOT = CreateControl_NORMAL(param5);
            _loc9_.mNEXTWEAPON = CreateControl_NORMAL(param7);
            _loc9_.mPREVWEAPON = CreateControl_NORMAL(param6);
            if(param8)
            {
                _loc9_.mWEAPON0 = {"mControlID":"1"};
                _loc9_.mWEAPON1 = {"mControlID":"2"};
                _loc9_.mWEAPON2 = {"mControlID":"3"};
                _loc9_.mWEAPON3 = {"mControlID":"4"};
                _loc9_.mWEAPON4 = {"mControlID":"5"};
                _loc9_.mWEAPON5 = {"mControlID":"6"};
                _loc9_.mWEAPON6 = {"mControlID":"7"};
                _loc9_.mWEAPON7 = {"mControlID":"8"};
                _loc9_.mWEAPON8 = {"mControlID":"9"};
                _loc9_.mWEAPON9 = {"mControlID":"0"};
            }
            return _loc9_;
        }
        
        private static function CreateControl_NORMAL(param1:String) : Object
        {
            return {"mControlID":param1};
        }
        
        public function Activate() : void
        {
            if(true)
            {
                return;
            }
            switch(mType)
            {
                case "NORMAL":
                    Process = Process_Normal;
                    mActive = true;
            }
        }
        
        public function Deactivate() : *
        {
            mActive = false;
        }
        
        public function get _CLASSID_() : String
        {
            return "CPlayerControl";
        }
        
        public function Process_Normal() : void
        {
            mDeltaX = !!CKeyboard.IsDown(mMOVERIGHT.mControlID) ? 1 : (!!CKeyboard.IsDown(mMOVELEFT.mControlID) ? -1 : 0);
            mDeltaY = !!CKeyboard.IsDown(mMOVEDOWN.mControlID) ? 1 : (!!CKeyboard.IsDown(mMOVEUP.mControlID) ? -1 : 0);
            mShoot = CKeyboard.IsDown(mSHOOT.mControlID);
            mShootDown = CKeyboard.IsPressed(mSHOOT.mControlID);
            mShootUp = CKeyboard.IsReleased(mSHOOT.mControlID);
            if(CKeyboard.IsPressed(mNEXTWEAPON.mControlID))
            {
                mSelectDelta = 1;
            }
            else if(CKeyboard.IsPressed(mPREVWEAPON.mControlID))
            {
                mSelectDelta = -1;
            }
            else
            {
                mSelectDelta = 0;
            }
            mSelectIndex = -1;
            if(mWEAPON0)
            {
                if(CKeyboard.IsReleased(mWEAPON0.mControlID))
                {
                    mSelectIndex = 0;
                }
                if(CKeyboard.IsReleased(mWEAPON1.mControlID))
                {
                    mSelectIndex = 1;
                }
                if(CKeyboard.IsReleased(mWEAPON2.mControlID))
                {
                    mSelectIndex = 2;
                }
                if(CKeyboard.IsReleased(mWEAPON3.mControlID))
                {
                    mSelectIndex = 3;
                }
                if(CKeyboard.IsReleased(mWEAPON4.mControlID))
                {
                    mSelectIndex = 4;
                }
                if(CKeyboard.IsReleased(mWEAPON5.mControlID))
                {
                    mSelectIndex = 5;
                }
                if(CKeyboard.IsReleased(mWEAPON6.mControlID))
                {
                    mSelectIndex = 6;
                }
                if(CKeyboard.IsReleased(mWEAPON7.mControlID))
                {
                    mSelectIndex = 7;
                }
                if(CKeyboard.IsReleased(mWEAPON8.mControlID))
                {
                    mSelectIndex = 8;
                }
                if(CKeyboard.IsReleased(mWEAPON9.mControlID))
                {
                    mSelectIndex = 9;
                }
            }
        }
    }
}
