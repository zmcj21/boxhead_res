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
if(!_global.scidd.Math.CMath)
{
    scidd.Math.CMath = 0;
    var _loc2_ = 0.prototype;
    0.DotProduct = function(p1, p2)
    {
        return p1.x * p2.x + p1.y * p2.y;
    };
    0.CrossProduct = function(p1, p2)
    {
        return new flash.geom.Point(p1.y * p2.x - p1.x * p2.y,p1.x * p2.y - p1.y * p2.x);
    };
    0.CrossProduct_Origin = function(o, p1, p2)
    {
        return scidd.Math.CMath.CrossProduct(p1.subtract(o),p2.subtract(o));
    };
    0.Range = function(tNumber, tMin, tMax)
    {
        return tNumber <= tMax ? (tNumber >= tMin ? tNumber : tMin) : tMax;
    };
    0.Never0 = function(tNumber)
    {
        return tNumber != 0 ? tNumber : 0.000001;
    };
    0.Sign = function(tNumber)
    {
        return tNumber >= 0 ? (tNumber <= 0 ? 0 : 1) : -1;
    };
    0.Tween = function(tMin, tMax, tFactor, tEaseIn, pow)
    {
        tEaseIn = tEaseIn != undefined ? tEaseIn : 0;
        if(tEaseIn != 0)
        {
            pow = pow != undefined ? pow : 15;
            tFactor = tEaseIn <= 0 ? Math.pow(tFactor,pow * (0 - tEaseIn) + 1) : 1 - Math.pow(1 - tFactor,pow * tEaseIn + 1);
        }
        return (tMax - tMin) * tFactor + tMin;
    };
    0.Define = function(tObject, tDefault)
    {
        return tObject != undefined ? tObject : tDefault;
    };
    0.Round = function(tNumber, tBase)
    {
        return Math.round(tNumber / tBase) * tBase;
    };
    0.Floor = function(tNumber, tBase)
    {
        return Math.floor(tNumber / tBase) * tBase;
    };
    0.Ceil = function(tNumber, tBase)
    {
        return Math.ceil(tNumber / tBase) * tBase;
    };
    0.DecimalPlaces = function(tNumber)
    {
        0;
        while(tNumber % 1 != 0)
        {
            tNumber *= 10;
            1;
        }
        return 1;
    };
    0.GetLineNormal = function(p1, p2)
    {
        var _loc1_ = new flash.geom.Matrix();
        _loc1_.rotate(-1.5707963267948966);
        var _loc2_ = _loc1_.transformPoint(new flash.geom.Point(p2.x - p1.x,p2.y - p1.y));
        _loc2_.normalize(1);
        return _loc2_;
    };
    0.GetAngle = function(p1, p2)
    {
        return Math.atan2(p2.y - p1.y,p2.x - p1.x);
    };
    0.CorrectAngle = function(a)
    {
        while(a < 0)
        {
            a += scidd.Math.CMath.r360;
        }
        a %= scidd.Math.CMath.r360;
        return a;
    };
    0.RotationDirection = function(angle, targetAngle)
    {
        var _loc1_ = scidd.Math.CMath.CorrectAngle(targetAngle) - scidd.Math.CMath.CorrectAngle(angle);
        if(_loc1_ < -3.141592653589793)
        {
            return 0 - (scidd.Math.CMath.r360 + _loc1_);
        }
        if(_loc1_ > 3.141592653589793)
        {
            return _loc1_ - scidd.Math.CMath.r360;
        }
        return _loc1_;
    };
    0.SideOfLine = function(p, p1, p2)
    {
        return (p1.x - p.x) * (p2.y - p.y) - (p2.x - p.x) * (p1.y - p.y);
    };
    0.SideOfLine_SIGN = function(p, p1, p2)
    {
        return scidd.Math.CMath.Sign(scidd.Math.CMath.SideOfLine(p,p1,p2));
    };
    0.PointInTriangle = function(p, pList)
    {
        var _loc4_ = scidd.Math.CMath.SideOfLine_SIGN(p,pList[0],pList[1]);
        var _loc3_ = scidd.Math.CMath.SideOfLine_SIGN(p,pList[1],pList[2]);
        var _loc2_ = scidd.Math.CMath.SideOfLine_SIGN(p,pList[2],pList[0]);
        return (_loc4_ == _loc3_ || _loc4_ == 0) && (_loc3_ == _loc2_ || _loc3_ == 0) && (_loc2_ == _loc4_ || _loc2_ == 0);
    };
    0.PointInShape = function(p, pShape)
    {
        0;
        while(0 < pShape.length - 1)
        {
            if(scidd.Math.CMath.SideOfLine(p,pShape[0],pShape[1]) < 0)
            {
                return false;
            }
            1;
        }
        if(scidd.Math.CMath.SideOfLine(p,pShape[pShape.length - 1],pShape[0]) < 0)
        {
            return false;
        }
        return true;
    };
    0.PointInShape_Closed = function(p, pShape)
    {
        0;
        while(0 < pShape.length - 1)
        {
            if(scidd.Math.CMath.SideOfLine(p,pShape[0],pShape[1]) < 0)
            {
                return false;
            }
            1;
        }
        return true;
    };
    0.LineIntersection = function(l1p1, l1p2, l2p1, l2p2)
    {
        var _loc5_ = l2p2.x - l2p1.x;
        var _loc4_ = l2p2.y - l2p1.y;
        var _loc8_ = l1p2.x - l1p1.x;
        var _loc7_ = l1p2.y - l1p1.y;
        var _loc3_ = ((l2p1.y - l1p1.y) * _loc8_ - (l2p1.x - l1p1.x) * _loc7_) / (_loc5_ * _loc7_ - _loc4_ * _loc8_);
        var _loc6_ = new flash.geom.Point(l2p1.x + _loc3_ * _loc5_,l2p1.y + _loc3_ * _loc4_);
        if(isNaN(_loc6_.x))
        {
            _loc6_ = !l2p1.equals(l2p2) ? (!l1p1.equals(l1p2) ? undefined : l1p1.clone()) : l2p2.clone();
        }
        var _loc10_ = ((l1p1.y - l2p1.y) * _loc5_ - (l1p1.x - l2p1.x) * _loc4_) / (_loc8_ * _loc4_ - _loc7_ * _loc5_);
        return !(_loc3_ >= 0 && _loc3_ <= 1 && _loc10_ >= 0 && _loc10_ <= 1) ? undefined : _loc6_;
    };
    0.LineIntersection2 = function(l1p1, l1p2, l2p1, l2p2)
    {
        var _loc11_ = l1p2.y - l1p1.y;
        var _loc9_ = l1p1.x - l1p2.x;
        var _loc10_ = l2p2.y - l2p1.y;
        var _loc7_ = l2p1.x - l2p2.x;
        var _loc1_ = _loc11_ * _loc7_ - _loc10_ * _loc9_;
        if(Math.abs(_loc1_) < 0.00001)
        {
            return undefined;
        }
        var _loc8_ = l1p2.x * l1p1.y - l1p1.x * l1p2.y;
        var _loc6_ = l2p2.x * l2p1.y - l2p1.x * l2p2.y;
        return new flash.geom.Point((_loc9_ * _loc6_ - _loc7_ * _loc8_) / _loc1_,(_loc10_ * _loc8_ - _loc11_ * _loc6_) / _loc1_);
    };
    0.LineIntersection3 = function(l1p1, l1p2, l2p1, l2p2, rp)
    {
        if(l1p2.x == l1p1.x || l2p2.x == l2p1.x)
        {
            return false;
        }
        var _loc4_ = (l1p2.y - l1p1.y) / (l1p2.x - l1p1.x);
        var _loc7_ = (l2p2.y - l2p1.y) / (l2p2.x - l2p1.x);
        if(_loc4_ == _loc7_)
        {
            return false;
        }
        var _loc8_ = l1p1.y - _loc4_ * l1p1.x;
        var _loc9_ = l2p1.y - _loc7_ * l2p1.x;
        rp.x = (_loc9_ - _loc8_) / (_loc4_ - _loc7_);
        if(rp.x < Math.min(l1p1.x,l1p2.x) || rp.x > Math.max(l1p1.x,l1p2.x))
        {
            return false;
        }
        if(rp.x < Math.min(l2p1.x,l2p2.x) || rp.x > Math.max(l2p1.x,l2p2.x))
        {
            return false;
        }
        rp.y = _loc4_ * rp.x + _loc8_;
        return true;
    };
    0.LineIntersection4 = function(l1p1, l1p2, l2p1, l2p2, rp)
    {
        if(scidd.Math.CMath.SideOfLine(l1p1,l2p1,l2p2) > 0)
        {
            return false;
        }
        var _loc1_ = scidd.Math.CMath.LineIntersection(l1p1,l1p2,l2p1,l2p2);
        if(_loc1_ == undefined)
        {
            return false;
        }
        rp.x = _loc1_.x;
        rp.y = _loc1_.y;
        return true;
    };
    0.GetIntersectionPoint2 = function(l1p1, l1p2, l2p1, l2p2, tOut)
    {
        var _loc1_ = l2p1.y * l2p2.x - l2p1.x * l2p2.y;
        if(Math.abs(_loc1_) < 0.00001)
        {
            return false;
        }
        var _loc2_ = l1p2.subtract(l1p1);
        var _loc5_ = (l2p2.y * _loc2_.x - l2p2.x * _loc2_.y) / _loc1_;
        tOut.x = l1p1.x - l2p1.x * _loc5_;
        tOut.y = l1p1.y - l2p1.y * _loc5_;
        return true;
    };
    0.LineToLine_Parallel = function(l1p1, l1p2, l2p1, l2p2)
    {
        var _loc1_ = l2p1.y * l2p2.x - l2p1.x * l2p2.y;
        return Math.abs(_loc1_) >= 0.00001;
    };
    0.Distance_PointToLine = function(p, lp1, lp2)
    {
        return Math.sqrt(scidd.Math.CMath.Distance_PointToLine_Sqr(p,lp1,lp2));
    };
    0.Distance_PointToLine_Sqr = function(p, lp1, lp2)
    {
        var _loc1_ = lp2.subtract(lp1);
        var _loc8_ = p.subtract(lp1);
        var _loc5_ = scidd.Math.CMath.DotProduct(_loc8_,_loc1_);
        var _loc4_ = scidd.Math.CMath.DotProduct(_loc1_,_loc1_);
        var _loc3_ = _loc5_ / _loc4_;
        var _loc7_ = lp1.add(new flash.geom.Point(_loc1_.x * _loc3_,_loc1_.y * _loc3_));
        var _loc2_ = p.subtract(_loc7_);
        return _loc2_.x * _loc2_.x + _loc2_.y * _loc2_.y;
    };
    0.Distance_PointToLine2 = function(p, lp1, lp2)
    {
        return Math.abs(scidd.Math.CMath.CrossProduct_Origin(lp1,lp2,p) / flash.geom.Point.distance(lp1,lp2));
    };
    0.Distance_Sqr = function(p1, p2)
    {
        var _loc1_ = p2.subtract(p1);
        return _loc1_.x * _loc1_.x + _loc1_.y * _loc1_.y;
    };
    0.ScalePoint = function(p, tScale)
    {
        var _loc1_ = p.clone();
        _loc1_.x *= tScale;
        _loc1_.y *= tScale;
        return _loc1_;
    };
    0.GetMatrix = function(p, a)
    {
        var _loc2_ = Math.cos(a);
        var _loc1_ = Math.sin(a);
        return new flash.geom.Matrix(_loc2_,_loc1_,0 - _loc1_,_loc2_,p.x,p.y);
    };
    0.GetMatrix_Angle = function(a)
    {
        var _loc2_ = Math.cos(a);
        var _loc1_ = Math.sin(a);
        return new flash.geom.Matrix(_loc2_,_loc1_,0 - _loc1_,_loc2_,0,0);
    };
    _loc2_._CLASSID_ = "scidd.Math.CMath";
    0.r360 = 6.283185307179586;
    0.DegToRad = 0.017453292519943295;
    0.degToRad = 0.017453292519943295;
    0.RadToDeg = 57.29577951308232;
    0.radToDeg = 57.29577951308232;
    §§push(ASSetPropFlags(scidd.Math.CMath.prototype,null,1));
}
§§pop();
