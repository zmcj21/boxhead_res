package Landscape
{
    import Game.CGame;
    import STC9.System.Profiler.CFPS;
    import Thing.CThing;
    import Thing.CThingV3;
    import World.CWMSearchArea;
    import World.CWorldMap;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    public class CLSThingDraw extends Sprite
    {
        
        public static const mDebug:Boolean = false;
        
        private static const xProjection:int = CLSDraw.xProjection;
        
        private static const yProjection:int = CLSDraw.yProjection;
        
        private static const zProjection:Number = CLSDraw.zProjection;
        
        public static const zPoint:Point = new Point(0,0);
        
        public static var renderPosition:Point;
         
        
        private var yPitch:int;
        
        private var mCellIndicator:Cell_Indicator;
        
        private var mDrawList:Array;
        
        private var mFillLayer:Sprite;
        
        private var xPitch:int;
        
        private var mLineLayer:Sprite;
        
        private var _WorldMap:CWorldMap;
        
        public function CLSThingDraw()
        {
            super();
            mCellIndicator = new Cell_Indicator();
        }
        
        public function Draw(param1:Rectangle) : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = undefined;
            renderPosition = param1.topLeft;
            _loc2_ = new CWMSearchArea(param1.x / 0 - 1,param1.y / 0,param1.width / 0 + 1,param1.height / 0 + 2);
            mDrawList = _WorldMap.GetThings(_loc2_);
            CGame.mFPS.StartProfile("TDraw_Sort");
            mDrawList.sort(SortThing);
            CGame.mFPS.StopProfile("TDraw_Sort");
            CGame.mFPS.StartProfile("TDraw_Render");
            for each(_loc5_ in mDrawList)
            {
                _loc3_ = _loc5_.mPosition;
                (_loc4_ = _loc5_.mRenderPosition).x = _loc3_.x * xProjection - 0;
                _loc4_.y = (!!_loc3_.z ? _loc3_.y * yProjection - _loc3_.z * zProjection : _loc3_.y * yProjection) - 0;
                _loc5_.Render();
            }
            CGame.mFPS.StopProfile("TDraw_Render");
            CFPS.AddDebug("TDraw_Count",String(mDrawList.length));
        }
        
        public function get _CLASSID_() : String
        {
            return "CLSThingDraw";
        }
        
        private function SortThing(param1:CThing, param2:CThing) : Number
        {
            return param1.mPosition.y > param2.mPosition.y ? 1 : (param1.mPosition.y < param2.mPosition.y ? -1 : Number(0));
        }
        
        public function set mWorldMap(param1:CWorldMap) : void
        {
            _WorldMap = param1;
            xPitch = _WorldMap.mWidth;
            yPitch = _WorldMap.mHeight;
        }
        
        public function RenderPosition(param1:CThingV3) : Point
        {
            return new Point(param1.x * 0 - 0,param1.y * 0 - param1.z * 0 - 0);
        }
    }
}
