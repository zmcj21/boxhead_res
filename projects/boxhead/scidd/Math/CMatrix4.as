class scidd.Math.CMatrix4
{
    var _CLASSID_ = "scidd.Math.CMatrix4";
    function CMatrix4()
    {
        this.Identity();
    }
    function Identity()
    {
        this.mE00 = 1;
        this.mE01 = 0;
        this.mE02 = 0;
        this.mE03 = 0;
        this.mE10 = 0;
        this.mE11 = 1;
        this.mE12 = 0;
        this.mE13 = 0;
        this.mE20 = 0;
        this.mE21 = 0;
        this.mE22 = 1;
        this.mE23 = 0;
        this.mE30 = 0;
        this.mE31 = 0;
        this.mE32 = 0;
        this.mE33 = 1;
        return this;
    }
    static function Identity_Matrix()
    {
        var _loc1_ = new scidd.Math.CMatrix4();
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
    function toString()
    {
        "CMatrix4 = \n";
        _loc2_ = "CMatrix4 = \n" + ("[" + this.mE00 + ", " + this.mE01 + ", " + this.mE02 + ", " + this.mE03 + "]" + "\n");
        _loc2_ += "[" + this.mE10 + ", " + this.mE11 + ", " + this.mE12 + ", " + this.mE13 + "]" + "\n";
        _loc2_ += "[" + this.mE20 + ", " + this.mE21 + ", " + this.mE22 + ", " + this.mE23 + "]" + "\n";
        _loc2_ += "[" + this.mE30 + ", " + this.mE31 + ", " + this.mE32 + ", " + this.mE33 + "]";
        return _loc2_;
    }
    function Clone()
    {
        var _loc2_ = new scidd.Math.CMatrix4();
        _loc2_.mE00 = this.mE00;
        _loc2_.mE01 = this.mE01;
        _loc2_.mE02 = this.mE02;
        _loc2_.mE03 = this.mE03;
        _loc2_.mE10 = this.mE10;
        _loc2_.mE11 = this.mE11;
        _loc2_.mE12 = this.mE12;
        _loc2_.mE13 = this.mE13;
        _loc2_.mE20 = this.mE20;
        _loc2_.mE21 = this.mE21;
        _loc2_.mE22 = this.mE22;
        _loc2_.mE23 = this.mE23;
        _loc2_.mE30 = this.mE30;
        _loc2_.mE31 = this.mE31;
        _loc2_.mE32 = this.mE32;
        _loc2_.mE33 = this.mE33;
        return _loc2_;
    }
    function Copy(tMatrix)
    {
        this.mE00 = tMatrix.mE00;
        this.mE01 = tMatrix.mE01;
        this.mE02 = tMatrix.mE02;
        this.mE03 = tMatrix.mE03;
        this.mE10 = tMatrix.mE10;
        this.mE11 = tMatrix.mE11;
        this.mE12 = tMatrix.mE12;
        this.mE13 = tMatrix.mE13;
        this.mE20 = tMatrix.mE20;
        this.mE21 = tMatrix.mE21;
        this.mE22 = tMatrix.mE22;
        this.mE23 = tMatrix.mE23;
        this.mE30 = tMatrix.mE30;
        this.mE31 = tMatrix.mE31;
        this.mE32 = tMatrix.mE32;
        this.mE33 = tMatrix.mE33;
        return this;
    }
    function Normalize()
    {
        var _loc2_ = 1 / Math.sqrt(this.mE00 * this.mE00 + this.mE01 * this.mE01 + this.mE02 * this.mE02);
        this.mE00 *= _loc2_;
        this.mE01 *= _loc2_;
        this.mE02 *= _loc2_;
        _loc2_ = 1 / Math.sqrt(this.mE10 * this.mE10 + this.mE11 * this.mE11 + this.mE12 * this.mE12);
        this.mE10 *= _loc2_;
        this.mE11 *= _loc2_;
        this.mE12 *= _loc2_;
        _loc2_ = 1 / Math.sqrt(this.mE20 * this.mE20 + this.mE21 * this.mE21 + this.mE22 * this.mE22);
        this.mE20 *= _loc2_;
        this.mE21 *= _loc2_;
        this.mE22 *= _loc2_;
        return this;
    }
    function Multiply(a, b)
    {
        this.mE00 = a.mE00 * b.mE00 + a.mE01 * b.mE10 + a.mE02 * b.mE20;
        this.mE01 = a.mE00 * b.mE01 + a.mE01 * b.mE11 + a.mE02 * b.mE21;
        this.mE02 = a.mE00 * b.mE02 + a.mE01 * b.mE12 + a.mE02 * b.mE22;
        this.mE03 = 0;
        this.mE10 = a.mE10 * b.mE00 + a.mE11 * b.mE10 + a.mE12 * b.mE20;
        this.mE11 = a.mE10 * b.mE01 + a.mE11 * b.mE11 + a.mE12 * b.mE21;
        this.mE12 = a.mE10 * b.mE02 + a.mE11 * b.mE12 + a.mE12 * b.mE22;
        this.mE13 = 0;
        this.mE20 = a.mE20 * b.mE00 + a.mE21 * b.mE10 + a.mE22 * b.mE20;
        this.mE21 = a.mE20 * b.mE01 + a.mE21 * b.mE11 + a.mE22 * b.mE21;
        this.mE22 = a.mE20 * b.mE02 + a.mE21 * b.mE12 + a.mE22 * b.mE22;
        this.mE23 = 0;
        this.mE30 = a.mE30 * b.mE00 + a.mE31 * b.mE10 + a.mE32 * b.mE20 + b.mE30;
        this.mE31 = a.mE30 * b.mE01 + a.mE31 * b.mE11 + a.mE32 * b.mE21 + b.mE31;
        this.mE32 = a.mE30 * b.mE02 + a.mE31 * b.mE12 + a.mE32 * b.mE22 + b.mE32;
        this.mE33 = 1;
        return this;
    }
    function MultiplyNew(b)
    {
        var _loc2_ = new scidd.Math.CMatrix4();
        return _loc2_.Multiply(this,b);
    }
    function Multiply_Inverse(b, a)
    {
        return this.Multiply(a,b);
    }
    function TransformVector(tVecS, tVecD)
    {
        var _loc4_ = tVecS.mX;
        var _loc3_ = tVecS.mY;
        var _loc2_ = tVecS.mZ;
        tVecD.mX = _loc4_ * this.mE00 + _loc3_ * this.mE10 + _loc2_ * this.mE20 + this.mE30;
        tVecD.mY = _loc4_ * this.mE01 + _loc3_ * this.mE11 + _loc2_ * this.mE21 + this.mE31;
        tVecD.mZ = _loc4_ * this.mE02 + _loc3_ * this.mE12 + _loc2_ * this.mE22 + this.mE32;
    }
    function TransformVectors(tArrS, tArrD)
    {
        for(var _loc9_ in tArrS)
        {
            var _loc5_ = tArrS[_loc9_];
            var _loc6_ = tArrD[_loc9_];
            var _loc4_ = _loc5_.mX;
            var _loc3_ = _loc5_.mY;
            var _loc2_ = _loc5_.mZ;
            _loc6_.mZ = _loc4_ * this.mE02 + _loc3_ * this.mE12 + _loc2_ * this.mE22 + this.mE32;
            _loc6_.mY = _loc4_ * this.mE01 + _loc3_ * this.mE11 + _loc2_ * this.mE21 + this.mE31;
            _loc6_.mX = _loc4_ * this.mE00 + _loc3_ * this.mE10 + _loc2_ * this.mE20 + this.mE30;
        }
    }
    function TransformVectors_NoTranslate(tArrS, tArrD)
    {
        for(var _loc9_ in tArrS)
        {
            var _loc5_ = tArrS[_loc9_];
            var _loc6_ = tArrD[_loc9_];
            var _loc4_ = _loc5_.mX;
            var _loc3_ = _loc5_.mY;
            var _loc2_ = _loc5_.mZ;
            _loc6_.mZ = _loc4_ * this.mE02 + _loc3_ * this.mE12 + _loc2_ * this.mE22;
            _loc6_.mY = _loc4_ * this.mE01 + _loc3_ * this.mE11 + _loc2_ * this.mE21;
            _loc6_.mX = _loc4_ * this.mE00 + _loc3_ * this.mE10 + _loc2_ * this.mE20;
        }
    }
    function TransformVectors_NoTranslate_Inverse(tArrS, tArrD)
    {
        for(var _loc9_ in tArrS)
        {
            var _loc5_ = tArrS[_loc9_];
            var _loc6_ = tArrD[_loc9_];
            var _loc4_ = _loc5_.mX;
            var _loc3_ = _loc5_.mY;
            var _loc2_ = _loc5_.mZ;
            _loc6_.mX = _loc4_ * this.mE00 + _loc3_ * this.mE01 + _loc2_ * this.mE02;
            _loc6_.mY = _loc4_ * this.mE10 + _loc3_ * this.mE11 + _loc2_ * this.mE12;
            _loc6_.mZ = _loc4_ * this.mE20 + _loc3_ * this.mE21 + _loc2_ * this.mE22;
        }
    }
    function TransformVectors_WithLens(tArrS, tArrD, tLens)
    {
        for(var _loc10_ in tArrS)
        {
            var _loc6_ = tArrS[_loc10_];
            var _loc2_ = tArrD[_loc10_];
            var _loc5_ = _loc6_.mX;
            var _loc4_ = _loc6_.mY;
            var _loc3_ = _loc6_.mZ;
            _loc2_.mZ = _loc5_ * this.mE02 + _loc4_ * this.mE12 + _loc3_ * this.mE22 + this.mE32;
            _loc2_.mY = tLens * (_loc5_ * this.mE01 + _loc4_ * this.mE11 + _loc3_ * this.mE21 + this.mE31) / _loc2_.mZ;
            _loc2_.mX = tLens * (_loc5_ * this.mE00 + _loc4_ * this.mE10 + _loc3_ * this.mE20 + this.mE30) / _loc2_.mZ;
        }
    }
    function TransformVector_Inverse(tVecS, tVecD)
    {
        var _loc4_ = tVecS.mX;
        var _loc3_ = tVecS.mY;
        var _loc2_ = tVecS.mZ;
        tVecD.mX = _loc4_ * this.mE00 + _loc3_ * this.mE01 + _loc2_ * this.mE02 - this.mE30;
        tVecD.mY = _loc4_ * this.mE10 + _loc3_ * this.mE11 + _loc2_ * this.mE12 - this.mE31;
        tVecD.mZ = _loc4_ * this.mE20 + _loc3_ * this.mE21 + _loc2_ * this.mE22 - this.mE32;
    }
    function TransformVector_NoTranslate(tVecS, tVecD)
    {
        var _loc4_ = tVecS.mX;
        var _loc3_ = tVecS.mY;
        var _loc2_ = tVecS.mZ;
        tVecD.mX = _loc4_ * this.mE00 + _loc3_ * this.mE10 + _loc2_ * this.mE20;
        tVecD.mY = _loc4_ * this.mE01 + _loc3_ * this.mE11 + _loc2_ * this.mE21;
        tVecD.mZ = _loc4_ * this.mE02 + _loc3_ * this.mE12 + _loc2_ * this.mE22;
    }
    function TransformVector_NoTranslate_Inverse(tVecS, tVecD)
    {
        var _loc4_ = tVecS.mX;
        var _loc3_ = tVecS.mY;
        var _loc2_ = tVecS.mZ;
        tVecD.mX = _loc4_ * this.mE00 + _loc3_ * this.mE01 + _loc2_ * this.mE02;
        tVecD.mY = _loc4_ * this.mE10 + _loc3_ * this.mE11 + _loc2_ * this.mE12;
        tVecD.mZ = _loc4_ * this.mE20 + _loc3_ * this.mE21 + _loc2_ * this.mE22;
    }
    function Inverse()
    {
        var _loc2_ = new scidd.Math.CMatrix4();
        _loc2_.mE00 = (0 - this.mE12) * this.mE21 * 1 + this.mE11 * this.mE22 * 1;
        _loc2_.mE01 = this.mE02 * this.mE21 * 1 - this.mE01 * this.mE22 * 1;
        _loc2_.mE02 = (0 - this.mE02) * this.mE11 * 1 + this.mE01 * this.mE12 * 1;
        _loc2_.mE03 = 0;
        _loc2_.mE10 = this.mE12 * this.mE20 * 1 - this.mE10 * this.mE22 * 1;
        _loc2_.mE11 = (0 - this.mE02) * this.mE20 * 1 + this.mE00 * this.mE22 * 1;
        _loc2_.mE12 = this.mE02 * this.mE10 * 1 - this.mE00 * this.mE12 * 1;
        _loc2_.mE13 = 0;
        _loc2_.mE20 = (0 - this.mE11) * this.mE20 * 1 + this.mE10 * this.mE21 * 1;
        _loc2_.mE21 = this.mE01 * this.mE20 * 1 - this.mE00 * this.mE21 * 1;
        _loc2_.mE22 = (0 - this.mE01) * this.mE10 * 1 + this.mE00 * this.mE11 * 1;
        _loc2_.mE23 = 0;
        _loc2_.mE30 = 0;
        _loc2_.mE31 = 0;
        _loc2_.mE32 = 0;
        _loc2_.mE33 = 1;
        var _loc3_ = 1 / this.Determinant();
        _loc2_.mE00 *= _loc3_;
        _loc2_.mE01 *= _loc3_;
        _loc2_.mE02 *= _loc3_;
        _loc2_.mE10 *= _loc3_;
        _loc2_.mE11 *= _loc3_;
        _loc2_.mE12 *= _loc3_;
        _loc2_.mE20 *= _loc3_;
        _loc2_.mE21 *= _loc3_;
        _loc2_.mE22 *= _loc3_;
        return _loc2_;
    }
    function Determinant()
    {
        return (0 - this.mE02) * this.mE11 * this.mE20 + this.mE01 * this.mE12 * this.mE20 + this.mE02 * this.mE10 * this.mE21 - this.mE00 * this.mE12 * this.mE21 - this.mE01 * this.mE10 * this.mE22 + this.mE00 * this.mE11 * this.mE22;
    }
    function Translate(tTrans, tInvert)
    {
        var _loc3_ = scidd.Math.CMatrix4.Translate_Matrix(tTrans,tInvert);
        var _loc2_ = this.Clone();
        return this.Multiply(_loc2_,_loc3_);
    }
    static function Translate_Matrix(tTrans, tInvert)
    {
        var _loc1_ = scidd.Math.CMatrix4.Identity_Matrix();
        _loc1_.mE30 = !tInvert ? tTrans.mX : - tTrans.mX;
        _loc1_.mE31 = !tInvert ? tTrans.mY : - tTrans.mY;
        _loc1_.mE32 = !tInvert ? tTrans.mZ : - tTrans.mZ;
        return _loc1_;
    }
    function Scale(tScale)
    {
        var _loc3_ = scidd.Math.CMatrix4.Scale_Matrix(tScale);
        var _loc2_ = this.Clone();
        return this.Multiply(_loc2_,_loc3_);
    }
    static function Scale_Matrix(tScale)
    {
        var _loc1_ = scidd.Math.CMatrix4.Identity_Matrix();
        _loc1_.mE00 = tScale.mX;
        _loc1_.mE11 = tScale.mY;
        _loc1_.mE22 = tScale.mZ;
        return _loc1_;
    }
    function RotateX(tRadians, tInvert)
    {
        var _loc3_ = scidd.Math.CMatrix4.RotateX_Matrix(tRadians,tInvert);
        var _loc2_ = this.Clone();
        return this.Multiply(_loc2_,_loc3_);
    }
    function RotateY(tRadians, tInvert)
    {
        var _loc3_ = scidd.Math.CMatrix4.RotateY_Matrix(tRadians,tInvert);
        var _loc2_ = this.Clone();
        return this.Multiply(_loc2_,_loc3_);
    }
    function RotateZ(tRadians, tInvert)
    {
        var _loc3_ = scidd.Math.CMatrix4.RotateZ_Matrix(tRadians,tInvert);
        var _loc2_ = this.Clone();
        return this.Multiply(_loc2_,_loc3_);
    }
    static function RotateX_Matrix(tRadians, tInvert)
    {
        var _loc1_ = scidd.Math.CMatrix4.Identity_Matrix();
        _loc1_.mE11 = Math.cos(tRadians);
        _loc1_.mE12 = !(tInvert && tInvert != undefined) ? 0 - Math.sin(tRadians) : Math.sin(tRadians);
        _loc1_.mE21 = !(tInvert && tInvert != undefined) ? Math.sin(tRadians) : - Math.sin(tRadians);
        _loc1_.mE22 = Math.cos(tRadians);
        return _loc1_;
    }
    static function RotateY_Matrix(tRadians, tInvert)
    {
        var _loc1_ = scidd.Math.CMatrix4.Identity_Matrix();
        _loc1_.mE00 = Math.cos(tRadians);
        _loc1_.mE02 = !(tInvert && tInvert != undefined) ? 0 - Math.sin(tRadians) : Math.sin(tRadians);
        _loc1_.mE20 = !(tInvert && tInvert != undefined) ? Math.sin(tRadians) : - Math.sin(tRadians);
        _loc1_.mE22 = Math.cos(tRadians);
        return _loc1_;
    }
    static function RotateZ_Matrix(tRadians, tInvert)
    {
        var _loc1_ = scidd.Math.CMatrix4.Identity_Matrix();
        _loc1_.mE00 = Math.cos(tRadians);
        _loc1_.mE01 = !(tInvert && tInvert != undefined) ? 0 - Math.sin(tRadians) : Math.sin(tRadians);
        _loc1_.mE10 = !(tInvert && tInvert != undefined) ? Math.sin(tRadians) : - Math.sin(tRadians);
        _loc1_.mE11 = Math.cos(tRadians);
        return _loc1_;
    }
    static function RotateXYZ_Matrix(tAxisS)
    {
        var _loc1_ = scidd.Math.CMatrix4.Identity_Matrix();
        var _loc8_ = tAxisS.Clone();
        var _loc7_ = _loc8_._Length();
        if(_loc7_ > 0.0001)
        {
            var _loc5_ = _loc8_.mX / _loc7_;
            var _loc4_ = _loc8_.mY / _loc7_;
            var _loc3_ = _loc8_.mZ / _loc7_;
            var _loc10_ = _loc7_ / 500;
            var _loc9_ = Math.cos(_loc10_);
            var _loc6_ = Math.sin(_loc10_);
            var _loc2_ = 1 - _loc9_;
            _loc1_.mE00 = _loc2_ * _loc5_ * _loc5_ + _loc9_;
            _loc1_.mE01 = _loc2_ * _loc5_ * _loc4_ - _loc6_ * _loc3_;
            _loc1_.mE02 = _loc2_ * _loc5_ * _loc3_ + _loc6_ * _loc4_;
            _loc1_.mE10 = _loc2_ * _loc5_ * _loc4_ + _loc6_ * _loc3_;
            _loc1_.mE11 = _loc2_ * _loc4_ * _loc4_ + _loc9_;
            _loc1_.mE12 = _loc2_ * _loc4_ * _loc3_ - _loc6_ * _loc5_;
            _loc1_.mE20 = _loc2_ * _loc5_ * _loc3_ - _loc6_ * _loc4_;
            _loc1_.mE21 = _loc2_ * _loc4_ * _loc3_ + _loc6_ * _loc5_;
            _loc1_.mE22 = _loc2_ * _loc3_ * _loc3_ + _loc9_;
        }
        return _loc1_;
    }
}
