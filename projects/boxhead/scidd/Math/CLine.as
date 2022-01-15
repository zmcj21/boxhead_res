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
if(!_global.scidd.Math.CLine)
{
    var _loc1_ = null;
    scidd.Math.CLine = function(p1, p2)
    {
        this.mP1 = p1;
        this.mP2 = p2;
    };
    var _loc2_ = scidd.Math.CLine = function(p1, p2)
    {
        this.mP1 = p1;
        this.mP2 = p2;
    }.prototype;
    _loc2_.Clone = function Clone(tNoPointClone)
    {
        return !(tNoPointClone == undefined || tNoPointClone == false) ? new scidd.Math.CLine(this.mP1,this.mP2) : new scidd.Math.CLine(this.mP1.clone(),this.mP2.clone());
    };
    _loc2_.toString = function toString()
    {
        return "CLine:: " + this.mP1 + " , " + this.mP2;
    };
    _loc2_.Draw = function Draw(mc, tColor, tAlpha)
    {
        mc.lineStyle(1,tColor != undefined ? tColor : 65280,tAlpha != undefined ? tAlpha : 100);
        mc.moveTo(this.mP1.x,this.mP1.y);
        mc.lineTo(this.mP2.x,this.mP2.y);
    };
    _loc2_.DrawNormal = function DrawNormal(mc, tColor, tAlpha)
    {
        mc.lineStyle(1,tColor != undefined ? tColor : 65280,tAlpha != undefined ? tAlpha : 100);
        mc.moveTo(this.mP1.x,this.mP1.y);
        mc.lineTo(this.mP2.x,this.mP2.y);
        var _loc2_ = this.mP2.subtract(this.mP1);
        _loc2_.normalize(_loc2_.length / 2);
        _loc2_ = _loc2_.add(this.mP1);
        mc.moveTo(_loc2_.x,_loc2_.y);
        var _loc4_ = this.__get__mNormal();
        _loc4_.normalize(this.__get__mDelta().length / 4);
        _loc2_ = _loc2_.add(_loc4_);
        mc.lineTo(_loc2_.x,_loc2_.y);
    };
    _loc2_.Move = function Move(d, scalar)
    {
        d = d.clone();
        d.normalize(d.length * scalar);
        this.mP1 = this.mP1.add(d);
        this.mP2 = this.mP2.add(d);
        return this;
    };
    _loc2_.Offset = function Offset(d)
    {
        return new scidd.Math.CLine(this.mP1.add(d),this.mP2.add(d));
    };
    _loc2_.__get__mNormal = function __get__mNormal()
    {
        return this._cache_Normal != undefined ? this._cache_Normal.clone() : (this._cache_Normal = new flash.geom.Point(this.mP1.y - this.mP2.y,this.mP2.x - this.mP1.x));
    };
    _loc2_.__get__mNormalUnit = function __get__mNormalUnit()
    {
        var _loc2_ = this.__get__mNormal();
        _loc2_.normalize(1);
        return _loc2_;
    };
    _loc2_.__get__mCentre = function __get__mCentre()
    {
        return this._cache_Centre != undefined ? this._cache_Centre.clone() : (this._cache_Centre = new flash.geom.Point((this.mP1.x + this.mP2.x) / 2,(this.mP2.y + this.mP1.y) / 2));
    };
    _loc2_.__get__mDelta = function __get__mDelta()
    {
        return this._cache_Delta != undefined ? this._cache_Delta.clone() : (this._cache_Delta = this.mP2.subtract(this.mP1));
    };
    _loc2_.__get__mAngle = function get mAngle()
    {
        return this._cache_Angle != undefined ? (this._cache_Angle = Math.atan2(this.mP2.y - this.mP1.y,this.mP2.x - this.mP1.x)) : this._cache_Angle;
    };
    _loc2_.__get__mLength = function __get__mLength()
    {
        if(this._cache_Length == undefined)
        {
            var _loc2_ = this.__get__mDelta();
            return this._cache_Length = Math.sqrt(_loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y);
        }
        return this._cache_Length;
    };
    _loc2_.__get__mLength_SQR = function __get__mLength_SQR()
    {
        if(this._cache_LengthSQR == undefined)
        {
            var _loc2_ = this.__get__mDelta();
            return this._cache_LengthSQR = _loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y;
        }
        return this._cache_LengthSQR;
    };
    _loc2_.__get__mCrossProduct = function __get__mCrossProduct()
    {
        return new flash.geom.Point(this.mP1.y * this.mP2.x - this.mP1.x * this.mP2.y,this.mP1.x * this.mP2.y - this.mP1.y * this.mP2.x);
    };
    _loc2_.__get__mGradient = function __get__mGradient()
    {
        if(this._cache_Gradient == undefined)
        {
            var _loc2_ = this.__get__mDelta();
            return _loc2_.x / _loc2_.y;
        }
        return this._cache_Gradient;
    };
    _loc2_.SideOfLine = function SideOfLine(p)
    {
        return (this.mP1.x - p.x) * (this.mP2.y - p.y) - (this.mP2.x - p.x) * (this.mP1.y - p.y);
    };
    _loc2_.__get__mInverse = function __get__mInverse()
    {
        return new scidd.Math.CLine(this.mP2,this.mP1);
    };
    _loc2_.Scale = function Scale(tScale)
    {
        var _loc2_ = this.__get__mDelta();
        var _loc3_ = this.__get__mCentre();
        _loc2_.x *= tScale * 0.5;
        _loc2_.y *= tScale * 0.5;
        return new scidd.Math.CLine(_loc3_.subtract(_loc2_),_loc3_.add(_loc2_));
    };
    _loc2_.Scale1 = function Scale1(tScale)
    {
        var _loc2_ = this.__get__mDelta();
        _loc2_.x *= tScale;
        _loc2_.y *= tScale;
        return new scidd.Math.CLine(this.mP1,this.mP1.add(_loc2_));
    };
    _loc2_.Scale2 = function Scale2(tScale)
    {
        var _loc2_ = this.__get__mDelta();
        _loc2_.x *= tScale;
        _loc2_.y *= tScale;
        return new scidd.Math.CLine(this.mP2.subtract(_loc2_),this.mP2);
    };
    _loc2_.SetLength = function SetLength(tLength)
    {
        var _loc2_ = this.__get__mDelta();
        _loc2_.normalize(tLength / 2);
        var _loc3_ = this.__get__mCentre();
        return new scidd.Math.CLine(_loc3_.subtract(_loc2_),_loc3_.add(_loc2_));
    };
    _loc2_.SetLength1 = function SetLength1(tLength)
    {
        var _loc2_ = this.__get__mDelta();
        _loc2_.normalize(tLength);
        return new scidd.Math.CLine(this.mP1,this.mP1.add(_loc2_));
    };
    _loc2_.SetLength2 = function SetLength2(tLength)
    {
        var _loc2_ = this.__get__mDelta();
        _loc2_.normalize(tLength);
        return new scidd.Math.CLine(this.mP2.subtract(_loc2_),this.mP2);
    };
    _loc2_.Rotate = function Rotate(tAngle)
    {
        var _loc2_ = this.__get__mCentre();
        var _loc3_ = scidd.Math.CMath.GetMatrix_Angle(tAngle);
        return new scidd.Math.CLine(_loc3_.transformPoint(this.mP1.subtract(_loc2_)).add(_loc2_),_loc3_.transformPoint(this.mP2.subtract(_loc2_)).add(_loc2_));
    };
    _loc2_.Rotate90 = function Rotate90()
    {
        return new scidd.Math.CLine(this.mP1,this.mP1.subtract(this.__get__mNormal()));
    };
    _loc2_.Rotate180 = function Rotate180()
    {
        return new scidd.Math.CLine(this.mP1,this.mP1.subtract(this.__get__mDelta()));
    };
    _loc2_.Rotate270 = function Rotate270()
    {
        return new scidd.Math.CLine(this.mP1,this.mP1.add(this.__get__mNormal()));
    };
    _loc2_.Average = function Average(l2)
    {
        var _loc3_ = this.mP1.add(l2.mP1);
        var _loc2_ = this.mP2.add(l2.mP2);
        _loc3_.x /= 2;
        _loc3_.y /= 2;
        _loc2_.x /= 2;
        _loc2_.y /= 2;
        return new scidd.Math.CLine(_loc3_,_loc2_);
    };
    _loc2_.Distance_PointToLine = function Distance_PointToLine(p, inf)
    {
        return Math.sqrt(this.Distance_PointToLine_SQR(p,inf));
    };
    _loc2_.Distance_PointToLine_SQR = function Distance_PointToLine_SQR(p, inf)
    {
        if(inf)
        {
            var _loc2_ = this.__get__mDelta();
            var _loc3_ = p.subtract(this.mP1);
            var _loc8_ = (_loc2_.x * _loc3_.x + _loc2_.y * _loc3_.y) / (_loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y);
            var _loc10_ = p.x - (this.mP1.x + _loc2_.x * _loc8_);
            var _loc9_ = p.y - (this.mP1.y + _loc2_.y * _loc8_);
            return _loc10_ * _loc10_ + _loc9_ * _loc9_;
        }
        var _loc4_ = this;
        _loc2_ = _loc4_.__get__mDelta();
        _loc3_ = p.subtract(_loc4_.mP1);
        var _loc7_ = _loc2_.x * _loc3_.x + _loc2_.y * _loc3_.y;
        if(_loc7_ <= 0)
        {
            return _loc3_.x * _loc3_.x + _loc3_.y * _loc3_.y;
        }
        var _loc11_ = _loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y;
        if(_loc11_ <= _loc7_)
        {
            var _loc5_ = p.subtract(_loc4_.mP2);
            return _loc5_.x * _loc5_.x + _loc5_.y * _loc5_.y;
        }
        _loc8_ = _loc7_ / _loc11_;
        var _loc12_ = new flash.geom.Point(_loc4_.mP1.x + _loc8_ * _loc2_.x,_loc4_.mP1.y + _loc8_ * _loc2_.y);
        _loc5_ = p.subtract(_loc12_);
        return _loc5_.x * _loc5_.x + _loc5_.y * _loc5_.y;
    };
    _loc2_.ProjectPointToLine = function ProjectPointToLine(p, inf)
    {
        if(inf)
        {
            var _loc2_ = this.__get__mDelta();
            var _loc6_ = p.subtract(this.mP1);
            if(_loc2_.x == 0 && _loc2_.y == 0)
            {
                return this.mP1;
            }
            var _loc4_ = (_loc2_.x * _loc6_.x + _loc2_.y * _loc6_.y) / this.__get__mLength_SQR();
            return new flash.geom.Point(this.mP1.x + _loc4_ * _loc2_.x,this.mP1.y + _loc4_ * _loc2_.y);
        }
        _loc2_ = this.__get__mDelta();
        _loc6_ = p.subtract(this.mP1);
        if(_loc2_.x == 0 && _loc2_.y == 0)
        {
            return this.mP1;
        }
        var _loc3_ = _loc2_.x * _loc6_.x + _loc2_.y * _loc6_.y;
        var _loc5_ = this.__get__mLength_SQR();
        if(_loc5_ <= _loc3_ || _loc3_ < 0)
        {
            return undefined;
        }
        _loc4_ = _loc3_ / _loc5_;
        return new flash.geom.Point(this.mP1.x + _loc4_ * _loc2_.x,this.mP1.y + _loc4_ * _loc2_.y);
    };
    _loc2_.DirectionToPoint = function DirectionToPoint(p)
    {
        var _loc2_ = this.__get__mDelta();
        var _loc3_ = p.subtract(this.mP1);
        return (_loc2_.x * _loc3_.x + _loc2_.y * _loc3_.y) / this.__get__mLength_SQR();
    };
    _loc2_.IsPointOnLine = function IsPointOnLine(p)
    {
        if(Math.abs((this.mP1.x - p.x) * (this.mP2.y - p.y) - (this.mP2.x - p.x) * (this.mP1.y - p.y)) < 0.00001)
        {
            var _loc2_ = this.__get__mDelta();
            var _loc5_ = p.subtract(this.mP1);
            var _loc4_ = _loc5_.x * _loc2_.x + _loc5_.y * _loc2_.y;
            var _loc6_ = _loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y;
            if(_loc4_ >= 0 && _loc6_ >= _loc4_)
            {
                return true;
            }
        }
        return false;
    };
    _loc2_.Parallel = function Parallel(tLine)
    {
        var _loc3_ = this.__get__mDelta();
        var _loc2_ = tLine.__get__mDelta();
        return Math.abs(_loc3_.y * _loc2_.x - _loc3_.x * _loc2_.y) >= 0.00001 ? false : true;
    };
    _loc2_.GetRectangle = function GetRectangle()
    {
        var _loc2_ = undefined;
        var _loc3_ = undefined;
        var _loc4_ = undefined;
        var _loc5_ = undefined;
        if(this.mP1.x > this.mP2.x)
        {
            _loc2_ = this.mP2.x;
            _loc4_ = this.mP1.x;
        }
        else
        {
            _loc2_ = this.mP1.x;
            _loc4_ = this.mP2.x;
        }
        if(this.mP1.y > this.mP2.y)
        {
            _loc3_ = this.mP2.y;
            _loc5_ = this.mP1.y;
        }
        else
        {
            _loc3_ = this.mP1.y;
            _loc5_ = this.mP2.y;
        }
        return new flash.geom.Rectangle(_loc2_,_loc3_,_loc4_ - _loc2_,_loc5_ - _loc3_);
    };
    _loc2_.Intersects = function Intersects(cLine, rp, inf)
    {
        if(inf)
        {
            var _loc4_ = this.__get__mDelta();
            var _loc6_ = cLine.__get__mDelta();
            var _loc12_ = _loc4_.y * _loc6_.x - _loc4_.x * _loc6_.y;
            if(Math.abs(_loc12_) < 0.00001)
            {
                return false;
            }
            var _loc9_ = cLine.mP1.subtract(this.mP1);
            var _loc14_ = (_loc6_.y * _loc9_.x - _loc6_.x * _loc9_.y) / _loc12_;
            rp.x = this.mP1.x - _loc4_.x * _loc14_;
            rp.y = this.mP1.y - _loc4_.y * _loc14_;
            return true;
        }
        var _loc2_ = cLine.mP1;
        var _loc7_ = cLine.mP2;
        _loc4_ = cLine.__get__mDelta();
        _loc6_ = this.__get__mDelta();
        var _loc13_ = _loc4_.x * _loc6_.y;
        var _loc11_ = _loc6_.x * _loc4_.y;
        var _loc5_ = ((_loc2_.y - this.mP1.y) * _loc6_.x - (_loc2_.x - this.mP1.x) * _loc6_.y) / (_loc13_ - _loc11_);
        if(isNaN(_loc5_))
        {
            if(_loc2_.equals(_loc7_))
            {
                rp.x = _loc7_.x;
                rp.y = _loc7_.y;
            }
            else
            {
                if(!this.mP1.equals(this.mP2))
                {
                    return false;
                }
                rp.x = this.mP1.x;
                rp.y = this.mP1.y;
            }
        }
        else
        {
            rp.x = _loc2_.x + _loc5_ * _loc4_.x;
            rp.y = _loc2_.y + _loc5_ * _loc4_.y;
        }
        var _loc10_ = ((this.mP1.y - _loc2_.y) * _loc4_.x - (this.mP1.x - _loc2_.x) * _loc4_.y) / (_loc11_ - _loc13_);
        return !(_loc5_ >= 0 && _loc5_ <= 1 && _loc10_ >= 0 && _loc10_ <= 1) ? false : true;
    };
    _loc2_.DoesIntersect_Infinate = function DoesIntersect_Infinate(cLine)
    {
        return this.SideOfLine(cLine.mP1) != this.SideOfLine(cLine.mP2);
    };
    _loc2_.CrossLine = function CrossLine(cLine)
    {
        var _loc3_ = this.SideOfLine(cLine.mP1);
        var _loc2_ = this.SideOfLine(cLine.mP2);
        if(_loc3_ > _loc2_)
        {
            return -1;
        }
        if(_loc3_ < _loc2_)
        {
            return 1;
        }
        return 0;
    };
    _loc2_.Reflect = function Reflect(v, tElasticity)
    {
        var _loc2_ = this.__get__mNormal();
        _loc2_.normalize(1);
        var _loc3_ = 2 * (v.x * _loc2_.x + v.y * _loc2_.y);
        return new flash.geom.Point(_loc3_ * _loc2_.x,_loc3_ * v.y);
    };
    _loc2_.__get__mOrientation = function __get__mOrientation()
    {
        return this._cache_Orientation != undefined ? this._cache_Orientation : (this._cache_Orientation = this.GetOrientation(0));
    };
    _loc2_.__get__mOrientation180 = function __get__mOrientation180()
    {
        return this._cache_Orientation180 != undefined ? this._cache_Orientation180 : (this._cache_Orientation180 = this.GetOrientation(3.141592653589793));
    };
    _loc2_.GetOrientation = function GetOrientation(tAdjustAngle)
    {
        tAdjustAngle = tAdjustAngle != undefined ? tAdjustAngle : 0;
        var _loc2_ = {mMatrix:new flash.geom.Matrix(),iMatrix:new flash.geom.Matrix(),mPosition:this.mP1,mAngle:Math.atan2(this.mP2.y - this.mP1.y,this.mP2.x - this.mP1.x) + tAdjustAngle};
        _loc2_.iMatrix.rotate(_loc2_.mAngle);
        _loc2_.iMatrix.translate(_loc2_.mPosition.x,_loc2_.mPosition.y);
        _loc2_.mMatrix.translate(0 - _loc2_.mPosition.x,0 - _loc2_.mPosition.y);
        _loc2_.mMatrix.rotate(0 - _loc2_.mAngle);
        return _loc2_;
    };
    _loc2_.ApplyMatrix = function ApplyMatrix(m)
    {
        return new scidd.Math.CLine(m.transformPoint(this.mP1),m.transformPoint(this.mP2));
    };
    _loc2_._CLASSID_ = "scidd.Math.CLine";
    §§push(_loc2_.addProperty("mAngle",_loc2_.__get__mAngle,0));
    §§push(_loc2_.addProperty("mCentre",_loc2_.__get__mCentre,0));
    §§push(_loc2_.addProperty("mCrossProduct",_loc2_.__get__mCrossProduct,0));
    §§push(_loc2_.addProperty("mDelta",_loc2_.__get__mDelta,0));
    §§push(_loc2_.addProperty("mGradient",_loc2_.__get__mGradient,0));
    §§push(_loc2_.addProperty("mInverse",_loc2_.__get__mInverse,0));
    §§push(_loc2_.addProperty("mLength",_loc2_.__get__mLength,0));
    §§push(_loc2_.addProperty("mLength_SQR",_loc2_.__get__mLength_SQR,0));
    §§push(_loc2_.addProperty("mNormal",_loc2_.__get__mNormal,0));
    §§push(_loc2_.addProperty("mNormalUnit",_loc2_.__get__mNormalUnit,0));
    §§push(_loc2_.addProperty("mOrientation",_loc2_.__get__mOrientation,0));
    §§push(_loc2_.addProperty("mOrientation180",_loc2_.__get__mOrientation180,0));
    §§push(ASSetPropFlags(scidd.Math.CLine.prototype,null,1));
}
§§pop();
