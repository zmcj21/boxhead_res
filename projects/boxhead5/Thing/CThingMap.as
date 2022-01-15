package Thing
{
    import Landscape.CLandscape;
    import World.CWMCell;
    import World.CWorld;
    import World.CWorldMap;
    import flash.geom.Point;
    
    public class CThingMap extends CThingDraw
    {
        
        public static var mThingContainer:CThingContainer;
        
        private static var _World:CWorld;
        
        public static var mLandscape:CLandscape;
        
        public static var mMap:CWorldMap;
         
        
        public var mCellCurrent:CWMCell;
        
        private var mCollideCell:CWMCell;
        
        public var mNavRange:int;
        
        private var mCollideFlags:int;
        
        public function CThingMap()
        {
            super();
        }
        
        public static function get mWorld() : CWorld
        {
            return _World;
        }
        
        public static function set mWorld(param1:CWorld) : void
        {
            _World = param1;
            mMap = _World.mMap;
            mThingContainer = _World.mThingContainer;
        }
        
        public function GetAltitudeXY(param1:int, param2:int) : Number
        {
            return mLandscape.GetAltitudeAt(param1,param2);
        }
        
        public function DistanceToCell(param1:CWMCell) : Number
        {
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            _loc2_ = param1.mapX + 0.5 - 0;
            _loc3_ = param1.mapY + 0.5 - 0;
            return Math.sqrt(_loc3_ * _loc3_ + _loc2_ * _loc2_);
        }
        
        public function GetAltitude() : Number
        {
            return mLandscape.GetAltitudeAt(mPosition.x,mPosition.y);
        }
        
        public function MapMove() : Boolean
        {
            if(false && false)
            {
                return false;
            }
            mCellCurrent.RemoveThing(this);
            MapAdd();
            return true;
        }
        
        public function RenderPosition(param1:CThingV3) : Point
        {
            return mLandscape.mLSThingDraw.RenderPosition(param1);
        }
        
        public function NavMapRemove() : void
        {
            mMap.NavMapRemove(this);
        }
        
        public function GetRandomInitCell(param1:int = 65535) : CWMCell
        {
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            var _loc5_:* = null;
            _loc2_ = 100;
            while(_loc2_)
            {
                _loc3_ = RandomInt(mMap.mWidth);
                _loc4_ = RandomInt(mMap.mHeight);
                if(((_loc5_ = mMap.QGetCellAt(_loc3_,_loc4_)).mCollide & param1) == 0)
                {
                    return _loc5_;
                }
                _loc2_--;
            }
            return null;
        }
        
        public function DrawScorch() : void
        {
            mLandscape.mLSDraw.DrawScorch(mPosition.x,mPosition.y);
        }
        
        override public function toString() : String
        {
            var _loc1_:* = null;
            _loc1_ = super.toString();
            return _loc1_ + (" mCollideFlags:" + String(mCollideFlags));
        }
        
        public function GetThingsRadius(param1:int = 16775167, param2:int = 1, param3:CThingV3 = null) : Array
        {
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            _loc4_ = new Array();
            _loc5_ = !!param3 ? mPosition.Clone().Add(param3) : mPosition;
            for each(_loc6_ in mMap.GetThingsRadius(_loc5_.x,_loc5_.y,mCollideRadius))
            {
                if((param1 & _loc6_.mAffectFlags) != 0)
                {
                    if(_loc6_.mCollideID != mCollideID)
                    {
                        if(_loc5_.Distance2D(_loc6_.mPosition) <= _loc6_.mCollideRadius + mCollideRadius)
                        {
                            _loc4_.push(_loc6_);
                            if(_loc4_.length >= param2)
                            {
                                break;
                            }
                        }
                    }
                }
            }
            return _loc4_;
        }
        
        public function NavMapAdd(param1:int = 10000) : void
        {
            this.mNavRange = param1;
            mMap.NavMapAdd(this);
        }
        
        public function SetPosition(param1:Number, param2:Number, param3:Number = 0) : void
        {
            mPosition = new CThingV3(param1,param2,param3);
        }
        
        public function SetCollide(param1:CWMCell, param2:uint) : void
        {
            if(mCollideCell)
            {
                ClearCollide();
            }
            mCollideFlags = param2;
            mCollideCell = param1;
            mCollideCell.mCollide = 0 | mCollideFlags;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingMap";
        }
        
        public function SetPositionByInitObject(param1:Object) : void
        {
            var _loc2_:* = null;
            if(param1.mPosition)
            {
                SetPosition(param1.mPosition.x,param1.mPosition.y);
            }
            else if(param1.mInitCell)
            {
                SetPosition(param1.mInitCell.mapX + 0.5,param1.mInitCell.mapY + 0.5);
            }
            else
            {
                _loc2_ = GetRandomInitCell();
                if(!_loc2_)
                {
                    return;
                }
                SetPosition(_loc2_.mapX + 0.5,_loc2_.mapY + 0.5);
            }
        }
        
        public function MapAdd() : void
        {
            mCellCurrent = mMap.AddThing(this);
            mMoved = true;
        }
        
        public function GetThingsLine(param1:CThingV3, param2:Number = 0, param3:int = 16775167, param4:int = 1) : Object
        {
            return mMap.GetThingsLine(this.mCollideID,mPosition.toPoint,param1.toPoint,param2,param3,param4);
        }
        
        public function MapRemove() : void
        {
            mCellCurrent.RemoveThing(this);
            mCellCurrent = null;
        }
        
        public function ClearCollide() : void
        {
            if(mCollideCell)
            {
                mCollideCell.mCollide = 0 & ~mCollideFlags;
                mCollideCell = null;
            }
        }
        
        public function GetThingsAngle(param1:Number, param2:Number = 0, param3:int = 16775167, param4:int = 1) : Object
        {
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:* = null;
            _loc5_ = mPosition.toPoint;
            (_loc6_ = mAngle.pDelta).normalize(param1);
            _loc7_ = _loc5_.add(_loc6_);
            return mMap.GetThingsLine(this.mCollideID,_loc5_,_loc7_,param2,param3,param4);
        }
        
        public function DrawBlood() : void
        {
            mLandscape.mLSDraw.DrawBloodMulti(mPosition.x,mPosition.y);
        }
        
        override public function Dispose() : void
        {
            if(mDisposed)
            {
                return;
            }
            if(mCollideCell)
            {
                ClearCollide();
            }
            if(mCellCurrent)
            {
                MapRemove();
            }
            super.Dispose();
        }
    }
}
