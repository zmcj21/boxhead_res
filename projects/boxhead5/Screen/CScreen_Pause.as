package Screen
{
    import Game.CGame;
    import Game.CGlobalData;
    import STC9.String.CString;
    import Thing.CThingWeapon;
    import flash.display.DisplayObjectContainer;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;
    
    public class CScreen_Pause extends CScreen
    {
        
        public static const EXITGAME:String = "EXITGAME";
        
        public static const CLOSE:String = "CLOSE";
         
        
        public var mcScrollContainerRight1:MovieClip;
        
        private var mContentsRight1:Sprite;
        
        private var mContentsRight2:Sprite;
        
        public var bThisGame:SimpleButton;
        
        public var bAllTime:SimpleButton;
        
        public var mcScrollContainerRight2:MovieClip;
        
        private var mContentsLeft:Sprite;
        
        public var mcDefaultNode:ContainerNode;
        
        public var mcTopLock:MovieClip;
        
        public var bExitGame:SimpleButton;
        
        public var bClose:SimpleButton;
        
        private var mDragObject;
        
        public var mcLock:MovieClip;
        
        public var mcScrollContainerLeft:MovieClip;
        
        public var mGame:CGame;
        
        public function CScreen_Pause()
        {
            super();
            bClose.addEventListener(MouseEvent.MOUSE_UP,me_CLOSE_CLICK);
            bExitGame.addEventListener(MouseEvent.MOUSE_UP,me_EXITGAME_CLICK);
            mcLock.addEventListener(MouseEvent.MOUSE_UP,me_DUMB);
            mcTopLock.addEventListener(MouseEvent.MOUSE_UP,me_DUMB);
            mcDefaultNode.visible = false;
            mContentsLeft = SetupScrollContainer(mcScrollContainerLeft);
            mContentsRight1 = SetupScrollContainer(mcScrollContainerRight1);
            mContentsRight2 = SetupScrollContainer(mcScrollContainerRight2);
            bThisGame.addEventListener(MouseEvent.MOUSE_UP,me_DISPLAYTHISGAME_CLICK);
            bAllTime.addEventListener(MouseEvent.MOUSE_UP,me_DISPLAYALLTIME_CLICK);
            mcTopLock.visible = false;
        }
        
        private function me_EXITGAME_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            Deactivate();
            dispatchEvent(new Event(EXITGAME));
            dispatchEvent(new Event(CLOSE));
        }
        
        override public function Activate(param1:String = "FADEIN") : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            visible = true;
            _loc2_ = mGame.mWorld.mTrackThing.mUpgrades;
            _loc3_ = mGame.mWorld.mTrackThing.mDefaultUpgrades;
            for each(_loc4_ in _loc3_)
            {
                AddUpgrade(_loc4_,_UpgradeExists(_loc4_,_loc2_));
            }
            AddStats(CGlobalData.mLocalStats,mContentsRight1);
            AddStats(CGlobalData.mStats,mContentsRight2);
            mContentsLeft.cacheAsBitmap = true;
            mContentsRight1.cacheAsBitmap = true;
            mContentsRight2.cacheAsBitmap = true;
            me_DISPLAYTHISGAME_CLICK();
        }
        
        private function SetupScrollContainer(param1:MovieClip) : Sprite
        {
            var _loc2_:* = null;
            param1.scrollRect = new Rectangle(0,0,param1.width,param1.height);
            _loc2_ = new Sprite();
            param1.addChild(_loc2_);
            param1.useHandCursor = true;
            _loc2_.addEventListener(MouseEvent.MOUSE_DOWN,e_SCROLLCONTAINER_START);
            return _loc2_;
        }
        
        private function me_CLOSE_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            Deactivate();
            dispatchEvent(new Event(CLOSE));
        }
        
        private function e_SCROLLCONTAINER_START(param1:MouseEvent) : void
        {
            var _loc2_:* = undefined;
            mDragObject = param1.currentTarget;
            mDragObject.addEventListener(MouseEvent.MOUSE_UP,e_SCROLLCONTAINER_STOP);
            stage.addEventListener(MouseEvent.MOUSE_UP,e_SCROLLCONTAINER_STOP);
            _loc2_ = mDragObject.parent;
            mDragObject.startDrag(false,new Rectangle(0,-(0 - _loc2_.height),0,0 - _loc2_.height));
        }
        
        private function AddUpgrade(param1:Object, param2:Boolean) : void
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            mContentsLeft.addChild(_loc3_ = new ContainerNode());
            _loc5_ = (_loc4_ = new param1.mClassID(null)).mUpgrades[param1.mUpgrade].mName;
            _loc3_.tfLeft.text = _loc4_.mWeaponName + ": " + (param1.mUpgrade == 0 ? "**NEW**" : _loc5_);
            _loc3_.tfRight.text = param1.mIndex.toString();
            _loc3_.alpha = !!param2 ? 0.3 : Number(1);
            _loc3_.y = -1 * _loc3_.height;
        }
        
        private function AddStat(param1:String, param2:String, param3:DisplayObjectContainer) : void
        {
            var _loc4_:* = null;
            param3.addChild(_loc4_ = new ContainerNode());
            _loc4_.tfLeft.text = param1;
            _loc4_.tfRight.text = param2;
            _loc4_.y = (param3.numChildren - 1) * _loc4_.height;
        }
        
        private function _UpgradeExists(param1:Object, param2:Array) : Boolean
        {
            var _loc3_:* = null;
            for each(_loc3_ in param2)
            {
                if(_loc3_.mUpgrade == param1.mUpgrade)
                {
                    if(_loc3_.mIndex == param1.mIndex)
                    {
                        if(_loc3_.mClassID == param1.mClassID)
                        {
                            return true;
                        }
                    }
                }
            }
            return false;
        }
        
        override public function Deactivate(param1:String = "FADEOUT") : void
        {
            bClose.removeEventListener(MouseEvent.MOUSE_UP,me_CLOSE_CLICK);
            bExitGame.removeEventListener(MouseEvent.MOUSE_UP,me_EXITGAME_CLICK);
            visible = false;
        }
        
        private function AddStats(param1:Object, param2:DisplayObjectContainer) : void
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            _loc3_ = new Array();
            for(_loc4_ in param1)
            {
                _loc3_.push(_loc4_);
            }
            _loc3_.sort();
            for each(_loc4_ in _loc3_)
            {
                AddStat(_loc4_,CString.FormatAsNumber(param1[_loc4_].toString()),param2);
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CScreen_Pause";
        }
        
        private function me_DISPLAYTHISGAME_CLICK(param1:MouseEvent = null) : void
        {
            mcScrollContainerRight1.visible = true;
            mcScrollContainerRight2.visible = false;
            bThisGame.alpha = 1;
            bAllTime.alpha = 0.5;
        }
        
        private function me_DISPLAYALLTIME_CLICK(param1:MouseEvent = null) : void
        {
            mcScrollContainerRight1.visible = false;
            mcScrollContainerRight2.visible = true;
            bThisGame.alpha = 0.5;
            bAllTime.alpha = 1;
        }
        
        private function e_SCROLLCONTAINER_STOP(param1:MouseEvent) : void
        {
            mDragObject.removeEventListener(MouseEvent.MOUSE_UP,e_SCROLLCONTAINER_STOP);
            stage.removeEventListener(MouseEvent.MOUSE_UP,e_SCROLLCONTAINER_STOP);
            mDragObject.stopDrag();
        }
    }
}
