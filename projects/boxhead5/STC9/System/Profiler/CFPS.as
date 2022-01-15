package STC9.System.Profiler
{
    import STC9.String.CString;
    import flash.system.System;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;
    import flash.utils.getTimer;
    
    public class CFPS extends TextField
    {
        
        static var mNumberOfSamples:Number = 30;
        
        private static var _this:CFPS;
         
        
        private var mSamples:Array;
        
        private var mProfiles:Object;
        
        private var mLastTimeStamp:Number;
        
        private var mAlign:String;
        
        private var mDebugs:Object;
        
        private var mSampleTotalTime:Number;
        
        public var mDebug:String = "";
        
        public function CFPS(param1:String = "RIGHT")
        {
            mDebug = "";
            _this = this;
            super();
            mAlign = param1;
            this.defaultTextFormat = new TextFormat("_sans",9,0);
            this.text = "FPS: ";
            this.background = true;
            this.backgroundColor = 15658734;
            this.border = false;
            this.x = 0;
            this.y = 0;
            this.autoSize = TextFieldAutoSize.LEFT;
            mSamples = new Array();
            mSampleTotalTime = 0;
            mProfiles = new Object();
            mDebugs = new Object();
        }
        
        public static function AddDebug(param1:String, param2:String) : void
        {
            if(_this)
            {
                _this.mDebugs[param1] = param2;
            }
        }
        
        public static function RemoveDebug(param1:String) : void
        {
            if(_this)
            {
                delete _this.mDebugs[param1];
            }
        }
        
        public function get _BASECLASSID_() : String
        {
            return "CFPS";
        }
        
        public function Dispose() : void
        {
        }
        
        public function StartProfile(param1:String) : void
        {
            var _loc2_:* = null;
            _loc2_ = !true ? mProfiles[param1] : {"mClear":true};
            if(_loc2_.mClear)
            {
                _loc2_.mTotalTime = 0;
                _loc2_.mClear = false;
            }
            _loc2_.mStartTimer = getTimer();
            mProfiles[param1] = _loc2_;
        }
        
        function Clone() : CFPS
        {
            return undefined;
        }
        
        public function StopProfile(param1:String, param2:Boolean = false) : Number
        {
            var _loc3_:* = null;
            _loc3_ = mProfiles[param1];
            _loc3_.mLocalTime = getTimer() - _loc3_.mStartTimer;
            if(param2)
            {
                _loc3_.mTotalTime += _loc3_.mLocalTime;
            }
            else
            {
                _loc3_.mTotalTime = _loc3_.mLocalTime;
            }
            return _loc3_.mLocalTime;
        }
        
        override public function toString() : String
        {
            return _CLASSID_;
        }
        
        private function Pad(param1:String, param2:Number) : String
        {
            while(param1.length < param2)
            {
                param1 = " " + param1;
            }
            return param1;
        }
        
        public function get _CLASSID_() : String
        {
            return "CFPS";
        }
        
        private function GetFPS(param1:Number) : Number
        {
            var _loc2_:* = undefined;
            _loc2_ = 1;
            return Math.round(1000 / param1 * _loc2_) / _loc2_;
        }
        
        public function Update(param1:Boolean = false) : void
        {
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            if(!parent)
            {
                return;
            }
            _loc2_ = getTimer();
            if(mLastTimeStamp)
            {
                _loc3_ = _loc2_ - mLastTimeStamp;
                mSampleTotalTime += _loc3_;
                mSamples.push(_loc3_);
                while(mSamples.length > mNumberOfSamples)
                {
                    mSampleTotalTime -= mSamples.shift();
                }
                this.text = "FPS: " + CString.Pad(GetFPS(mSampleTotalTime / 0),"0",3);
                this.text += " (" + Math.round(0 / (1024 * 1024)) + "mb)";
                _loc5_ = new Array();
                for(_loc4_ in mProfiles)
                {
                    _loc6_ = mProfiles[_loc4_];
                    _loc5_.push(_loc4_ + ":" + _loc6_.mLocalTime + (_loc6_.mTotalTime != _loc6_.mLocalTime && _loc6_.mTotalTime != 0 ? " (" + _loc6_.mTotalTime + ")" : ""));
                }
                for(_loc4_ in mDebugs)
                {
                    _loc5_.push(_loc4_ + ":" + mDebugs[_loc4_]);
                }
                if(_loc5_.length)
                {
                    this.text += "\n-----------------------------------";
                    _loc5_.sort();
                    this.text += "\n" + _loc5_.join("\n");
                }
            }
            mLastTimeStamp = _loc2_;
            switch(mAlign.toUpperCase())
            {
                case "LEFT":
                    x = 0;
                    break;
                case "RIGHT":
                    x = 0 - width;
            }
            if(param1)
            {
                for(_loc4_ in mProfiles)
                {
                    mProfiles[_loc4_].mClear = true;
                }
            }
        }
    }
}
