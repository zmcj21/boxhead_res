if(!_global.Thing)
{
    _global.Thing = new Object();
}
§§pop();
if(!_global.Thing.Math)
{
    _global.Thing.Math = new Object();
}
§§pop();
if(!_global.Thing.Math.CThing_Position)
{
    var _loc1_ = null;
    Thing.Math.CThing_Position = function(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    };
    var _loc2_ = Thing.Math.CThing_Position = function(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    }.prototype;
    _loc2_.Clone = function Clone()
    {
        return new Thing.Math.CThing_Position(this.mX,this.mY,this.mZ);
    };
    _loc2_.ConvertScreenToCell = function ConvertScreenToCell()
    {
        this.mX /= World.Map.CMap_Cell.mSize.x;
        this.mY /= World.Map.CMap_Cell.mSize.y;
        return this;
    };
    _loc2_.ConvertCellToScreen = function ConvertCellToScreen()
    {
        return new flash.geom.Point(Math.round(this.mX * World.Map.CMap_Cell.mSize.x),Math.round((this.mY + this.mZ * Thing.Math.CThing_Position.mPFactor) * World.Map.CMap_Cell.mSize.y));
    };
    _loc2_.__get__mCellCentre = function __get__mCellCentre()
    {
        return new Thing.Math.CThing_Position(Math.floor(this.mX) + 0.5,Math.floor(this.mY) + 0.5,this.mZ);
    };
    _loc2_.CellCentre = function CellCentre()
    {
        this.mX = Math.floor(this.mX) + 0.5;
        this.mY = Math.floor(this.mY) + 0.5;
        return this;
    };
    _loc2_.Round = function Round()
    {
        this.mX = Math.round(this.mX);
        this.mY = Math.round(this.mY);
        return this;
    };
    _loc2_.Floor = function Floor()
    {
        this.mX = Math.floor(this.mX);
        this.mY = Math.floor(this.mY);
        return this;
    };
    _loc2_.Ceil = function Ceil()
    {
        this.mX = Math.ceil(this.mX);
        this.mY = Math.ceil(this.mY);
        return this;
    };
    _loc2_.Add = function Add(p)
    {
        return new Thing.Math.CThing_Position(this.mX + p.mX,this.mY + p.mY,this.mZ + p.mZ);
    };
    _loc2_.Add2 = function Add2(p1, p2)
    {
        this.mX = p1.mX + p2.mX;
        this.mY = p1.mY + p2.mY;
        this.mZ = p1.mZ + p2.mZ;
        return this;
    };
    _loc2_.Sub = function Sub(p)
    {
        return new Thing.Math.CThing_Position(this.mX - p.mX,this.mY - p.mY,this.mZ - p.mZ);
    };
    _loc2_.Subtract = function Subtract(p)
    {
        return new Thing.Math.CThing_Position(this.mX - p.mX,this.mY - p.mY,this.mZ - p.mZ);
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
        return new Thing.Math.CThing_Position(0 - this.mX,0 - this.mY,0 - this.mZ);
    };
    _loc2_.__get__mAbs = function get mAbs()
    {
        return new Thing.Math.CThing_Position(Math.abs(this.mX),Math.abs(this.mY),Math.abs(this.mZ));
    };
    _loc2_.__get__mLength_SQR = function __get__mLength_SQR()
    {
        return this.mX * this.mX + this.mY * this.mY + this.mZ * this.mZ;
    };
    _loc2_.__get__mLength = function __get__mLength()
    {
        return Math.sqrt(this.mX * this.mX + this.mY * this.mY + this.mZ * this.mZ);
    };
    _loc2_.__get__mLength2D_SQR = function __get__mLength2D_SQR()
    {
        return this.mX * this.mX + this.mY * this.mY;
    };
    _loc2_.__get__mLength2D = function __get__mLength2D()
    {
        return Math.sqrt(this.mX * this.mX + this.mY * this.mY);
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
    _loc2_.RoundBase = function RoundBase(tBase)
    {
        this.mX = scidd.Math.CMath.Round(this.mX,tBase);
        this.mY = scidd.Math.CMath.Round(this.mY,tBase);
        this.mZ = scidd.Math.CMath.Round(this.mZ,tBase);
        return this;
    };
    _loc2_.Distance = function Distance(p)
    {
        var _loc4_ = this.mX - p.mX;
        var _loc3_ = this.mY - p.mY;
        var _loc2_ = this.mZ - p.mZ;
        return Math.sqrt(_loc4_ * _loc4_ + _loc3_ * _loc3_ + _loc2_ * _loc2_);
    };
    _loc2_.Distance_SQR = function Distance_SQR(p)
    {
        var _loc4_ = this.mX - p.mX;
        var _loc3_ = this.mY - p.mY;
        var _loc2_ = this.mZ - p.mZ;
        return _loc4_ * _loc4_ + _loc3_ * _loc3_ + _loc2_ * _loc2_;
    };
    _loc2_.Distance2D = function Distance2D(p)
    {
        var _loc3_ = this.mX - p.mX;
        var _loc2_ = this.mY - p.mY;
        return Math.sqrt(_loc3_ * _loc3_ + _loc2_ * _loc2_);
    };
    _loc2_.Distance2D_SQR = function Distance2D_SQR(p)
    {
        var _loc3_ = p.mX - this.mX;
        var _loc2_ = p.mY - this.mY;
        return _loc3_ * _loc3_ + _loc2_ * _loc2_;
    };
    _loc2_.Normalize = function Normalize(tLength)
    {
        this.ScaleN(!(this.mX == 0 && this.mY == 0 && this.mZ == 0) ? tLength / Math.sqrt(this.mX * this.mX + this.mY * this.mY + this.mZ * this.mZ) : 1);
        return this;
    };
    _loc2_.ScaleN2D = function ScaleN2D(tScale)
    {
        this.mX *= tScale;
        this.mY *= tScale;
        return this;
    };
    _loc2_.Normalize2D = function Normalize2D(tLength)
    {
        this.ScaleN2D(!(this.mX == 0 && this.mY == 0) ? tLength / Math.sqrt(this.mX * this.mX + this.mY * this.mY) : 1);
        return this;
    };
    _loc2_.AngleToPosition = function AngleToPosition(p)
    {
        var _loc2_ = undefined;
        return (_loc2_ = Math.atan2(p.mY - this.mY,p.mX - this.mX)) >= 0 ? _loc2_ : _loc2_ + Thing.Math.CThing_Position.PI360;
    };
    _loc2_.CAngleToPosition = function CAngleToPosition(p)
    {
        return new Thing.Math.CThing_Angle(this.AngleToPosition(p));
    };
    _loc2_.DotProduct = function DotProduct(tv)
    {
        return this.mX * tv.mX + this.mY * tv.mY + this.mZ * tv.mZ;
    };
    _loc2_.CrossProduct = function CrossProduct(tv)
    {
        return new Thing.Math.CThing_Position(this.mY * tv.mZ - this.mZ * tv.mY,this.mZ * tv.mX - this.mX * tv.mZ,this.mX * tv.mY - this.mY * tv.mX);
    };
    _loc2_.Precision = function Precision(tPrecision)
    {
        var _loc2_ = tPrecision != 0 ? Math.pow(10,tPrecision) : 1;
        this.mX = Math.round(this.mX * _loc2_) / _loc2_;
        this.mY = Math.round(this.mY * _loc2_) / _loc2_;
        this.mZ = Math.round(this.mZ * _loc2_) / _loc2_;
        return this;
    };
    Thing.Math.CThing_Position = function(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    }.Average = function Average(tvlist)
    {
        var _loc3_ = tvlist[0].Clone();
        1;
        while(1 < tvlist.length)
        {
            _loc3_.Add(tvlist[1]);
            2;
        }
        return new Thing.Math.CThing_Position(_loc3_.mX / tvlist.length,_loc3_.mY / tvlist.length,_loc3_.mZ / tvlist.length);
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
    Thing.Math.CThing_Position = function(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    }.PlaneNormal = function PlaneNormal(tv1, tv2, tv3)
    {
        return tv3.Subtract(tv2).CrossProduct(tv1.Subtract(tv2)).Normalize(1);
    };
    _loc2_.toString = function toString()
    {
        return this._CLASSID_ + ":{mX=" + this.mX + ", mY=" + this.mY + ", mZ=" + this.mZ + "}";
    };
    _loc2_._CLASSID_ = "CThing_Position";
    _loc2_._BASECLASSID_ = "CThing_Position";
    Thing.Math.CThing_Position = function(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    }.mPFactor = 1;
    Thing.Math.CThing_Position = function(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    }.PI = 3.141592653589793;
    Thing.Math.CThing_Position = function(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    }.PI360 = Thing.Math.CThing_Position.PI * 2;
    Thing.Math.CThing_Position = function(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    }.Deg2Rad = Thing.Math.CThing_Position.PI / 180;
    Thing.Math.CThing_Position = function(tx, ty, tz)
    {
        this.mX = tx;
        this.mY = ty;
        this.mZ = tz;
    }.Rad2Deg = 180 / Thing.Math.CThing_Position.PI;
    §§push(_loc2_.addProperty("mAbs",_loc2_.__get__mAbs,0));
    §§push(_loc2_.addProperty("mCellCentre",_loc2_.__get__mCellCentre,0));
    §§push(_loc2_.addProperty("mInverse",_loc2_.__get__mInverse,0));
    §§push(_loc2_.addProperty("mLength",_loc2_.__get__mLength,0));
    §§push(_loc2_.addProperty("mLength2D",_loc2_.__get__mLength2D,0));
    §§push(_loc2_.addProperty("mLength2D_SQR",_loc2_.__get__mLength2D_SQR,0));
    §§push(_loc2_.addProperty("mLength_SQR",_loc2_.__get__mLength_SQR,0));
    §§push(ASSetPropFlags(Thing.Math.CThing_Position.prototype,null,1));
}
§§pop();
