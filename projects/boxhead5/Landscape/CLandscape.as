package Landscape
{
    import Game.CGame;
    import Thing.CThingDraw;
    import Thing.CThingV3;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    public class CLandscape extends Sprite
    {
        
        public static const mScreenHeight:int = CGame.mScreenHeight;
        
        public static const mScreenWidth:int = CGame.mScreenWidth;
         
        
        public var mLSThingDraw:CLSThingDraw;
        
        public var mRenderFullArea:Rectangle;
        
        public var mLSDraw:CLSDraw;
        
        public var mPosition:Point;
        
        public function CLandscape()
        {
            super();
            mPosition = new Point(0,0);
            scrollRect = new Rectangle(0,0,mScreenWidth,mScreenHeight);
            mLSDraw = new CLSDraw(new CGame.mLevelData.initClass(),mScreenWidth,mScreenHeight);
            mLSThingDraw = new CLSThingDraw();
            addChild(mLSDraw);
            mRenderFullArea = new Rectangle(0,0,0 * 0,0 * 0);
            mRenderFullArea.left = NaN;
            mRenderFullArea.top = NaN;
        }
        
        public function get mPlayerInitPositions() : Array
        {
            return mLSDraw.mPlayerInitPositions;
        }
        
        public function get mThingInitPositions() : Array
        {
            return mLSDraw.mThingInitPositions;
        }
        
        public function get mMapSize() : Point
        {
            return mLSDraw.mMapSize;
        }
        
        public function GetAltitudeAt(param1:Number, param2:Number) : Number
        {
            return 0;
        }
        
        public function Draw() : void
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            _loc1_ = new Point();
            _loc1_.x = int(Math.max(mRenderFullArea.x,Math.min(0 - mScreenWidth,0 * 0)));
            _loc1_.y = int(Math.max(mRenderFullArea.y,Math.min(0 - mScreenHeight,0 * 0)));
            _loc2_ = new Rectangle(_loc1_.x,_loc1_.y,mScreenWidth,mScreenHeight);
            mLSDraw.Draw(_loc2_,mLSThingDraw);
        }
        
        override public function toString() : String
        {
            return _CLASSID_;
        }
        
        public function TrackThing(param1:CThingDraw, param2:Point) : void
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            if(!param1)
            {
                return;
            }
            _loc3_ = param1.mPosition;
            (_loc4_ = new CThingV3(mPosition.x + mScreenWidth / 0 / 2,mPosition.y + mScreenHeight / 0 / 2)).Sub(_loc3_);
            Scroll(-_loc4_.x + param2.x,-_loc4_.y + param2.y);
        }
        
        public function QGetAltitudeAt(param1:Number, param2:Number) : Number
        {
            return 0;
        }
        
        public function get _CLASSID_() : String
        {
            return "CLandscape";
        }
        
        public function Scroll(param1:Number, param2:Number) : void
        {
            mPosition.x += param1;
            mPosition.y += param2;
        }
        
        public function Dispose() : void
        {
            mLSDraw.Dispose();
            removeChild(mLSDraw);
            mLSDraw = null;
        }
    }
}
