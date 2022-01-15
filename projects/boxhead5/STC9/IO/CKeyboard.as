package STC9.IO
{
    import flash.display.InteractiveObject;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.events.KeyboardEvent;
    
    public class CKeyboard extends EventDispatcher
    {
        
        public static const KEYDOWN:String = "KEYDOWN";
        
        public static var mKeyIDs:Array;
        
        public static var mKeycodeDown:int;
        
        public static var mKeyNameToKeyID:Object;
        
        public static var mActive:Boolean = false;
        
        public static var mKeyNames:Array;
        
        public static var mItems:Array;
        
        public static var mKeyTable:Object;
         
        
        private var mDispatchEvents:Boolean;
        
        private var mFocusObject:InteractiveObject;
        
        public function CKeyboard(param1:InteractiveObject, param2:Boolean = false)
        {
            super();
            mDispatchEvents = param2;
            mFocusObject = param1;
            if(mActive)
            {
                if(!mFocusObject.hasEventListener(KeyboardEvent.KEY_DOWN))
                {
                }
            }
            mFocusObject.addEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);
            mFocusObject.addEventListener(KeyboardEvent.KEY_UP,reportKeyUp);
            SetupKeyTables();
            mActive = true;
        }
        
        public static function IsUp(param1:*) : Boolean
        {
            return !mItems[GetKeyCode(param1)].mDown;
        }
        
        public static function IsReleased(param1:*) : int
        {
            var _loc2_:Number = NaN;
            _loc2_ = mItems[GetKeyCode(param1)].mReleased;
            mItems[GetKeyCode(param1)].mReleased = 0;
            return _loc2_;
        }
        
        public static function IsDownAuto(param1:*) : Number
        {
            var _loc2_:Number = NaN;
            _loc2_ = mItems[GetKeyCode(param1)].mDownAuto;
            mItems[GetKeyCode(param1)].mDownAuto = 0;
            return _loc2_;
        }
        
        public static function IsDown(param1:*) : Boolean
        {
            return mItems[GetKeyCode(param1)].mDown;
        }
        
        private static function GetKeyCode(param1:*) : int
        {
            if(typeof param1 == "string")
            {
                return mKeyTable[param1];
            }
            return param1;
        }
        
        public static function IsPressed(param1:*) : int
        {
            var _loc2_:int = 0;
            var _loc3_:* = null;
            var _loc4_:Number = NaN;
            _loc2_ = GetKeyCode(param1);
            _loc3_ = mItems[_loc2_];
            _loc4_ = mItems[_loc2_].mPressed;
            mItems[_loc2_].mPressed = 0;
            return _loc4_;
        }
        
        private function reportKeyDown(param1:KeyboardEvent) : void
        {
            if(false)
            {
                mItems[param1.keyCode].RegisterAsDown();
                mKeycodeDown = param1.keyCode;
                if(mDispatchEvents)
                {
                    dispatchEvent(new Event(KEYDOWN));
                }
            }
        }
        
        private function SetupKeyTables() : void
        {
            var _loc1_:int = 0;
            var _loc2_:* = null;
            mKeyTable = new Object();
            _loc1_ = 65;
            while(_loc1_ < 91)
            {
                mKeyTable[String.fromCharCode(_loc1_)] = _loc1_;
                mKeyTable[String.fromCharCode(_loc1_ + 32)] = _loc1_;
                _loc1_++;
            }
            _loc1_ = 48;
            while(_loc1_ < 58)
            {
                mKeyTable[String.fromCharCode(_loc1_)] = _loc1_;
                _loc1_++;
            }
            mKeyTable["F1"] = 112;
            mKeyTable["F2"] = 113;
            mKeyTable["F3"] = 114;
            mKeyTable["F4"] = 115;
            mKeyTable["F5"] = 116;
            mKeyTable["F6"] = 117;
            mKeyTable["F7"] = 118;
            mKeyTable["F8"] = 119;
            mKeyTable["F9"] = 120;
            mKeyTable["F10"] = 121;
            mKeyTable["F11"] = 122;
            mKeyTable["F12"] = 123;
            mKeyTable["F13"] = 124;
            mKeyTable["F14"] = 125;
            mKeyTable["F15"] = 126;
            mKeyTable["NUM_LOCK"] = 144;
            mKeyTable["SCR_LOCK"] = 145;
            mKeyTable["PAUSE"] = 19;
            mKeyTable["NUMPAD_0"] = 96;
            mKeyTable["NUMPAD_1"] = 97;
            mKeyTable["NUMPAD_2"] = 98;
            mKeyTable["NUMPAD_3"] = 99;
            mKeyTable["NUMPAD_4"] = 100;
            mKeyTable["NUMPAD_5"] = 101;
            mKeyTable["NUMPAD_6"] = 102;
            mKeyTable["NUMPAD_7"] = 103;
            mKeyTable["NUMPAD_8"] = 104;
            mKeyTable["NUMPAD_9"] = 105;
            mKeyTable["NUMPAD_ADD"] = 107;
            mKeyTable["NUMPAD_DECIMAL"] = 110;
            mKeyTable["NUMPAD_DIVIDE"] = 111;
            mKeyTable["NUMPAD_ENTER"] = 108;
            mKeyTable["NUMPAD_MULTIPLY"] = 106;
            mKeyTable["NUMPAD_SUBTRACT"] = 109;
            mKeyTable["COLON"] = 186;
            mKeyTable["EQUALS"] = 187;
            mKeyTable["MINUS"] = 189;
            mKeyTable["FWD_SLASH"] = 191;
            mKeyTable["LSQR_BRACKET"] = 219;
            mKeyTable["RSQR_BRACKET"] = 221;
            mKeyTable["BACK_SLASH"] = 220;
            mKeyTable["COMMA"] = 188;
            mKeyTable["DOT"] = 190;
            mKeyTable["HOME"] = 36;
            mKeyTable["INSERT"] = 45;
            mKeyTable["PAGE_DOWN"] = 34;
            mKeyTable["PAGE_UP"] = 33;
            mKeyTable["SHIFT"] = 16;
            mKeyTable["SPACE"] = 32;
            mKeyTable["TAB"] = 9;
            mKeyTable["QUOTE"] = 34;
            mKeyTable["BACKSPACE"] = 8;
            mKeyTable["CAPS_LOCK"] = 20;
            mKeyTable["CONTROL"] = 17;
            mKeyTable["DELETE"] = 46;
            mKeyTable["END"] = 35;
            mKeyTable["ENTER"] = 13;
            mKeyTable["ESCAPE"] = 27;
            mKeyTable["UP"] = 38;
            mKeyTable["LEFT"] = 37;
            mKeyTable["DOWN"] = 40;
            mKeyTable["RIGHT"] = 39;
            mItems = new Array();
            _loc1_ = 0;
            while(_loc1_ < 256)
            {
                mItems.push(new CKey(_loc1_));
                _loc1_++;
            }
            mKeyNames = new Array();
            mKeyIDs = new Array();
            _loc1_ = 0;
            while(_loc1_ < 256)
            {
                mKeyNames[_loc1_] = "";
                mKeyIDs[_loc1_] = "";
                _loc1_++;
            }
            mKeyNameToKeyID = new Object();
            for(_loc2_ in mKeyTable)
            {
                mKeyNames["null"] = TReplace(_loc2_);
                mKeyNameToKeyID["null"] = _loc2_;
                mKeyIDs["null"] = _loc2_;
            }
        }
        
        private function reportKeyUp(param1:KeyboardEvent) : void
        {
            if(false)
            {
                mItems[param1.keyCode].RegisterAsUp();
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CKeyboard";
        }
        
        override public function toString() : String
        {
            return _CLASSID_;
        }
        
        public function Clear() : void
        {
            var _loc1_:* = null;
            for each(_loc1_ in mItems)
            {
                _loc1_.Clear();
            }
        }
        
        private function TReplace(param1:String) : String
        {
            var _loc2_:* = null;
            _loc2_ = /_/;
            return param1.replace(_loc2_," ").toLowerCase();
        }
        
        public function get _BASECLASSID_() : String
        {
            return "CKeyboard";
        }
        
        public function Dispose() : void
        {
            mFocusObject.removeEventListener(KeyboardEvent.KEY_DOWN,reportKeyDown);
            mFocusObject.removeEventListener(KeyboardEvent.KEY_UP,reportKeyUp);
            mActive = false;
        }
    }
}
