package STC9.Sprite
{
    import STC9.Data.CByteArray;
    import flash.display.BitmapData;
    import flash.filters.GlowFilter;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    
    public class CSpriteSheet
    {
         
        
        public var mAllFrames:Array;
        
        public var mAnimations:Object;
        
        public function CSpriteSheet()
        {
            super();
            mAnimations = new Object();
        }
        
        public static function AsBitmapData(param1:BitmapData) : CSpriteSheet
        {
            var _loc2_:* = null;
            _loc2_ = new CSpriteSheet();
            _loc2_.CreateFrames(param1);
            return _loc2_;
        }
        
        public static function AsLibraryItem(param1:String) : CSpriteSheet
        {
            var _loc2_:* = null;
            return new CSpriteSheet();
        }
        
        public function CreateFrames(param1:BitmapData) : void
        {
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            var _loc4_:* = null;
            var _loc5_:int = 0;
            var _loc6_:* = null;
            var _loc7_:* = null;
            var _loc8_:int = 0;
            var _loc9_:* = null;
            var _loc10_:* = null;
            var _loc11_:* = null;
            var _loc12_:* = NaN;
            var _loc13_:* = null;
            var _loc14_:* = null;
            var _loc15_:* = null;
            _loc2_ = 0;
            _loc3_ = 0;
            mAllFrames = new Array();
            (_loc4_ = new CByteArray()).writeBytes(param1.getPixels(new Rectangle(0,0,1,1)));
            _loc4_.position = 2;
            _loc5_ = _loc4_.readShort();
            _loc6_ = param1.getPixels(new Rectangle(_loc3_,_loc2_,param1.width,_loc5_));
            (_loc7_ = new CByteArray()).writeBytes(_loc6_,_loc4_.length);
            _loc7_.position = 0;
            (_loc7_ = _loc7_.UnprotectAlpha()).position = 0;
            _loc8_ = _loc7_.readShort();
            while(_loc8_)
            {
                if(!(_loc11_ = CSpriteFrame.UnpackBytes(_loc7_)))
                {
                    break;
                }
                _loc12_ = 1;
                _loc11_.mArea.inflate(_loc12_,_loc12_);
                (_loc13_ = new CSpriteFrame(_loc11_.mArea.width,_loc11_.mArea.height)).mDisplacement = _loc11_.mArea.topLeft;
                _loc13_.mFrameIndex = _loc11_.mFrameIndex;
                _loc13_.mDirectionIndex = _loc11_.mDirectionIndex;
                _loc13_.mAnimID = _loc11_.mAnimID;
                _loc13_.mModelInfo = _loc11_.mModelInfo;
                _loc13_.copyPixels(param1,new Rectangle(_loc11_.mTopLeft.x,_loc11_.mTopLeft.y + _loc5_,_loc13_.width,_loc13_.height),new Point(_loc12_,_loc12_));
                _loc13_.applyFilter(_loc13_,_loc13_.rect,new Point(0,0),new GlowFilter(0,1,2,2,1,3));
                mAllFrames.push(_loc13_);
                _loc8_--;
            }
            _loc9_ = mAnimations;
            for each(_loc10_ in mAllFrames)
            {
                (_loc15_ = (_loc14_ = _loc9_[_loc10_.mAnimID] = !!_loc9_[_loc10_.mAnimID] ? _loc9_[_loc10_.mAnimID] : new Array())[_loc10_.mDirectionIndex] = !!_loc14_[_loc10_.mDirectionIndex] ? _loc14_[_loc10_.mDirectionIndex] : new Array())[_loc10_.mFrameIndex] = _loc10_;
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CSpriteSheet";
        }
    }
}
