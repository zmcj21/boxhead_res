if(!_global.scidd)
{
    _global.scidd = new Object();
}
§§pop();
if(!_global.scidd.Math)
{
    _global.scidd.Math = new Object();
}
§§pop();
if(!_global.scidd.Math.CPointXYZ)
{
    var _loc1_ = null;
    scidd.Math.CPointXYZ = function(tx, ty, tz)
    {
        this.mX = tx != undefined ? tx : 0;
        this.mY = ty != undefined ? ty : 0;
        this.mZ = tz != undefined ? tz : 0;
    };
    var _loc2_ = scidd.Math.CPointXYZ = function(tx, ty, tz)
    {
        this.mX = tx != undefined ? tx : 0;
        this.mY = ty != undefined ? ty : 0;
        this.mZ = tz != undefined ? tz : 0;
    }.prototype;
    _loc2_.Clone = function Clone()
    {
        return new scidd.Math.CPointXYZ(this.mX,this.mY,this.mZ);
    };
    _loc2_.Add = function Add(p)
    {
        return new scidd.Math.CPointXYZ(this.mX + p.mX,this.mY + p.mY,this.mZ + p.mZ);
    };
    _loc2_.Sub = function Sub(p)
    {
        return new scidd.Math.CPointXYZ(this.mX - p.mX,this.mY - p.mY,this.mZ - p.mZ);
    };
    _loc2_.Subtract = function Subtract(p)
    {
        return new scidd.Math.CPointXYZ(this.mX - p.mX,this.mY - p.mY,this.mZ - p.mZ);
    };
    _loc2_.Equals = function Equals(p)
    {
        return this.mX == p.mX && this.mY == p.mY && this.mZ == p.mZ;
    };
    _loc2_.Equals0 = function Equals0()
    {
        return this.mX == 0 && this.mY == 0 && this.mZ == 0;
    };
    _loc2_.Set = function Set(p)
    {
        this.mX = p.mX;
        this.mY = p.mY;
        this.mZ = p.mZ;
        return this;
    };
    _loc2_.SetXYZ = function SetXYZ(x, y, z)
    {
        this.mX = x;
        this.mY = y;
        this.mZ = z;
        return this;
    };
    _loc2_.Clear = function Clear()
    {
        this.mX = 0;
        this.mY = 0;
        this.mZ = 0;
        return this;
    };
    _loc2_.Normalize = function Normalize(tLength)
    {
        this.ScaleN(!this.Equals0() ? tLength / this.__get__mLength() : 1);
        return this;
    };
    _loc2_.ScaleN = function ScaleN(tScale)
    {
        this.mX *= tScale;
        this.mY *= tScale;
        this.mZ *= tScale;
        return this;
    };
    _loc2_.Scale = function Scale(tScale)
    {
        this.mX *= tScale.mX;
        this.mY *= tScale.mY;
        this.mZ *= tScale.mZ;
        return this;
    };
    _loc2_.Invert = function Invert()
    {
        this.mX = 0 - this.mX;
        this.mY = 0 - this.mY;
        this.mZ = 0 - this.mZ;
        return this;
    };
    _loc2_.__get__mInverse = function __get__mInverse()
    {
        return new scidd.Math.CPointXYZ(0 - this.mX,0 - this.mY,0 - this.mZ);
    };
    _loc2_.__get__mAbs = function get mAbs()
    {
        return new scidd.Math.CPointXYZ(Math.abs(this.mX),Math.abs(this.mY),Math.abs(this.mZ));
    };
    _loc2_.__get__mLength_SQR = function __get__mLength_SQR()
    {
        return this.mX * this.mX + this.mY * this.mY + this.mZ * this.mZ;
    };
    _loc2_.__get__mLength = function __get__mLength()
    {
        return Math.sqrt(this.mX * this.mX + this.mY * this.mY + this.mZ * this.mZ);
    };
    _loc2_.Distance = function Distance(p)
    {
        var _loc2_ = this.Subtract(p);
        return _loc2_.__get__mLength();
    };
    _loc2_.Distance_SQR = function Distance_SQR(p)
    {
        var _loc2_ = this.Subtract(p);
        return _loc2_.__get__mLength_SQR();
    };
    _loc2_.toCVector3 = function toCVector3()
    {
        return new scidd.Math.CVector3(this.mX,this.mY,this.mZ);
    };
    _loc2_.toPoint = function toPoint()
    {
        return new flash.geom.Point(this.mX,this.mY);
    };
    _loc2_.toPointXY = function toPointXY()
    {
        return new flash.geom.Point(this.mX,this.mY);
    };
    _loc2_.toPointXZ = function toPointXZ()
    {
        return new flash.geom.Point(this.mX,this.mZ);
    };
    _loc2_.toPointZY = function toPointZY()
    {
        return new flash.geom.Point(this.mZ,this.mY);
    };
    _loc2_.toAngleZ = function toAngleZ()
    {
        return Math.atan2(this.mY,this.mX);
    };
    _loc2_.Round = function Round(tBase)
    {
        this.mX = scidd.Math.CMath.Round(this.mX,tBase);
        this.mY = scidd.Math.CMath.Round(this.mY,tBase);
        this.mZ = scidd.Math.CMath.Round(this.mZ,tBase);
        return this;
    };
    _loc2_.QDistance2D = function QDistance2D(p)
    {
        var _loc3_ = Math.abs(p.mX - this.mX);
        var _loc2_ = Math.abs(p.mY - this.mY);
        return _loc3_ <= _loc2_ ? _loc2_ : _loc3_;
    };
    _loc2_.DotProduct = function DotProduct(tv)
    {
        return this.mX * tv.mX + this.mY * tv.mY + this.mZ * tv.mZ;
    };
    _loc2_.CrossProduct = function CrossProduct(tv)
    {
        return new scidd.Math.CPointXYZ(this.mY * tv.mZ - this.mZ * tv.mY,this.mZ * tv.mX - this.mX * tv.mZ,this.mX * tv.mY - this.mY * tv.mX);
    };
    _loc2_.Precision = function Precision(tPrecision)
    {
        var _loc2_ = tPrecision != 0 ? Math.pow(10,tPrecision) : 1;
        this.mX = Math.round(this.mX * _loc2_) / _loc2_;
        this.mY = Math.round(this.mY * _loc2_) / _loc2_;
        this.mZ = Math.round(this.mZ * _loc2_) / _loc2_;
        return this;
    };
    scidd.Math.CPointXYZ = function(tx, ty, tz)
    {
        this.mX = tx != undefined ? tx : 0;
        this.mY = ty != undefined ? ty : 0;
        this.mZ = tz != undefined ? tz : 0;
    }.Average = function Average(tvlist)
    {
        var _loc3_ = tvlist[0].Clone();
        1;
        while(1 < tvlist.length)
        {
            _loc3_.Add(tvlist[1]);
            2;
        }
        return new scidd.Math.CPointXYZ(_loc3_.mX / tvlist.length,_loc3_.mY / tvlist.length,_loc3_.mZ / tvlist.length);
    };
    _loc2_.RotateZ = function RotateZ(r)
    {
        var _loc3_ = Math.cos(r);
        var _loc2_ = Math.sin(r);
        var _loc4_ = this.mX * _loc3_ - this.mY * _loc2_;
        this.mY = this.mY * _loc3_ + this.mX * _loc2_;
        this.mX = _loc4_;
        return this;
    };
    _loc2_.RotateY = function RotateY(r)
    {
        var _loc3_ = Math.cos(r);
        var _loc2_ = Math.sin(r);
        var _loc4_ = this.mX * _loc3_ - this.mZ * _loc2_;
        this.mZ = this.mZ * _loc3_ + this.mX * _loc2_;
        this.mX = _loc4_;
        return this;
    };
    scidd.Math.CPointXYZ = function(tx, ty, tz)
    {
        this.mX = tx != undefined ? tx : 0;
        this.mY = ty != undefined ? ty : 0;
        this.mZ = tz != undefined ? tz : 0;
    }.PlaneNormal = function PlaneNormal(tv1, tv2, tv3)
    {
        return tv3.Subtract(tv2).CrossProduct(tv1.Subtract(tv2)).Normalize(1);
    };
    _loc2_.toString = function toString()
    {
        return this._CLASSID_ + ":{mX=" + this.mX + ", mY=" + this.mY + ", mZ=" + this.mZ + "}";
    };
    _loc2_._CLASSID_ = "scidd.Math.CPointXYZ";
    §§push(_loc2_.addProperty("mAbs",_loc2_.__get__mAbs,0));
    §§push(_loc2_.addProperty("mInverse",_loc2_.__get__mInverse,0));
    §§push(_loc2_.addProperty("mLength",_loc2_.__get__mLength,0));
    §§push(_loc2_.addProperty("mLength_SQR",_loc2_.__get__mLength_SQR,0));
    §§push(ASSetPropFlags(scidd.Math.CPointXYZ.prototype,null,1));
}
§§pop();
