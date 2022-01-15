package STC9.Math
{
    import flash.geom.Point;
    
    public class CVector3
    {
         
        
        public var x:Number;
        
        public var y:Number;
        
        public var z:Number;
        
        public function CVector3(param1:Number = 0, param2:Number = 0, param3:Number = 0)
        {
            super();
            x = param1;
            y = param2;
            z = param3;
        }
        
        static function Average(param1:Array) : CVector3
        {
            var _loc2_:* = null;
            var _loc3_:* = NaN;
            _loc2_ = param1[0].Clone();
            _loc3_ = 1;
            while(_loc3_ < param1.length)
            {
                _loc2_.Add(param1[_loc3_]);
                _loc3_++;
            }
            return new CVector3(_loc2_.x / param1.length,_loc2_.y / param1.length,_loc2_.z / param1.length);
        }
        
        function Set(param1:CVector3) : CVector3
        {
            x = param1.x;
            y = param1.y;
            z = param1.z;
            return this;
        }
        
        function Normalize(param1:Number) : CVector3
        {
            if(this._Length() != 0)
            {
                this.ScaleN(param1 / this._Length());
            }
            return this;
        }
        
        function DotProduct(param1:CVector3) : Number
        {
            return x * param1.x + y * param1.y + z * param1.z;
        }
        
        function Add(param1:CVector3) : CVector3
        {
            x += param1.x;
            y += param1.y;
            z += param1.z;
            return this;
        }
        
        function Inverse() : CVector3
        {
            return new CVector3(-x,-y,-z);
        }
        
        function Abs() : CVector3
        {
            return new CVector3(Math.abs(x),Math.abs(y),Math.abs(z));
        }
        
        function Distance(param1:CVector3) : Number
        {
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            var _loc4_:Number = NaN;
            _loc2_ = x - param1.x;
            _loc3_ = y - param1.y;
            _loc4_ = z - param1.z;
            return Math.sqrt(_loc2_ * _loc2_ + _loc3_ * _loc3_ + _loc4_ * _loc4_);
        }
        
        function Precision(param1:Number) : *
        {
            var _loc2_:Number = NaN;
            _loc2_ = param1 == 0 ? 1 : Number(Math.pow(10,param1));
            x = Math.round(x * _loc2_) / _loc2_;
            y = Math.round(y * _loc2_) / _loc2_;
            z = Math.round(z * _loc2_) / _loc2_;
            return this;
        }
        
        function Equals(param1:CVector3) : Boolean
        {
            return x == param1.x && y == param1.y && z == param1.z;
        }
        
        function Sub(param1:CVector3) : CVector3
        {
            x -= param1.x;
            y -= param1.y;
            z -= param1.z;
            return this;
        }
        
        function ScaleN(param1:Number) : CVector3
        {
            x *= param1;
            y *= param1;
            z *= param1;
            return this;
        }
        
        function _Length() : Number
        {
            return Math.sqrt(x * x + y * y + z * z);
        }
        
        function Scale(param1:CVector3) : CVector3
        {
            x *= param1.x;
            y *= param1.y;
            z *= param1.z;
            return this;
        }
        
        public function get _CLASSID_() : String
        {
            return "CVector3";
        }
        
        public function toString() : String
        {
            return _CLASSID_;
        }
        
        function Clear() : CVector3
        {
            x = 0;
            y = 0;
            z = 0;
            return this;
        }
        
        function CrossProduct(param1:CVector3) : CVector3
        {
            return new CVector3(y * param1.z - z * param1.y,z * param1.x - x * param1.z,x * param1.y - y * param1.x);
        }
        
        function Equals0() : Boolean
        {
            return x == 0 && y == 0 && z == 0;
        }
        
        public function ToPoint() : Point
        {
            return new Point(x,y);
        }
        
        function Invert() : CVector3
        {
            x = -x;
            y = -y;
            z = -z;
            return this;
        }
        
        public function get _BASECLASSID_() : String
        {
            return "CVector3";
        }
        
        function Clone() : CVector3
        {
            return new CVector3(x,y,z);
        }
        
        function RotateY(param1:Number) : *
        {
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            var _loc4_:Number = NaN;
            var _loc5_:Number = NaN;
            _loc2_ = Math.cos(param1);
            _loc3_ = Math.sin(param1);
            _loc4_ = this.x * _loc2_ - this.z * _loc3_;
            _loc5_ = this.z * _loc2_ + this.x * _loc3_;
            this.x = _loc4_;
            this.z = _loc5_;
        }
        
        public function Dispose() : void
        {
        }
    }
}
