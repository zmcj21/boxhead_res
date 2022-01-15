package Thing
{
    import flash.geom.Matrix;
    import flash.geom.Point;
    
    public class CThingV3
    {
        
        private static var mMapHeight:int;
        
        private static var mMapWidth:int;
         
        
        public var x:Number;
        
        public var y:Number;
        
        public var z:Number;
        
        public function CThingV3(param1:Number = 0, param2:Number = 0, param3:Number = 0)
        {
            super();
            x = param1;
            y = param2;
            z = param3;
        }
        
        public static function SetMapSize(param1:int, param2:int) : void
        {
            mMapWidth = param1;
            mMapHeight = param2;
        }
        
        public function Set(param1:Number = 0, param2:Number = 0, param3:Number = 0) : CThingV3
        {
            x = param1;
            y = param2;
            z = param3;
            return this;
        }
        
        public function Clone() : CThingV3
        {
            var _loc1_:* = null;
            _loc1_ = new CThingV3();
            _loc1_.x = x;
            _loc1_.y = y;
            _loc1_.z = z;
            return _loc1_;
        }
        
        public function get mLength2D() : Number
        {
            return Math.sqrt(x * x + y * y);
        }
        
        public function RotateZ(param1:Number) : CThingV3
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            _loc2_ = new Matrix();
            _loc2_.rotate(param1);
            _loc3_ = _loc2_.transformPoint(new Point(x,y));
            x = _loc3_.x;
            y = _loc3_.y;
            return this;
        }
        
        public function Add(param1:CThingV3) : CThingV3
        {
            x += param1.x;
            y += param1.y;
            z += param1.z;
            return this;
        }
        
        public function get mMapX() : uint
        {
            return x & 16777215;
        }
        
        public function get mMapY() : uint
        {
            return y & 16777215;
        }
        
        public function get mLength() : Number
        {
            return Math.sqrt(x * x + y * y + z * z);
        }
        
        public function RotateX(param1:Number) : CThingV3
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            _loc2_ = new Matrix();
            _loc2_.rotate(param1);
            _loc3_ = _loc2_.transformPoint(new Point(z,y));
            z = _loc3_.x;
            y = _loc3_.y;
            return this;
        }
        
        public function get mCellX() : Number
        {
            return x % 1;
        }
        
        public function get mCellY() : Number
        {
            return y % 1;
        }
        
        public function get toPoint() : Point
        {
            return new Point(x,y);
        }
        
        public function get mAngleRAD() : Number
        {
            return Math.atan2(y,x);
        }
        
        public function AddXY(param1:Number, param2:Number) : CThingV3
        {
            x += param1;
            y += param2;
            return this;
        }
        
        public function GetMinAndMaxRadius(param1:Number) : Object
        {
            return {
                "min":new CThingV3(x - param1,y - param1),
                "max":new CThingV3(x + param1,y + param1)
            };
        }
        
        public function Sub(param1:CThingV3) : CThingV3
        {
            x -= param1.x;
            y -= param1.y;
            z -= param1.z;
            return this;
        }
        
        public function get mCellOffset() : Point
        {
            return new Point(x % 1,y % 1);
        }
        
        public function ScaleN(param1:Number) : CThingV3
        {
            x *= param1;
            y *= param1;
            z *= param1;
            return this;
        }
        
        public function Distance2D(param1:CThingV3) : Number
        {
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            _loc2_ = x - param1.x;
            _loc3_ = y - param1.y;
            return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_);
        }
        
        public function get mCentre() : CThingV3
        {
            return new CThingV3((x & 16777215) + 0.5,(y & 16777215) + 0.5,z);
        }
        
        public function get _CLASSID_() : String
        {
            return "CThingV3";
        }
        
        public function toString() : String
        {
            return _CLASSID_ + ": " + x + "," + y + "," + z;
        }
        
        public function Normalize(param1:Number = 1) : CThingV3
        {
            var _loc2_:Number = NaN;
            _loc2_ = 1 / Math.sqrt(x * x + y * y + z * z) * param1;
            return !!isFinite(_loc2_) ? ScaleN(_loc2_) : Set(param1);
        }
        
        public function ScaleN2D(param1:Number) : CThingV3
        {
            x *= param1;
            y *= param1;
            return this;
        }
        
        public function CentreOnCell() : void
        {
            x = x % 1 + 0.5;
            y = y % 1 + 0.5;
        }
        
        public function GetAngle(param1:CThingV3) : Number
        {
            return Math.atan2(param1.y - y,param1.x - x);
        }
        
        public function RotateY(param1:Number) : CThingV3
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            _loc2_ = new Matrix();
            _loc2_.rotate(param1);
            _loc3_ = _loc2_.transformPoint(new Point(x,z));
            x = _loc3_.x;
            z = _loc3_.y;
            return this;
        }
        
        public function Normalize2D(param1:Number = 1) : CThingV3
        {
            var _loc2_:Number = NaN;
            _loc2_ = 1 / Math.sqrt(x * x + y * y) * param1;
            return !!isFinite(_loc2_) ? ScaleN2D(_loc2_) : Set(param1);
        }
    }
}
