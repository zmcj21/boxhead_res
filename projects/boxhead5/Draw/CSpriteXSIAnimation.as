package Draw
{
    import Landscape.CLSDraw;
    import STC9.Bitmap.CBitmapData;
    import STC9.Sprite.CSpriteFrame;
    import STC9.Sprite.CSpriteSheet;
    import Thing.CThingV3;
    import flash.display.Bitmap;
    
    public class CSpriteXSIAnimation extends CSprite
    {
         
        
        public function CSpriteXSIAnimation()
        {
            super();
        }
        
        public static function asSpriteSheet(param1:CSpriteSheet, param2:Boolean = false) : Object
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:* = null;
            var _loc8_:* = null;
            var _loc9_:* = null;
            var _loc10_:* = null;
            var _loc11_:* = null;
            var _loc12_:* = null;
            var _loc13_:* = null;
            _loc3_ = new Object();
            _loc4_ = new ShadowMaker();
            _loc5_ = new Bitmap(null);
            _loc6_ = new Bitmap(null);
            _loc7_ = new Bitmap(null);
            _loc4_._Container.addChild(_loc5_);
            _loc4_._Shadow1.addChild(_loc6_);
            _loc4_._Shadow2.addChild(_loc7_);
            for each(_loc8_ in param1.mAllFrames)
            {
                _loc8_.mAnimID = _loc8_.mAnimID.toLowerCase();
                _loc10_ = _loc3_[_loc8_.mAnimID] = !!_loc3_[_loc8_.mAnimID] ? _loc3_[_loc8_.mAnimID] : new CSpriteXSIAnimation();
                _loc12_ = (_loc11_ = _loc10_.mDirections = !!_loc10_.mDirections ? _loc10_.mDirections : new Array())[_loc8_.mDirectionIndex] = !!_loc11_[_loc8_.mDirectionIndex] ? _loc11_[_loc8_.mDirectionIndex] : new Array();
                _loc7_.bitmapData = _loc6_.bitmapData = _loc5_.bitmapData = _loc8_;
                _loc7_.x = _loc6_.x = _loc5_.x = _loc8_.mDisplacement.x;
                _loc7_.y = _loc6_.y = _loc5_.y = _loc8_.mDisplacement.y;
                (_loc13_ = _loc12_[_loc8_.mFrameIndex] = CSpriteBMD.asDisplayObject(_loc4_)).mData.mModelInfo = FormatModelInfo(_loc8_.mModelInfo);
            }
            if(param2)
            {
                for each(_loc9_ in _loc3_)
                {
                    _loc9_.ConvertFramesToDirections();
                }
            }
            for each(_loc9_ in _loc3_)
            {
                _loc9_.cacheDirections();
                _loc9_.mFrameCount = _loc9_.mDirections[0].length;
            }
            return _loc3_;
        }
        
        private static function FormatModelInfo(param1:Object) : Object
        {
            var _loc2_:* = NaN;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            _loc2_ = Infinity;
            for each(_loc3_ in param1)
            {
                _loc4_ = _loc3_.mDirection;
                _loc5_ = _loc3_.mPosition;
                _loc3_.mDirection = new CThingV3(_loc4_.x,_loc4_.z,-_loc4_.y);
                _loc3_.mPosition = new CThingV3(_loc5_.x,_loc5_.z,-_loc5_.y).ScaleN(_loc2_);
            }
            return param1;
        }
        
        public function Draw(param1:CBitmapData, param2:int, param3:int, param4:uint = 0, param5:Number = 0, param6:Number = 1) : void
        {
            var _loc7_:int = 0;
            var _loc8_:* = null;
            _loc7_ = param5 * mFrameCount % mFrameCount;
            (_loc8_ = mDirections[param4][_loc7_]).Draw(param1,param2,param3,param6);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CSpriteXSIAnimation";
        }
        
        override public function toString() : String
        {
            return _CLASSID_;
        }
        
        public function GetData(param1:uint = 0, param2:Number = 0) : Object
        {
            var _loc3_:int = 0;
            _loc3_ = param2 * mFrameCount % mFrameCount;
            return mDirections[param1][_loc3_].mData;
        }
        
        private function ConvertFramesToDirections() : void
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            _loc1_ = new Array();
            for each(_loc2_ in mDirections[0])
            {
                _loc1_.push([_loc2_]);
            }
            mDirections = _loc1_;
        }
    }
}
