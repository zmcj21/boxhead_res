class World.Map.CMap_Affect
{
    var Dispose = 0;
    var _CLASSID_ = "CMap_Affect";
    var _BASECLASSID_ = "CMap_Affect";
    static var _StepSize = 1;
    function CMap_Affect(tMap)
    {
        this.mMap = tMap;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function AffectArea(tArea, tAffect)
    {
        var _loc5_ = this.mMap.GetCellList_Area(tArea);
        for(var _loc7_ in _loc5_)
        {
            if(_loc5_[_loc7_].mChildCount)
            {
                var _loc3_ = _loc5_[_loc7_].mObjects;
                for(var _loc6_ in _loc3_)
                {
                    var _loc2_ = _loc3_[_loc6_];
                    if(_loc2_.mAffectFlags & tAffect.mType && tAffect.mAffector.mID != _loc2_.mID)
                    {
                        _loc2_.Affect(tAffect);
                    }
                }
            }
        }
    }
    function Affect_Line(cThing, p1, p2, radius, tAffect)
    {
        var _loc9_ = p2.Subtract(p1);
        var _loc7_ = _loc9_.__get__mLength() / World.Map.CMap_Affect._StepSize;
        var _loc4_ = new flash.geom.Rectangle(p1.mX - radius,p1.mY - radius,radius * 2,radius * 2);
        var _loc11_ = _loc9_.mX / _loc7_;
        var _loc10_ = _loc9_.mY / _loc7_;
        var _loc6_ = new scidd.Math.CLine(p1.toPoint(),p2.toPoint());
        _loc6_.mTag = new Object();
        _loc6_.mTag.xGradient = _loc9_.mY / _loc9_.mX;
        _loc6_.mTag.yGradient = _loc9_.mX / _loc9_.mY;
        _loc6_.mTag.xDirection = scidd.Math.CMath.Sign(_loc9_.mX);
        _loc6_.mTag.yDirection = scidd.Math.CMath.Sign(_loc9_.mY);
        _loc6_.mTag.mID = cThing.mID;
        _loc6_.mTag.cAffectFlags = tAffect.mType;
        var _loc3_ = new Array();
        var _loc8_ = undefined;
        World.Map.CMap_Cell.mCurrentSessionID++;
        var _loc12_ = undefined;
        while(_loc7_ > 0)
        {
            if(_loc8_ = this._Affect_Line_Area(_loc4_,_loc6_))
            {
                _loc3_ = _loc3_.concat(_loc8_);
            }
            _loc7_ -= World.Map.CMap_Affect._StepSize;
            _loc4_.x += _loc11_;
            _loc4_.y += _loc10_;
        }
        _loc4_.x = p2.mX;
        _loc4_.y = p2.mY;
        if(_loc8_ = this._Affect_Line_Area(_loc4_,_loc6_))
        {
            _loc3_ = _loc3_.concat(_loc8_);
        }
        for(var _loc13_ in _loc3_)
        {
            var _loc2_ = _loc3_[_loc13_];
            if(_loc2_.mAffectFlags & tAffect.mType && tAffect.mAffector.mID != _loc2_.mID)
            {
                _loc2_.Affect(tAffect);
            }
        }
        return _loc3_.length;
    }
    function _Affect_Line_Area(rArea, cLine)
    {
        var _loc3_ = this.mMap.GetCellList_Area_FilterSessionID(rArea,false,World.Map.CMap_Cell.mCurrentSessionID);
        var _loc2_ = new Array();
        var _loc4_ = undefined;
        for(var _loc6_ in _loc3_)
        {
            if(_loc4_ = _loc3_[_loc6_].LineIntersection_ThingList(cLine))
            {
                _loc2_ = _loc2_.concat(_loc4_);
            }
        }
        return _loc2_;
    }
}
