package STC9.Math
{
    import flash.geom.Matrix;
    import flash.geom.Point;
    
    public class CFLMatrix extends Matrix
    {
         
        
        public function CFLMatrix(param1:Number = 1, param2:Number = 0, param3:Number = 0, param4:Number = 1, param5:Number = 0, param6:Number = 0)
        {
            super(param1,param2,param3,param4,param5,param6);
        }
        
        private static function N0(param1:Number) : Number
        {
            return param1 == 0 || !isFinite(param1) ? 0.000001 : Number(param1);
        }
        
        public static function RemapPlane(param1:Array, param2:Array) : CFLMatrix
        {
            var _loc3_:* = null;
            _loc3_ = PlaneMatrix(param1[0],param1[1],param1[2]);
            _loc3_.invert();
            _loc3_.concat(PlaneMatrix(param2[0],param2[1],param2[2]));
            return _loc3_;
        }
        
        public static function PlaneMatrix(param1:Point, param2:Point, param3:Point) : CFLMatrix
        {
            var _loc4_:Boolean = false;
            var _loc5_:Number = NaN;
            var _loc6_:Number = NaN;
            var _loc7_:* = null;
            var _loc8_:Number = NaN;
            var _loc9_:Number = NaN;
            var _loc10_:Number = NaN;
            var _loc11_:Number = NaN;
            var _loc12_:* = null;
            _loc5_ = param2.x - param1.x;
            _loc6_ = param3.y - param1.y;
            var _loc13_:* = Math.abs(_loc5_) < 0.000001 || Math.abs(_loc6_) < 0.000001;
            _loc4_ = Math.abs(_loc5_) < 0.000001 || Math.abs(_loc6_) < 0.000001;
            if(_loc13_)
            {
                (_loc12_ = new CFLMatrix()).rotate(0);
                param1 = _loc12_.transformPoint(param1);
                param2 = _loc12_.transformPoint(param2);
                param3 = _loc12_.transformPoint(param3);
            }
            param2 = param2.subtract(param1);
            param3 = param3.subtract(param1);
            _loc7_ = new CFLMatrix();
            _loc8_ = N0(param2.x);
            _loc9_ = N0(param3.y);
            _loc7_.scale(_loc8_,_loc9_);
            _loc10_ = N0(param2.y / param2.x);
            _loc11_ = N0(param3.x / param3.y);
            _loc7_.skew(_loc10_,_loc11_);
            _loc7_.translate(param1.x,param1.y);
            if(_loc4_)
            {
                _loc7_.rotate(0);
            }
            return _loc7_;
        }
        
        public static function Rotate_Matrix(param1:Number) : CFLMatrix
        {
            var _loc2_:* = null;
            _loc2_ = new CFLMatrix();
            _loc2_.rotate(param1);
            return _loc2_;
        }
        
        public function skew(param1:Number, param2:Number) : void
        {
            this.concat(new CFLMatrix(1,param1,param2,1,0,0));
        }
        
        public function flipAbout(param1:Boolean, param2:Boolean, param3:Point) : void
        {
            this.translate(-param3.x,-param3.y);
            this.flip(param1,param2);
            this.translate(param3.x,param3.y);
        }
        
        public function scaleAbout(param1:Number, param2:Number, param3:Point) : void
        {
            this.translate(-param3.x,-param3.y);
            this.scale(param1,param2);
            this.translate(param3.x,param3.y);
        }
        
        public function get _CLASSID_() : String
        {
            return "CFLMatrix";
        }
        
        public function flip(param1:Boolean, param2:Boolean) : void
        {
            this.scale(!!param1 ? -1 : Number(1),!!param2 ? -1 : Number(1));
        }
        
        public function rotateAbout(param1:Number, param2:Point) : void
        {
            this.translate(-param2.x,-param2.y);
            this.rotate(param1);
            this.translate(param2.x,param2.y);
        }
        
        public function get _BASECLASSID_() : String
        {
            return "CFLMatrix";
        }
        
        public function Clone() : CFLMatrix
        {
            return new CFLMatrix(a,b,c,d,tx,ty);
        }
    }
}
