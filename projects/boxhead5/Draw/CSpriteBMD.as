package Draw
{
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.display.Graphics;
    import flash.display.MovieClip;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    
    public class CSpriteBMD extends BitmapData
    {
        
        public static var mDrawColorTransform:ColorTransform = new ColorTransform();
         
        
        public var mDisplacement:Point;
        
        public var mData:Object;
        
        public function CSpriteBMD(param1:int, param2:int, param3:Boolean = true, param4:uint = 16711680)
        {
            super(param1,param2,param3,param4);
            mData = new Object();
            mDisplacement = new Point();
        }
        
        public static function asBitmapData(param1:BitmapData, param2:Point, param3:Number = 1, param4:Array = null) : CSpriteBMD
        {
            var _loc5_:* = null;
            (_loc5_ = new CSpriteBMD(param1.width,param1.height)).copyPixels(param1,param1.rect,new Point(0,0));
            _loc5_.mDisplacement = param2;
            return _loc5_.ClipBMD();
        }
        
        public static function asMovieClip(param1:MovieClip, param2:Number = 1, param3:Number = 1, param4:Array = null) : CSpriteBMD
        {
            param1.gotoAndStop(param2);
            return asDisplayObject(param1,param3,param4);
        }
        
        public static function asDisplayObject(param1:DisplayObject, param2:Number = 1, param3:Array = null) : CSpriteBMD
        {
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            param1.filters = !!param3 ? param3 : [];
            (_loc4_ = param1.getBounds(param1)).inflate(1,1);
            _loc4_.left = Math.floor(_loc4_.left * param2);
            _loc4_.right = Math.floor(_loc4_.right * param2);
            _loc4_.top = Math.ceil(_loc4_.top * param2);
            _loc4_.bottom = Math.ceil(_loc4_.bottom * param2);
            (_loc5_ = _loc4_.width == 0 || _loc4_.height == 0 ? new CSpriteBMD(1,1) : new CSpriteBMD(_loc4_.width,_loc4_.height)).mDisplacement = new Point(_loc4_.x,_loc4_.y);
            (_loc6_ = new Matrix()).scale(param2,param2);
            _loc6_.translate(-_loc5_.mDisplacement.x,-_loc5_.mDisplacement.y);
            _loc5_.draw(param1,_loc6_,undefined,"normal",undefined,false);
            return _loc5_.ClipBMD();
        }
        
        private function ClipBMD() : CSpriteBMD
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            _loc1_ = this.rect;
            _loc2_ = this.getColorBoundsRect(4278190080,0,false);
            if(_loc2_.width == 0 || _loc2_.height == 0)
            {
                this.dispose();
                return new CSpriteBMD(1,1);
            }
            _loc3_ = new CSpriteBMD(_loc2_.width,_loc2_.height);
            _loc3_.mDisplacement = this.mDisplacement.add(_loc2_.topLeft);
            (_loc4_ = this.getPixels(_loc2_)).position = 0;
            _loc3_.setPixels(_loc3_.rect,_loc4_);
            this.dispose();
            return _loc3_;
        }
        
        public function toString() : String
        {
            return _CLASSID_;
        }
        
        public function DrawGFX(param1:Graphics, param2:int, param3:int, param4:Number = 1) : *
        {
            param1.beginBitmapFill(this,new Matrix(1,0,0,1,param2 + mDisplacement.x,param3 + mDisplacement.y));
            param1.drawRect(param2 + mDisplacement.x,param3 + mDisplacement.y,this.width,this.height);
            param1.endFill();
        }
        
        public function get _CLASSID_() : String
        {
            return "CSpriteBMD";
        }
        
        public function Draw(param1:BitmapData, param2:int, param3:int, param4:Number = 1, param5:Number = 1) : void
        {
            var _loc6_:* = null;
            if(param4 == 1 && param5 == 1)
            {
                _loc6_ = new Point(param2 + mDisplacement.x,param3 + mDisplacement.y);
                param1.copyPixels(this,this.rect,_loc6_,null,null,false);
            }
            else
            {
                mDrawColorTransform.alphaMultiplier = param4;
                param1.draw(this,new Matrix(param5,0,0,param5,param2 + 0 * param5,param3 + 0 * param5),mDrawColorTransform);
            }
        }
    }
}
