package Screen
{
    import Game.CGlobalData;
    import IO.CPlayerControl;
    import STC9.IO.CKeyboard;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    
    public class CScreen_Config extends CScreen
    {
        
        private static var bList:Object;
         
        
        public var tfMoveLeft:TextField;
        
        public var bReset:SimpleButton;
        
        public var bPrevWeapon:SimpleButton;
        
        public var tfQuality:TextField;
        
        public var tfUseWeapon:TextField;
        
        public var tfZombies:TextField;
        
        public var tfPrevWeapon:TextField;
        
        public var bQuality:SimpleButton;
        
        public var bUseWeapon:SimpleButton;
        
        public var bZombies:SimpleButton;
        
        public var tfRunners:TextField;
        
        public var tfMoveRight:TextField;
        
        public var bDevils:SimpleButton;
        
        public var bMoveRight:SimpleButton;
        
        public var bMoveDown:SimpleButton;
        
        public var bRunners:SimpleButton;
        
        public var tfMoveDown:TextField;
        
        public var bVampires:SimpleButton;
        
        public var tfDevils:TextField;
        
        public var bClose:SimpleButton;
        
        public var tfVampires:TextField;
        
        public var bNextWeapon:SimpleButton;
        
        public var mcFieldFlasher:MovieClip;
        
        public var tfNextWeapon:TextField;
        
        public var tfGameSpeed:TextField;
        
        public var bGameSpeed:SimpleButton;
        
        public var bMoveUp:SimpleButton;
        
        public var tfMoveUp:TextField;
        
        private var mKeyboard:CKeyboard;
        
        private var bFocus:Object;
        
        public var mcTopLock:MovieClip;
        
        public var tfSound:TextField;
        
        public var tfMummies:TextField;
        
        public var bMummies:SimpleButton;
        
        public var bSound:SimpleButton;
        
        public var mcLock:MovieClip;
        
        public var bMoveLeft:SimpleButton;
        
        public function CScreen_Config()
        {
            super();
            bClose.addEventListener(MouseEvent.MOUSE_UP,me_CLOSE_CLICK);
            bReset.addEventListener(MouseEvent.MOUSE_UP,me_RESET_CLICK);
            mcLock.addEventListener(MouseEvent.MOUSE_UP,me_DUMB);
            mcTopLock.addEventListener(MouseEvent.MOUSE_UP,me_DUMB);
            bList = new Object();
            SetupButton("Zombies",["on","off"],"on",false);
            SetupButton("Vampires",["on","off"],"on");
            SetupButton("Devils",["on","off"],"on");
            SetupButton("Mummies",["on","off"],"on");
            SetupButton("Runners",["on","off"],"on");
            SetupButton("GameSpeed",["normal","fast"],"normal");
            SetupButton("Quality",["low","high"],"high");
            SetupButton("Sound",["on","off"],"on");
            SetupButton("MoveLeft",[],"LEFT");
            SetupButton("MoveRight",[],"RIGHT");
            SetupButton("MoveUp",[],"UP");
            SetupButton("MoveDown",[],"DOWN");
            SetupButton("UseWeapon",[],"SPACE");
            SetupButton("NextWeapon",[],"X");
            SetupButton("PrevWeapon",[],"Z");
            mcFieldFlasher.visible = false;
            mcTopLock.visible = false;
        }
        
        public static function GetPlayerControl(param1:int = 0) : CPlayerControl
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:* = null;
            var _loc8_:* = null;
            var _loc9_:* = null;
            _loc2_ = CKeyboard.mKeyNameToKeyID;
            _loc3_ = _loc2_[bList["bMoveLeft"].mTextfield.text];
            _loc4_ = _loc2_[bList["bMoveRight"].mTextfield.text];
            _loc5_ = _loc2_[bList["bMoveUp"].mTextfield.text];
            _loc6_ = _loc2_[bList["bMoveDown"].mTextfield.text];
            _loc7_ = _loc2_[bList["bUseWeapon"].mTextfield.text];
            _loc8_ = _loc2_[bList["bNextWeapon"].mTextfield.text];
            _loc9_ = _loc2_[bList["bPrevWeapon"].mTextfield.text];
            return CPlayerControl.Define_NORMAL(_loc3_,_loc4_,_loc5_,_loc6_,_loc7_,_loc9_,_loc8_);
        }
        
        private function me_CLOSE_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            Deactivate();
            CGlobalData.Flush();
        }
        
        private function me_RESET_CLICK(param1:MouseEvent) : void
        {
            var _loc2_:* = null;
            PlaySound_ClickShort();
            for each(_loc2_ in bList)
            {
                _loc2_.mTextfield.text = _loc2_.mDefault;
                CGlobalData.SetData(_loc2_.bID,_loc2_.mDefault);
            }
        }
        
        private function me_CLICKBUTTON(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            bFocus = bList[param1.currentTarget.name];
            if(bFocus.mTexts.length)
            {
                bFocus.mTextfield.text = bFocus.mTexts[(bFocus.mTexts.indexOf(bFocus.mTextfield.text) + 1) % bFocus.mTexts.length];
                CGlobalData.SetData(bFocus.bID,bFocus.mTextfield.text);
            }
            else
            {
                bFocus.mLastValue = bFocus.mTextfield.text;
                bFocus.mTextfield.text = "";
                mKeyboard.addEventListener(CKeyboard.KEYDOWN,e_KEYDOWN);
                mcFieldFlasher.visible = true;
                mcTopLock.visible = true;
                mcFieldFlasher.x = bFocus.mButton.x;
                mcFieldFlasher.y = bFocus.mButton.y;
                mcFieldFlasher.width = bFocus.mButton.width;
                mcFieldFlasher.height = bFocus.mButton.height;
            }
        }
        
        override public function Deactivate(param1:String = "FADEOUT") : void
        {
            var _loc2_:* = null;
            visible = false;
            mKeyboard.Dispose();
            _loc2_ = "on";
            if(CGlobalData.GetData("Zombies") == "off")
            {
                _loc2_ = "off";
            }
            if(CGlobalData.GetData("Vampires") == "off")
            {
                _loc2_ = "off";
            }
            if(CGlobalData.GetData("Devils") == "off")
            {
                _loc2_ = "off";
            }
            if(CGlobalData.GetData("Mummies") == "off")
            {
                _loc2_ = "off";
            }
            if(CGlobalData.GetData("Zombies") == "off")
            {
                _loc2_ = "off";
            }
            if(CGlobalData.GetData("GameSpeed") == "fast")
            {
                _loc2_ = "off";
            }
            CGlobalData.SetData("SendScore",_loc2_);
        }
        
        override public function Activate(param1:String = "FADEIN") : void
        {
            mKeyboard = new CKeyboard(this.stage,true);
            visible = true;
        }
        
        private function e_KEYDOWN(param1:Event) : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            _loc2_ = CKeyboard.mKeyNames["null"];
            _loc3_ = _loc2_.toUpperCase();
            if(_loc3_ == "P" || _loc3_ == "")
            {
                return;
            }
            bFocus.mTextfield.text = _loc3_ == "ESCAPE" ? bFocus.mLastValue : _loc2_;
            CGlobalData.SetData(bFocus.bID,bFocus.mTextfield.text);
            mKeyboard.removeEventListener(CKeyboard.KEYDOWN,e_KEYDOWN);
            mcFieldFlasher.visible = false;
            mcTopLock.visible = false;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CScreen_Config";
        }
        
        private function SetupButton(param1:String, param2:Array, param3:String, param4:Boolean = true) : void
        {
            var _loc5_:* = null;
            _loc5_ = "b" + param1;
            bList[_loc5_] = new Object();
            bList[_loc5_].mTextfield = this["tf" + param1];
            bList[_loc5_].mTexts = param2;
            bList[_loc5_].mDefault = param3.toLowerCase();
            bList[_loc5_].mButton = this[_loc5_];
            bList[_loc5_].bID = param1;
            bList[_loc5_].mTextfield.selectable = false;
            bList[_loc5_].mTextfield.text = CGlobalData.GetData(param1,bList[_loc5_].mDefault);
            if(param4)
            {
                bList[_loc5_].mButton.addEventListener(MouseEvent.MOUSE_UP,me_CLICKBUTTON);
            }
            else
            {
                bList[_loc5_].mButton.visible = false;
            }
        }
    }
}
