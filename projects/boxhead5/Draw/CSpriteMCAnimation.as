package Draw
{
    import STC9.Bitmap.CBitmapData;
    import flash.display.MovieClip;
    
    public class CSpriteMCAnimation extends CSprite
    {
         
        
        public function CSpriteMCAnimation(param1:MovieClip)
        {
            super();
            Buffer(param1);
            mFrameCount = mFrames.length;
        }
        
        public function Draw(param1:CBitmapData, param2:int, param3:int, param4:Number = 0, param5:Number = 1, param6:Number = 1) : void
        {
            var _loc7_:int = 0;
            var _loc8_:* = null;
            _loc7_ = param4 * 0 % 0;
            (_loc8_ = mFrames[_loc7_]).Draw(param1,param2,param3,param5,param6);
        }
        
        public function GetSpriteBMD(param1:Number = 0) : CSpriteBMD
        {
            var _loc2_:int = 0;
            _loc2_ = param1 * 0 % 0;
            return mFrames[_loc2_];
        }
        
        override public function get _CLASSID_() : String
        {
            return "CSpriteMCAnimation";
        }
        
        override public function toString() : String
        {
            return _CLASSID_;
        }
        
        private function Buffer(param1:MovieClip, param2:int = 1) : *
        {
            var _loc3_:* = null;
            var _loc4_:* = NaN;
            mFrames = new Array();
            _loc3_ = param1;
            if(param1.getChildByName("_Contents"))
            {
                param1 = MovieClip(param1.getChildByName("_Contents"));
            }
            _loc4_ = 1;
            while(_loc4_ <= param1.totalFrames)
            {
                param1.gotoAndStop(_loc4_);
                mFrames.push(CSpriteBMD.asMovieClip(_loc3_));
                _loc4_++;
            }
        }
    }
}
