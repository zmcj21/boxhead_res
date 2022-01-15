package STC9.Math
{
    public class CMatrix4
    {
         
        
        private var mE10:Number;
        
        private var mE11:Number;
        
        private var mE12:Number;
        
        private var mE13:Number;
        
        private var mE20:Number;
        
        private var mE22:Number;
        
        private var mE23:Number;
        
        private var mE21:Number;
        
        private var mE30:Number;
        
        private var mE31:Number;
        
        private var mE32:Number;
        
        private var mE33:Number;
        
        private var mE00:Number;
        
        private var mE01:Number;
        
        private var mE02:Number;
        
        private var mE03:Number;
        
        public function CMatrix4()
        {
            super();
            Identity();
        }
        
        static function Translate_Matrix(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : CMatrix4
        {
            var _loc5_:* = null;
            _loc5_ = CMatrix4.Identity_Matrix();
            if(param4)
            {
                _loc5_.mE30 = -param1;
                _loc5_.mE31 = -param2;
                _loc5_.mE32 = -param3;
            }
            else
            {
                _loc5_.mE30 = param1;
                _loc5_.mE31 = param2;
                _loc5_.mE32 = param3;
            }
            return _loc5_;
        }
        
        public static function Identity_Matrix() : CMatrix4
        {
            var _loc1_:* = null;
            _loc1_ = new CMatrix4();
            _loc1_.mE00 = 1;
            _loc1_.mE01 = 0;
            _loc1_.mE02 = 0;
            _loc1_.mE03 = 0;
            _loc1_.mE10 = 0;
            _loc1_.mE11 = 1;
            _loc1_.mE12 = 0;
            _loc1_.mE13 = 0;
            _loc1_.mE20 = 0;
            _loc1_.mE21 = 0;
            _loc1_.mE22 = 1;
            _loc1_.mE23 = 0;
            _loc1_.mE30 = 0;
            _loc1_.mE31 = 0;
            _loc1_.mE32 = 0;
            _loc1_.mE33 = 1;
            return _loc1_;
        }
        
        public static function RotateX_Matrix(param1:Number) : CMatrix4
        {
            var _loc2_:* = null;
            _loc2_ = Identity_Matrix();
            _loc2_.mE11 = Math.cos(param1);
            _loc2_.mE12 = -Math.sin(param1);
            _loc2_.mE21 = Math.sin(param1);
            _loc2_.mE22 = Math.cos(param1);
            return _loc2_;
        }
        
        static function RotateXYZ_Matrix(param1:Number, param2:Number, param3:Number) : CMatrix4
        {
            return undefined;
        }
        
        public static function Scale_Matrix(param1:Number, param2:Number, param3:Number) : CMatrix4
        {
            var _loc4_:* = null;
            (_loc4_ = CMatrix4.Identity_Matrix()).mE00 = param1;
            _loc4_.mE11 = param2;
            _loc4_.mE22 = param3;
            return _loc4_;
        }
        
        public static function RotateZ_Matrix(param1:Number) : CMatrix4
        {
            var _loc2_:* = null;
            _loc2_ = Identity_Matrix();
            _loc2_.mE00 = Math.cos(param1);
            _loc2_.mE01 = -Math.sin(param1);
            _loc2_.mE10 = -_loc2_.mE01;
            _loc2_.mE11 = _loc2_.mE00;
            return _loc2_;
        }
        
        public static function RotateY_Matrix(param1:Number) : CMatrix4
        {
            var _loc2_:* = null;
            _loc2_ = Identity_Matrix();
            _loc2_.mE00 = Math.cos(param1);
            _loc2_.mE02 = Math.sin(param1);
            _loc2_.mE20 = -Math.sin(param1);
            _loc2_.mE22 = Math.cos(param1);
            return _loc2_;
        }
        
        public function transformVectors(param1:Array, param2:Array) : void
        {
            var _loc3_:int = 0;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:Number = NaN;
            var _loc7_:Number = NaN;
            var _loc8_:Number = NaN;
            _loc3_ = param1.length - 1;
            while(_loc3_ >= 0)
            {
                _loc4_ = param1[_loc3_];
                _loc5_ = param2[_loc3_];
                _loc6_ = _loc4_.x;
                _loc7_ = _loc4_.y;
                _loc8_ = _loc4_.z;
                _loc5_.x = _loc6_ * mE00 + _loc7_ * mE10 + _loc8_ * mE20 + mE30;
                _loc5_.y = _loc6_ * mE01 + _loc7_ * mE11 + _loc8_ * mE21 + mE31;
                _loc5_.z = _loc6_ * mE02 + _loc7_ * mE12 + _loc8_ * mE22 + mE32;
                _loc3_--;
            }
        }
        
        public function Inverse() : CMatrix4
        {
            var _loc1_:* = null;
            var _loc2_:Number = NaN;
            _loc1_ = new CMatrix4();
            _loc1_.mE00 = -mE12 * mE21 * 1 + mE11 * mE22 * 1;
            _loc1_.mE01 = mE02 * mE21 * 1 - mE01 * mE22 * 1;
            _loc1_.mE02 = -mE02 * mE11 * 1 + mE01 * mE12 * 1;
            _loc1_.mE03 = 0;
            _loc1_.mE10 = mE12 * mE20 * 1 - mE10 * mE22 * 1;
            _loc1_.mE11 = -mE02 * mE20 * 1 + mE00 * mE22 * 1;
            _loc1_.mE12 = mE02 * mE10 * 1 - mE00 * mE12 * 1;
            _loc1_.mE13 = 0;
            _loc1_.mE20 = -mE11 * mE20 * 1 + mE10 * mE21 * 1;
            _loc1_.mE21 = mE01 * mE20 * 1 - mE00 * mE21 * 1;
            _loc1_.mE22 = -mE01 * mE10 * 1 + mE00 * mE11 * 1;
            _loc1_.mE23 = 0;
            _loc1_.mE30 = 0;
            _loc1_.mE31 = 0;
            _loc1_.mE32 = 0;
            _loc1_.mE33 = 1;
            _loc2_ = 1 / Determinant();
            _loc1_.mE00 *= _loc2_;
            _loc1_.mE01 *= _loc2_;
            _loc1_.mE02 *= _loc2_;
            _loc1_.mE10 *= _loc2_;
            _loc1_.mE11 *= _loc2_;
            _loc1_.mE12 *= _loc2_;
            _loc1_.mE20 *= _loc2_;
            _loc1_.mE21 *= _loc2_;
            _loc1_.mE22 *= _loc2_;
            return _loc1_;
        }
        
        public function Copy(param1:CMatrix4) : CMatrix4
        {
            mE00 = param1.mE00;
            mE01 = param1.mE01;
            mE02 = param1.mE02;
            mE03 = param1.mE03;
            mE10 = param1.mE10;
            mE11 = param1.mE11;
            mE12 = param1.mE12;
            mE13 = param1.mE13;
            mE20 = param1.mE20;
            mE21 = param1.mE21;
            mE22 = param1.mE22;
            mE23 = param1.mE23;
            mE30 = param1.mE30;
            mE31 = param1.mE31;
            mE32 = param1.mE32;
            mE33 = param1.mE33;
            return this;
        }
        
        public function get _CLASSID_() : String
        {
            return "CMatrix4";
        }
        
        public function Scale(param1:Number, param2:Number, param3:Number) : CMatrix4
        {
            var _loc4_:* = null;
            var _loc5_:* = null;
            _loc4_ = CMatrix4.Scale_Matrix(param1,param2,param3);
            _loc5_ = this.Clone();
            return Multiply(_loc5_,_loc4_);
        }
        
        private function Determinant() : Number
        {
            return -mE02 * mE11 * mE20 + mE01 * mE12 * mE20 + mE02 * mE10 * mE21 - mE00 * mE12 * mE21 - mE01 * mE10 * mE22 + mE00 * mE11 * mE22;
        }
        
        public function MultiplyNew(param1:CMatrix4) : CMatrix4
        {
            var _loc2_:* = undefined;
            _loc2_ = new CMatrix4();
            return _loc2_.Multiply(this,param1);
        }
        
        public function Clone() : CMatrix4
        {
            var _loc1_:* = null;
            _loc1_ = new CMatrix4();
            _loc1_.mE00 = mE00;
            _loc1_.mE01 = mE01;
            _loc1_.mE02 = mE02;
            _loc1_.mE03 = mE03;
            _loc1_.mE10 = mE10;
            _loc1_.mE11 = mE11;
            _loc1_.mE12 = mE12;
            _loc1_.mE13 = mE13;
            _loc1_.mE20 = mE20;
            _loc1_.mE21 = mE21;
            _loc1_.mE22 = mE22;
            _loc1_.mE23 = mE23;
            _loc1_.mE30 = mE30;
            _loc1_.mE31 = mE31;
            _loc1_.mE32 = mE32;
            _loc1_.mE33 = mE33;
            return _loc1_;
        }
        
        public function RotateZ(param1:Number) : CMatrix4
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            _loc2_ = RotateZ_Matrix(param1);
            _loc3_ = this.Clone();
            return Multiply(_loc2_,_loc3_);
        }
        
        public function Multiply(param1:CMatrix4, param2:CMatrix4) : CMatrix4
        {
            mE00 = param1.mE00 * param2.mE00 + param1.mE01 * param2.mE10 + param1.mE02 * param2.mE20;
            mE01 = param1.mE00 * param2.mE01 + param1.mE01 * param2.mE11 + param1.mE02 * param2.mE21;
            mE02 = param1.mE00 * param2.mE02 + param1.mE01 * param2.mE12 + param1.mE02 * param2.mE22;
            mE03 = 0;
            mE10 = param1.mE10 * param2.mE00 + param1.mE11 * param2.mE10 + param1.mE12 * param2.mE20;
            mE11 = param1.mE10 * param2.mE01 + param1.mE11 * param2.mE11 + param1.mE12 * param2.mE21;
            mE12 = param1.mE10 * param2.mE02 + param1.mE11 * param2.mE12 + param1.mE12 * param2.mE22;
            mE13 = 0;
            mE20 = param1.mE20 * param2.mE00 + param1.mE21 * param2.mE10 + param1.mE22 * param2.mE20;
            mE21 = param1.mE20 * param2.mE01 + param1.mE21 * param2.mE11 + param1.mE22 * param2.mE21;
            mE22 = param1.mE20 * param2.mE02 + param1.mE21 * param2.mE12 + param1.mE22 * param2.mE22;
            mE23 = 0;
            mE30 = param1.mE30 * param2.mE00 + param1.mE31 * param2.mE10 + param1.mE32 * param2.mE20 + param2.mE30;
            mE31 = param1.mE30 * param2.mE01 + param1.mE31 * param2.mE11 + param1.mE32 * param2.mE21 + param2.mE31;
            mE32 = param1.mE30 * param2.mE02 + param1.mE31 * param2.mE12 + param1.mE32 * param2.mE22 + param2.mE32;
            mE33 = 1;
            return this;
        }
        
        public function RotateY(param1:Number) : CMatrix4
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            _loc2_ = RotateY_Matrix(param1);
            _loc3_ = this.Clone();
            return Multiply(_loc2_,_loc3_);
        }
        
        public function Translate(param1:Number, param2:Number, param3:Number, param4:Boolean = false) : CMatrix4
        {
            var _loc5_:* = null;
            var _loc6_:* = null;
            _loc5_ = Translate_Matrix(param1,param2,param3,param4);
            _loc6_ = this.Clone();
            return Multiply(_loc6_,_loc5_);
        }
        
        public function RotateX(param1:Number) : CMatrix4
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            _loc2_ = RotateX_Matrix(param1);
            _loc3_ = this.Clone();
            return Multiply(_loc2_,_loc3_);
        }
        
        public function deltaTransformVectors(param1:Array, param2:Array) : void
        {
            var _loc3_:int = 0;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:Number = NaN;
            var _loc7_:Number = NaN;
            var _loc8_:Number = NaN;
            _loc3_ = param1.length - 1;
            while(_loc3_ >= 0)
            {
                _loc4_ = param1[_loc3_];
                _loc5_ = param2[_loc3_];
                _loc6_ = _loc4_.x;
                _loc7_ = _loc4_.y;
                _loc8_ = _loc4_.z;
                _loc5_.x = _loc6_ * mE00 + _loc7_ * mE10 + _loc8_ * mE20;
                _loc5_.y = _loc6_ * mE01 + _loc7_ * mE11 + _loc8_ * mE21;
                _loc5_.z = _loc6_ * mE02 + _loc7_ * mE12 + _loc8_ * mE22;
                _loc3_--;
            }
        }
        
        public function Identity() : CMatrix4
        {
            mE00 = 1;
            mE01 = 0;
            mE02 = 0;
            mE03 = 0;
            mE10 = 0;
            mE11 = 1;
            mE12 = 0;
            mE13 = 0;
            mE20 = 0;
            mE21 = 0;
            mE22 = 1;
            mE23 = 0;
            mE30 = 0;
            mE31 = 0;
            mE32 = 0;
            mE33 = 1;
            return this;
        }
        
        public function toString() : String
        {
            var _loc1_:* = null;
            _loc1_ = "CMatrix4 = \n";
            _loc1_ += "[" + mE00 + ", " + mE01 + ", " + mE02 + ", " + mE03 + "]\n";
            _loc1_ += "[" + mE10 + ", " + mE11 + ", " + mE12 + ", " + mE13 + "]\n";
            _loc1_ += "[" + mE20 + ", " + mE21 + ", " + mE22 + ", " + mE23 + "]\n";
            return _loc1_ + ("[" + mE30 + ", " + mE31 + ", " + mE32 + ", " + mE33 + "]");
        }
        
        public function Normalize() : CMatrix4
        {
            var _loc1_:Number = NaN;
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            _loc1_ = 1 / Math.sqrt(mE00 * mE00 + mE01 * mE01 + mE02 * mE02);
            mE00 *= _loc1_;
            mE01 *= _loc1_;
            mE02 *= _loc1_;
            _loc2_ = 1 / Math.sqrt(mE10 * mE10 + mE11 * mE11 + mE12 * mE12);
            mE10 *= _loc2_;
            mE11 *= _loc2_;
            mE12 *= _loc2_;
            _loc3_ = 1 / Math.sqrt(mE20 * mE20 + mE21 * mE21 + mE22 * mE22);
            mE20 *= _loc3_;
            mE21 *= _loc3_;
            mE22 *= _loc3_;
            return this;
        }
        
        public function get _BASECLASSID_() : String
        {
            return "CMatrix4";
        }
        
        public function Dispose() : void
        {
        }
    }
}
