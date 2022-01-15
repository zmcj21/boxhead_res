class World.Map.CMap_Collide
{
    var Dispose = 0;
    var _CLASSID_ = "CMap_Collide";
    var _BASECLASSID_ = "CMap_Collide";
    static var _StepSize = 1;
    function CMap_Collide(tMap)
    {
        this.mMap = tMap;
        this.mCells = this.mMap.mCells;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function MarkArea_PP(p1, p2, cFlags)
    {
        var _loc4_ = p1.mY;
        while(_loc4_ < p2.mY)
        {
            var _loc2_ = p1.mX;
            var _loc3_ = this.mCells[_loc4_];
            while(_loc2_ < p2.mX)
            {
                _loc3_[_loc2_].mCollide |= cFlags;
                _loc2_ = _loc2_ + 1;
            }
            _loc4_ = _loc4_ + 1;
        }
    }
    function PlayerCollide(tThing)
    {
        var _loc5_ = tThing.mPosition;
        if(this.mCells[_loc5_.mY & 65535][_loc5_.mX & 65535].mCollide & World.Map.CMap_Cell.mCollide_StaticImpassable)
        {
            return _loc5_;
        }
        3;
        while(true)
        {
            this.mCollideFlag = false;
            var _loc3_ = this.Collide_Mapwho(tThing.mPosition.Add(tThing.mDelta),tThing.mRadius,tThing.mID);
            tThing.mDelta.mX = _loc3_.mX - tThing.mPosition.mX;
            tThing.mDelta.mY = _loc3_.mY - tThing.mPosition.mY;
            _loc3_ = this.Collide_Map(tThing.mPosition,tThing.mDelta,tThing.mRadius * 0.85);
            if(!this.mCollideFlag)
            {
                break;
            }
            2;
        }
        return _loc3_;
    }
    function CreatureCollide(tThing)
    {
        var _loc5_ = tThing.mPosition;
        if(this.mCells[_loc5_.mY & 65535][_loc5_.mX & 65535].mCollide & World.Map.CMap_Cell.mCollide_EdgeOfMap)
        {
            return _loc5_;
        }
        1;
        while(true)
        {
            this.mCollideFlag = false;
            var _loc3_ = this.Collide_Mapwho(tThing.mPosition.Add(tThing.mDelta),tThing.mRadius,tThing.mID);
            tThing.mDelta.mX = _loc3_.mX - tThing.mPosition.mX;
            tThing.mDelta.mY = _loc3_.mY - tThing.mPosition.mY;
            _loc3_ = this.Collide_Map(tThing.mPosition,tThing.mDelta,tThing.mRadius);
            if(!this.mCollideFlag)
            {
                break;
            }
            0;
        }
        tThing.mDelta.mX = _loc3_.mX - tThing.mPosition.mX;
        tThing.mDelta.mY = _loc3_.mY - tThing.mPosition.mY;
        return _loc3_;
    }
    function BounceCollide(tThing)
    {
        this.mCollideFlag = false;
        var _loc3_ = tThing.mDelta.Clone();
        var _loc4_ = this.Collide_Mapwho_Height(tThing.mPosition.Add(_loc3_),tThing.mRadius,tThing.mID);
        _loc3_.mX = _loc4_.mX - tThing.mPosition.mX;
        _loc3_.mY = _loc4_.mY - tThing.mPosition.mY;
        _loc4_ = this.Collide_Map(tThing.mPosition,_loc3_,tThing.mRadius);
        if(!this.mCollideFlag)
        {
            return false;
        }
        _loc3_ = tThing.mDelta;
        var _loc5_ = _loc4_.Subtract(tThing.mPosition.Add(_loc3_)).Normalize2D(1);
        var _loc6_ = 2 * (_loc3_.mX * _loc5_.mX + _loc3_.mY * _loc5_.mY);
        tThing.mDelta.mX = _loc3_.mX - _loc5_.mX * _loc6_;
        tThing.mDelta.mY = _loc3_.mY - _loc5_.mY * _loc6_;
        return true;
    }
    function GenericCollide(tThing)
    {
        this.mCollideFlag = false;
        var _loc3_ = tThing.mDelta.Clone();
        var _loc4_ = this.Collide_Mapwho(tThing.mPosition.Add(_loc3_),tThing.mRadius,tThing.mID);
        _loc3_.mX = _loc4_.mX - tThing.mPosition.mX;
        _loc3_.mY = _loc4_.mY - tThing.mPosition.mY;
        _loc4_ = this.Collide_Map(tThing.mPosition,_loc3_,tThing.mRadius);
        return this.mCollideFlag;
    }
    function Collide_Map(main_p, main_d, main_r)
    {
        if(isNaN(main_p.mX) || isNaN(main_d.mX))
        {
            trace("Collide_Map = " + main_p + ", " + main_d);
        }
        if(this.mCells[main_p.mY & 65535][main_p.mX & 65535].mCollide & World.Map.CMap_Cell.mCollide_EdgeOfMap)
        {
            return main_p;
        }
        var _loc2_ = main_p.Add(main_d);
        if(!this.QCollide_Map(_loc2_,main_r))
        {
            return _loc2_;
        }
        this.mCollideFlag = true;
        _loc2_.mY = main_p.mY;
        if(!this.QCollide_Map(_loc2_,main_r))
        {
            return _loc2_;
        }
        _loc2_.mY = main_p.mY + main_d.mY;
        _loc2_.mX = main_p.mX;
        if(!this.QCollide_Map(_loc2_,main_r))
        {
            return _loc2_;
        }
        return main_p;
    }
    function QCollide_Map(main_p, main_r, main_ry)
    {
        var _loc5_ = new flash.geom.Rectangle(main_p.mX - main_r,main_p.mY - main_r,main_r * 2,main_r * 2);
        var _loc2_ = this.mMap.GetCellList_Area(_loc5_,true);
        for(var _loc3_ in _loc2_)
        {
            if(_loc2_[_loc3_].mCollide & World.Map.CMap_Cell.mCollide_StaticImpassable)
            {
                return true;
            }
        }
        return false;
    }
    function Collide_Mapwho(main_p, main_r, main_ID)
    {
        var _loc8_ = this.mMap.GetCellList_Area(new flash.geom.Rectangle(main_p.mX - main_r,main_p.mY - main_r,main_r * 2,main_r * 2),false);
        var _loc6_ = undefined;
        for(var _loc11_ in _loc8_)
        {
            var _loc7_ = _loc8_[_loc11_].mObjects;
            for(var _loc9_ in _loc7_)
            {
                var _loc2_ = _loc7_[_loc9_];
                if(_loc2_.mFlags & Thing.CThing.mFlag_Collidable && main_ID != _loc2_.mID)
                {
                    if((_loc6_ = _loc2_.mPosition.Distance2D(main_p)) < main_r + _loc2_.mRadius)
                    {
                        _loc2_.mCollidedWithID = _loc2_.mID;
                        var _loc4_ = main_p.Subtract(_loc2_.mPosition);
                        _loc4_.ScaleN((main_r + _loc2_.mRadius - _loc6_) / _loc6_);
                        main_p = main_p.Add(_loc4_);
                        if(isNaN(main_p.mX))
                        {
                            trace("Collide_Mapwho.main_p/cDelta = " + main_p + ", " + _loc4_ + ", " + _loc2_.mPosition + ", " + main_r + ", " + _loc2_.mRadius);
                        }
                        this.mCollideFlag = true;
                    }
                }
            }
        }
        return main_p;
    }
    function Collide_Mapwho_Height(main_p, main_r, main_ID)
    {
        var _loc9_ = this.mMap.GetCellList_Area(new flash.geom.Rectangle(main_p.mX - main_r,main_p.mY - main_r,main_r * 2,main_r * 2),false);
        var _loc6_ = undefined;
        for(var _loc12_ in _loc9_)
        {
            var _loc7_ = _loc9_[_loc12_].mObjects;
            for(var _loc10_ in _loc7_)
            {
                var _loc2_ = _loc7_[_loc10_];
                if(_loc2_.mFlags & Thing.CThing.mFlag_Collidable && main_ID != _loc2_.mID)
                {
                    var _loc4_ = _loc2_.mPosition;
                    if((_loc6_ = _loc4_.Distance2D(main_p)) < main_r + _loc2_.mRadius && main_p.mZ < _loc4_.mZ + _loc2_.mHeight)
                    {
                        _loc2_.mCollidedWithID = _loc2_.mID;
                        var _loc5_ = main_p.Subtract(_loc4_);
                        _loc5_.ScaleN((main_r + _loc2_.mRadius - _loc6_) / _loc6_);
                        main_p = main_p.Add(_loc5_);
                        this.mCollideFlag = true;
                    }
                }
            }
        }
        return main_p;
    }
    function Collide_Line(cThing, p1, p2, radius, cAffectFlags, cMapOnly)
    {
        var _loc6_ = p2.Subtract(p1);
        var _loc5_ = _loc6_.__get__mLength() / World.Map.CMap_Collide._StepSize;
        var _loc2_ = new flash.geom.Rectangle(p1.mX - radius,p1.mY - radius,radius * 2,radius * 2);
        var _loc8_ = _loc6_.mX / _loc5_;
        var _loc7_ = _loc6_.mY / _loc5_;
        var _loc4_ = new scidd.Math.CLine(p1.toPoint(),p2.toPoint());
        _loc4_.mTag = new Object();
        _loc4_.mTag.xGradient = _loc6_.mY / _loc6_.mX;
        _loc4_.mTag.yGradient = _loc6_.mX / _loc6_.mY;
        _loc4_.mTag.xDirection = scidd.Math.CMath.Sign(_loc6_.mX);
        _loc4_.mTag.yDirection = scidd.Math.CMath.Sign(_loc6_.mY);
        _loc4_.mTag.mID = cThing.mID;
        _loc4_.mTag.cAffectFlags = cAffectFlags;
        _loc4_.mTag.f = !cMapOnly ? "LineIntersection" : "LineIntersection_Map";
        World.Map.CMap_Cell.mCurrentSessionID++;
        var _loc3_ = undefined;
        while(_loc5_ > 0)
        {
            if(_loc3_ = this._Collide_Line_Area(_loc2_,_loc4_))
            {
                break;
            }
            _loc5_ -= World.Map.CMap_Collide._StepSize;
            _loc2_.x += _loc8_;
            _loc2_.y += _loc7_;
        }
        if(_loc3_ == undefined)
        {
            _loc2_.x = p2.mX;
            _loc2_.y = p2.mY;
            if(_loc3_ = this._Collide_Line_Area(_loc2_,_loc4_))
            {
                return _loc3_;
            }
        }
        if(_loc3_ == undefined)
        {
            return undefined;
        }
        var _loc11_ = _loc3_.mThing;
        if(_loc11_)
        {
            var _loc9_ = _loc3_.mPOI;
            _loc9_.x -= p1.mX;
            _loc9_.y -= p1.mY;
            _loc9_.normalize(_loc9_.length - _loc11_.mRadius);
            _loc9_.x += p1.mX;
            _loc9_.y += p1.mY;
        }
        return _loc3_;
    }
    function _Collide_Line_Area(rArea, cLine)
    {
        var _loc4_ = this.mMap.GetCellList_Area_FilterSessionID(rArea,false,World.Map.CMap_Cell.mCurrentSessionID);
        1.7976931348623157e+308;
        var _loc2_ = undefined;
        var _loc7_ = undefined;
        var _loc11_ = undefined;
        var _loc5_ = undefined;
        var _loc8_ = cLine.mTag.f;
        for(var _loc9_ in _loc4_)
        {
            if(_loc2_ = _loc4_[_loc9_]._loc8_(cLine))
            {
                if((_loc5_ = scidd.Math.CMath.Distance_Sqr(_loc2_.mPOI,cLine.mP1)) < 1.7976931348623157e+308)
                {
                    _loc3_ = _loc5_;
                    _loc7_ = _loc2_;
                }
            }
        }
        return _loc7_;
    }
}
