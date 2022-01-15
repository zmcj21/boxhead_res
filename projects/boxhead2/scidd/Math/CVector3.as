class scidd.Math.CVector3
{
    var _CLASSID_ = "scidd.Math.CVector3";
    function CVector3(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    }
    function Clone()
    {
        return new scidd.Math.CVector3(this.mX,this.mY,this.mZ);
    }
    function Add(tv)
    {
        this.mX += tv.mX;
        this.mY += tv.mY;
        this.mZ += tv.mZ;
        return this;
    }
    function Sub(tv)
    {
        this.mX -= tv.mX;
        this.mY -= tv.mY;
        this.mZ -= tv.mZ;
        return this;
    }
    function Equals(tv)
    {
        return this.mX == tv.mX && this.mY == tv.mY && this.mZ == tv.mZ;
    }
    function Equals0()
    {
        return this.mX == 0 && this.mY == 0 && this.mZ == 0;
    }
    function Set(tv)
    {
        this.mX = tv.mX;
        this.mY = tv.mY;
        this.mZ = tv.mZ;
        return this;
    }
    function Clear()
    {
        this.mX = 0;
        this.mY = 0;
        this.mZ = 0;
        return this;
    }
    function Invert()
    {
        this.mX = 0 - this.mX;
        this.mY = 0 - this.mY;
        this.mZ = 0 - this.mZ;
        return this;
    }
    function Inverse()
    {
        return new scidd.Math.CVector3(0 - this.mX,0 - this.mY,0 - this.mZ);
    }
    function Abs()
    {
        return new scidd.Math.CVector3(Math.abs(this.mX),Math.abs(this.mY),Math.abs(this.mZ));
    }
    function ScaleN(tScale)
    {
        this.mX *= tScale;
        this.mY *= tScale;
        this.mZ *= tScale;
        return this;
    }
    function Scale(tScale)
    {
        this.mX *= tScale.mX;
        this.mY *= tScale.mY;
        this.mZ *= tScale.mZ;
        return this;
    }
    function _Length()
    {
        return Math.sqrt(this.mX * this.mX + this.mY * this.mY + this.mZ * this.mZ);
    }
    function Distance(tVector3)
    {
        var _loc4_ = this.mX - tVector3.mX;
        var _loc3_ = this.mY - tVector3.mY;
        var _loc2_ = this.mZ - tVector3.mZ;
        return Math.sqrt(_loc4_ * _loc4_ + _loc3_ * _loc3_ + _loc2_ * _loc2_);
    }
    function Normalize(tLength)
    {
        if(this._Length() != 0)
        {
            this.ScaleN(tLength / this._Length());
        }
        return this;
    }
    function DotProduct(tv)
    {
        return this.mX * tv.mX + this.mY * tv.mY + this.mZ * tv.mZ;
    }
    function CrossProduct(tv)
    {
        return new scidd.Math.CVector3(this.mY * tv.mZ - this.mZ * tv.mY,this.mZ * tv.mX - this.mX * tv.mZ,this.mX * tv.mY - this.mY * tv.mX);
    }
    function Precision(tPrecision)
    {
        var _loc2_ = tPrecision != 0 ? Math.pow(10,tPrecision) : 1;
        this.mX = Math.round(this.mX * _loc2_) / _loc2_;
        this.mY = Math.round(this.mY * _loc2_) / _loc2_;
        this.mZ = Math.round(this.mZ * _loc2_) / _loc2_;
        return this;
    }
    static function Average(tvlist)
    {
        var _loc3_ = tvlist[0].Clone();
        1;
        while(1 < tvlist.length)
        {
            _loc3_.Add(tvlist[1]);
            2;
        }
        return new scidd.Math.CVector3(_loc3_.mX / tvlist.length,_loc3_.mY / tvlist.length,_loc3_.mZ / tvlist.length);
    }
    function RotateY(tRads)
    {
        var _loc3_ = Math.cos(tRads);
        var _loc2_ = Math.sin(tRads);
        var _loc5_ = this.mX * _loc3_ - this.mZ * _loc2_;
        var _loc4_ = this.mZ * _loc3_ + this.mX * _loc2_;
        this.mX = _loc5_;
        this.mZ = _loc4_;
    }
    function toString()
    {
        return "{mX=" + this.mX + ", mY=" + this.mY + ", mZ=" + this.mZ + "}";
    }
}
