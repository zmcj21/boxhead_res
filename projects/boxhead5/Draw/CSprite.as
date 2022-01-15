package Draw
{
    public class CSprite
    {
         
        
        public var mFrame:CSpriteBMD;
        
        public var mDirections:Array;
        
        public var mDirectionAmount:int = 0;
        
        public var mFrames:Array;
        
        public var mFrameCount:int = 0;
        
        public function CSprite()
        {
            mFrameCount = 0;
            mDirectionAmount = 0;
            super();
        }
        
        public function get _CLASSID_() : String
        {
            return "CSprite";
        }
        
        public function toString() : String
        {
            return _CLASSID_;
        }
        
        public function cacheDirections() : void
        {
            var _loc1_:* = null;
            var _loc2_:int = 0;
            var _loc3_:Number = NaN;
            _loc1_ = mDirections;
            mDirections = new Array();
            mDirectionAmount = _loc1_.length;
            _loc2_ = 0;
            _loc3_ = mDirectionAmount / 256;
            while(_loc2_ < 256)
            {
                mDirections[_loc2_] = _loc1_[Math.round(_loc2_ * _loc3_) % mDirectionAmount];
                _loc2_++;
            }
        }
    }
}
