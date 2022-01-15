package Landscape
{
    import STC9.Bitmap.CBitmapData;
    import flash.display.Bitmap;
    import flash.display.Graphics;
    import flash.display.Sprite;
    import flash.filters.BlurFilter;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    public class CLSEffects extends Bitmap
    {
        
        public static const UPDATECOUNT:Number = 64;
        
        public static const scale:Number = 0.25;
        
        public static const zPoint:Point = new Point(0,0);
         
        
        private var mUpdateCount:int;
        
        private var mMatrixToPlane:Matrix;
        
        private var mFilter:BlurFilter;
        
        private var mMatrix:Matrix;
        
        private var mTopLayer:Sprite;
        
        public var mFillLayer:Sprite;
        
        private var _FadeArray:Array;
        
        public var mBMD:CBitmapData;
        
        public var mLineLayer:Sprite;
        
        public var mActive:Boolean;
        
        private var mRenderPos:Point;
        
        public function CLSEffects()
        {
            super(mBMD = new CBitmapData(0 * scale,0 * scale,true,0),"never",false);
            mTopLayer = new Sprite();
            mTopLayer.addChild(mLineLayer = new Sprite());
            mTopLayer.addChild(mFillLayer = new Sprite());
            mLineLayer.scaleX = mFillLayer.scaleX = scale;
            mLineLayer.scaleY = mFillLayer.scaleY = scale;
            mMatrix = new Matrix(scale,0,0,scale,0,0);
            mMatrixToPlane = new Matrix(1 / scale,0,0,1 / scale,0,0);
            mFilter = new BlurFilter(2,2,1);
            mRenderPos = new Point(0,0);
            mActive = true;
        }
        
        public function Dispose() : void
        {
            mTopLayer.removeChild(mLineLayer);
            mTopLayer.removeChild(mFillLayer);
            mLineLayer = null;
            mFillLayer = null;
            mBMD.dispose();
            mBMD = null;
        }
        
        public function Clear() : void
        {
            mLineLayer.graphics.clear();
            mFillLayer.graphics.clear();
        }
        
        public function DrawCircle(param1:int, param2:*, param3:Number, param4:Number, param5:Number) : void
        {
            var _loc6_:* = null;
            if(!mActive)
            {
                return;
            }
            (_loc6_ = mFillLayer.graphics).beginFill(param1,param2);
            _loc6_.drawCircle(param3,param4,param5);
            _loc6_.endFill();
            Update();
        }
        
        public function DrawLine(param1:Number, param2:int, param3:*, param4:Number, param5:Number, param6:Number, param7:Number) : void
        {
            var _loc8_:* = null;
            if(!mActive)
            {
                return;
            }
            (_loc8_ = mLineLayer.graphics).lineStyle(param1,param2,param3);
            _loc8_.moveTo(param4,param5);
            _loc8_.lineTo(param6,param7);
            Update();
        }
        
        public function DrawBulletSmoke(param1:Point, param2:Point) : void
        {
            var _loc3_:* = null;
            var _loc4_:int = 0;
            var _loc5_:* = null;
            var _loc6_:* = NaN;
            var _loc7_:* = null;
            if(!mActive)
            {
                return;
            }
            _loc3_ = param2.subtract(param1);
            _loc4_ = _loc3_.length / 20;
            _loc3_.normalize(20);
            _loc5_ = param1.clone();
            _loc6_ = 0.5;
            while(_loc4_ && _loc6_ > 0)
            {
                _loc7_ = _loc5_.add(_loc3_).add(new Point((Math.random() - 0.5) * 6,(Math.random() - 0.5) * 6));
                DrawLine(0,16777215,_loc6_,_loc5_.x,_loc5_.y,_loc7_.x,_loc7_.y);
                _loc4_--;
                _loc6_ -= 0.07;
                _loc5_ = _loc7_;
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CLSEffects";
        }
        
        public function Render(param1:Rectangle, param2:CBitmapData) : void
        {
            var _loc3_:* = null;
            var _loc4_:* = NaN;
            if(!mActive)
            {
                return;
            }
            if(--mUpdateCount < 0)
            {
                Scroll(param1.topLeft);
                return;
            }
            if(!_FadeArray)
            {
                _FadeArray = new Array();
                _loc4_ = 255;
                while(_loc4_ >= 0)
                {
                    _FadeArray[_loc4_] = Math.max(0,int(_loc4_ - 4)) << 24;
                    _loc4_--;
                }
            }
            mBMD.paletteMap(mBMD,mBMD.rect,zPoint,null,null,null,_FadeArray);
            _loc3_ = mTopLayer.getRect(mTopLayer);
            mBMD.draw(mTopLayer);
            Clear();
            mBMD.applyFilter(mBMD,mBMD.rect,zPoint,mFilter);
            Scroll(param1.topLeft);
            param2.draw(mBMD,mMatrixToPlane,null,null,null,false);
        }
        
        private function Update() : void
        {
            mUpdateCount = UPDATECOUNT;
        }
        
        public function Scroll(param1:Point) : void
        {
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            _loc2_ = Math.round(0 - param1.x * scale);
            _loc3_ = Math.round(0 - param1.y * scale);
            mRenderPos.x = 0 - _loc2_;
            mRenderPos.y = 0 - _loc3_;
            mBMD.scroll(_loc2_,_loc3_ - 1);
        }
        
        public function DrawSmokeLine(param1:Point, param2:Point, param3:Number = 0, param4:Number = 0.5) : void
        {
            var _loc5_:* = null;
            var _loc6_:int = 0;
            var _loc7_:* = null;
            var _loc8_:* = null;
            if(!mActive)
            {
                return;
            }
            _loc6_ = (_loc5_ = param2.subtract(param1)).length / 20;
            _loc5_.normalize(20);
            _loc7_ = param1.clone();
            while(_loc6_)
            {
                _loc8_ = _loc7_.add(_loc5_).add(new Point((Math.random() - 0.5) * 6,(Math.random() - 0.5) * 6));
                DrawLine(param3,16777215,param4 + Math.random() * 0.2,_loc7_.x,_loc7_.y,_loc8_.x,_loc8_.y);
                _loc6_--;
                _loc7_ = _loc8_;
            }
            DrawLine(param3,16777215,param4 + Math.random() * 0.2,_loc7_.x,_loc7_.y,param2.x,param2.y);
        }
    }
}
