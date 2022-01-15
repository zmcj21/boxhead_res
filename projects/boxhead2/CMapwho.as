class CMapwho
{
    var Dispose = 0;
    var _CLASSID_ = "CMapwho";
    static var mCellSize = new flash.geom.Point(32,32);
    static var mCellSizeHalf = new flash.geom.Point(CMapwho.mCellSize.x / 2,CMapwho.mCellSize.y / 2);
    static var mCellSizeShift = 5;
    static var _ERROR = false;
    static var mCollide_None = 0;
    static var mCollide_Solid = 1;
    static var mCollide_Shot = 2;
    static var mCollide_Path = 4;
    static var mCollide_Road = 8;
    static var mCollide_Dude = 16;
    static var mCollide_Player = 32;
    static var mCollide_Object = 64;
    static var mCollide_CollideAll = CMapwho.mCollide_Solid | CMapwho.mCollide_Dude | CMapwho.mCollide_Object | CMapwho.mCollide_Player;
    var mGlobalID = 0;
    function CMapwho(tRect)
    {
        this.mCoordSize = new flash.geom.Point(tRect.width,tRect.height);
        this.mSize = new flash.geom.Point(Math.ceil(tRect.width / CMapwho.mCellSize.x),Math.ceil(tRect.height / CMapwho.mCellSize.y));
        this.mMap = new Array();
        0;
        while(0 < this.mSize.y)
        {
            this.mMap[0] = new Array();
            0;
            var _loc4_ = this.mMap[0];
            while(0 < this.mSize.x)
            {
                _loc4_[0] = {mPoint:new flash.geom.Point(0 * CMapwho.mCellSize.x,0 * CMapwho.mCellSize.y),mID:new flash.geom.Point(0,0),mChild:undefined,mChildCount:0,mCollide:CMapwho.mCollide_None};
                1;
            }
            1;
        }
        this.mFearAreas = new Array();
    }
    static function CentrePosition(p)
    {
        return new scidd.Math.CPointXYZ(Math.floor(p.mX / CMapwho.mCellSize.x) * CMapwho.mCellSize.x + CMapwho.mCellSize.x / 2,Math.floor(p.mY / CMapwho.mCellSize.y) * CMapwho.mCellSize.y + CMapwho.mCellSize.y / 2,p.mZ);
    }
    function MarkCollision(tRect, tType)
    {
        var _loc6_ = Math.round(tRect.left / CMapwho.mCellSize.x);
        var _loc9_ = Math.round(tRect.top / CMapwho.mCellSize.y);
        var _loc5_ = Math.round(tRect.right / CMapwho.mCellSize.x);
        var _loc8_ = Math.round(tRect.bottom / CMapwho.mCellSize.y);
        var _loc4_ = _loc9_;
        while(_loc4_ < _loc8_)
        {
            var _loc2_ = _loc6_;
            var _loc3_ = this.mMap[_loc4_];
            while(_loc2_ < _loc5_)
            {
                _loc3_[_loc2_].mCollide |= tType;
                _loc2_ = _loc2_ + 1;
            }
            _loc4_ = _loc4_ + 1;
        }
    }
    function CircleCollide(pxyz, tRadius, tID)
    {
        var _loc10_ = Math.max(Math.floor((pxyz.mX - tRadius) / CMapwho.mCellSize.x),0);
        var _loc12_ = Math.max(Math.floor((pxyz.mY - tRadius) / CMapwho.mCellSize.y),0);
        var _loc9_ = Math.min(Math.ceil((pxyz.mX + tRadius) / CMapwho.mCellSize.x),this.mSize.x - 1);
        var _loc11_ = Math.min(Math.ceil((pxyz.mY + tRadius) / CMapwho.mCellSize.y),this.mSize.y - 1);
        var _loc6_ = new Array();
        var _loc7_ = _loc12_;
        while(_loc7_ <= _loc11_)
        {
            var _loc4_ = _loc10_;
            var _loc5_ = this.mMap[_loc7_];
            while(_loc4_ <= _loc9_)
            {
                var _loc2_ = _loc5_[_loc4_].mChild;
                while(_loc2_ != undefined)
                {
                    var _loc3_ = _loc2_.mObject;
                    if(tID != _loc3_.mID && _loc3_.mAffectable)
                    {
                        _loc6_[_loc6_.length] = _loc3_;
                    }
                    _loc2_ = _loc2_.mChild;
                }
                _loc4_ = _loc4_ + 1;
            }
            _loc7_ = _loc7_ + 1;
        }
        return _loc6_;
    }
    function LineCollide(sp, ep, tID)
    {
        if(CMapwho._ERROR)
        {
            return undefined;
        }
        var _loc6_ = ep.Subtract(sp);
        var _loc3_ = new scidd.Math.CLine(sp.toPoint(),ep.toPoint());
        _loc3_.mTag = new Object();
        _loc3_.mTag.xGradient = _loc3_.__get__mDelta().y / _loc3_.__get__mDelta().x;
        _loc3_.mTag.yGradient = _loc3_.__get__mDelta().x / _loc3_.__get__mDelta().y;
        _loc3_.mTag.xDirection = scidd.Math.CMath.Sign(_loc3_.__get__mDelta().x);
        _loc3_.mTag.yDirection = scidd.Math.CMath.Sign(_loc3_.__get__mDelta().y);
        _loc3_.mTag.mID = tID;
        var _loc2_ = undefined;
        if(Math.abs(_loc6_.mX) >= Math.abs(_loc6_.mY))
        {
            var _loc8_ = _loc3_.mTag.yDirection <= 0 ? -1 : 1;
            var _loc10_ = new scidd.Math.CPointXYZ(scidd.Math.CMath.Sign(_loc6_.mX) * CMapwho.mCellSize.x,scidd.Math.CMath.Sign(_loc6_.mY) * CMapwho.mCellSize.x * Math.abs(_loc6_.mY / _loc6_.mX));
            var _loc7_ = Math.ceil(Math.abs(_loc6_.mX / CMapwho.mCellSize.x));
            var _loc5_ = sp.Clone();
            while(_loc7_ >= 0)
            {
                var _loc4_ = this.GetCellPosition(_loc5_.mX,_loc5_.mY);
                if((_loc2_ = this._LineIntersectsCell(_loc3_,this.mMap[_loc4_.y - _loc8_][_loc4_.x])) != undefined)
                {
                    return _loc2_;
                }
                if((_loc2_ = this._LineIntersectsCell(_loc3_,this.mMap[_loc4_.y + 0][_loc4_.x])) != undefined)
                {
                    return _loc2_;
                }
                if((_loc2_ = this._LineIntersectsCell(_loc3_,this.mMap[_loc4_.y + _loc8_][_loc4_.x])) != undefined)
                {
                    return _loc2_;
                }
                _loc7_ = _loc7_ - 1;
                _loc5_ = _loc5_.Add(_loc10_);
            }
        }
        else
        {
            _loc8_ = _loc3_.mTag.xDirection <= 0 ? -1 : 1;
            _loc10_ = new scidd.Math.CPointXYZ(scidd.Math.CMath.Sign(_loc6_.mX) * CMapwho.mCellSize.x * Math.abs(_loc6_.mX / _loc6_.mY),scidd.Math.CMath.Sign(_loc6_.mY) * CMapwho.mCellSize.y);
            _loc7_ = Math.ceil(Math.abs(_loc6_.mY / CMapwho.mCellSize.y));
            _loc5_ = sp.Clone();
            while(_loc7_ >= 0)
            {
                _loc4_ = this.GetCellPosition(_loc5_.mX,_loc5_.mY);
                if((_loc2_ = this._LineIntersectsCell(_loc3_,this.mMap[_loc4_.y][_loc4_.x - _loc8_])) != undefined)
                {
                    return _loc2_;
                }
                if((_loc2_ = this._LineIntersectsCell(_loc3_,this.mMap[_loc4_.y][_loc4_.x + 0])) != undefined)
                {
                    return _loc2_;
                }
                if((_loc2_ = this._LineIntersectsCell(_loc3_,this.mMap[_loc4_.y][_loc4_.x + _loc8_])) != undefined)
                {
                    return _loc2_;
                }
                _loc7_ = _loc7_ - 1;
                _loc5_ = _loc5_.Add(_loc10_);
            }
        }
        return undefined;
    }
    function _LineIntersectsCell(cLine, oCell)
    {
        oCell.mDraw = true;
        if((oCell.mCollide & CMapwho.mCollide_Solid) == CMapwho.mCollide_Solid)
        {
            var _loc9_ = undefined;
            var _loc10_ = undefined;
            if(cLine.mTag.xDirection > 0)
            {
                var _loc11_ = cLine.mP1.y + (oCell.mPoint.x - cLine.mP1.x) * cLine.mTag.xGradient;
                if(_loc11_ >= oCell.mPoint.y && _loc11_ <= oCell.mPoint.y + CMapwho.mCellSize.y)
                {
                    _loc9_ = new flash.geom.Point(oCell.mPoint.x,_loc11_);
                }
            }
            else if(cLine.mTag.xDirection < 0)
            {
                _loc11_ = cLine.mP1.y + (oCell.mPoint.x + CMapwho.mCellSize.x - cLine.mP1.x) * cLine.mTag.xGradient;
                if(_loc11_ >= oCell.mPoint.y && _loc11_ <= oCell.mPoint.y + CMapwho.mCellSize.y)
                {
                    _loc9_ = new flash.geom.Point(oCell.mPoint.x + CMapwho.mCellSize.x,_loc11_);
                }
            }
            if(cLine.mTag.yDirection > 0)
            {
                var _loc12_ = cLine.mP1.x + (oCell.mPoint.y - cLine.mP1.y) * cLine.mTag.yGradient;
                if(_loc12_ >= oCell.mPoint.x && _loc12_ <= oCell.mPoint.x + CMapwho.mCellSize.x)
                {
                    _loc10_ = new flash.geom.Point(_loc12_,oCell.mPoint.y);
                }
            }
            else if(cLine.mTag.yDirection < 0)
            {
                _loc12_ = cLine.mP1.x + (oCell.mPoint.y + CMapwho.mCellSize.y - cLine.mP1.y) * cLine.mTag.yGradient;
                if(_loc12_ >= oCell.mPoint.x && _loc12_ <= oCell.mPoint.x + CMapwho.mCellSize.x)
                {
                    _loc10_ = new flash.geom.Point(_loc12_,oCell.mPoint.y + CMapwho.mCellSize.y);
                }
            }
            if(_loc9_ != undefined || _loc10_ != undefined)
            {
                if(_loc9_ != undefined && _loc10_ != undefined)
                {
                    return {mCollideType:"wall",mWallPoint:(scidd.Math.CMath.Distance_Sqr(_loc9_,cLine.mP1) >= scidd.Math.CMath.Distance_Sqr(_loc10_,cLine.mP1) ? _loc10_ : _loc9_)};
                }
                return {mCollideType:"wall",mWallPoint:(_loc9_ != undefined ? _loc9_ : _loc10_)};
            }
        }
        var _loc2_ = oCell.mChild;
        100;
        while(_loc2_ != undefined && true)
        {
            var _loc1_ = _loc2_.mObject;
            if(cLine.mTag.mID != _loc1_.mID && _loc1_.mAffectable == true)
            {
                var _loc6_ = cLine.Distance_PointToLine_SQR(_loc1_.mPosition.toPoint(),true);
                if(_loc6_ < _loc1_.mRadius * _loc1_.mRadius)
                {
                    return {mCollideType:"thing",mThing:_loc1_};
                }
            }
            _loc2_ = _loc2_.mChild;
            99;
            100;
        }
        if(false)
        {
            CMapwho._ERROR = true;
        }
        return undefined;
    }
    function LineCollide_CONT(sp, ep, tID)
    {
        if(CMapwho._ERROR)
        {
            return undefined;
        }
        var _loc9_ = ep.Subtract(sp);
        var _loc3_ = new scidd.Math.CLine(sp.toPoint(),ep.toPoint());
        _loc3_.mTag = new Object();
        _loc3_.mTag.xGradient = _loc3_.__get__mDelta().y / _loc3_.__get__mDelta().x;
        _loc3_.mTag.yGradient = _loc3_.__get__mDelta().x / _loc3_.__get__mDelta().y;
        _loc3_.mTag.xDirection = scidd.Math.CMath.Sign(_loc3_.__get__mDelta().x);
        _loc3_.mTag.yDirection = scidd.Math.CMath.Sign(_loc3_.__get__mDelta().y);
        _loc3_.mTag.mID = tID;
        var _loc2_ = {mThingList:new Array(),mCollide:false};
        var _loc4_ = undefined;
        var _loc5_ = undefined;
        var _loc6_ = undefined;
        if(Math.abs(_loc9_.mX) >= Math.abs(_loc9_.mY))
        {
            var _loc11_ = _loc3_.mTag.yDirection <= 0 ? -1 : 1;
            var _loc13_ = new scidd.Math.CPointXYZ(scidd.Math.CMath.Sign(_loc9_.mX) * CMapwho.mCellSize.x,scidd.Math.CMath.Sign(_loc9_.mY) * CMapwho.mCellSize.x * Math.abs(_loc9_.mY / _loc9_.mX));
            var _loc10_ = Math.ceil(Math.abs(_loc9_.mX / CMapwho.mCellSize.x));
            var _loc8_ = sp.Clone();
            while(_loc10_ >= 0)
            {
                var _loc7_ = this.GetCellPosition(_loc8_.mX,_loc8_.mY);
                _loc4_ = this._LineIntersectsCell_CONT(_loc3_,this.mMap[_loc7_.y - _loc11_][_loc7_.x]);
                _loc5_ = this._LineIntersectsCell_CONT(_loc3_,this.mMap[_loc7_.y + 0][_loc7_.x]);
                _loc6_ = this._LineIntersectsCell_CONT(_loc3_,this.mMap[_loc7_.y + _loc11_][_loc7_.x]);
                _loc2_.mThingList = _loc2_.mThingList.concat(_loc4_.mThingList.concat(_loc5_.mThingList.concat(_loc6_.mThingList)));
                if(_loc4_.mCollide)
                {
                    _loc2_.mWallPoint = _loc4_.mWallPoint;
                    return _loc2_;
                }
                if(_loc5_.mCollide)
                {
                    _loc2_.mWallPoint = _loc5_.mWallPoint;
                    return _loc2_;
                }
                if(_loc6_.mCollide)
                {
                    _loc2_.mWallPoint = _loc6_.mWallPoint;
                    return _loc2_;
                }
                _loc10_ = _loc10_ - 1;
                _loc8_ = _loc8_.Add(_loc13_);
            }
        }
        else
        {
            _loc11_ = _loc3_.mTag.xDirection <= 0 ? -1 : 1;
            _loc13_ = new scidd.Math.CPointXYZ(scidd.Math.CMath.Sign(_loc9_.mX) * CMapwho.mCellSize.x * Math.abs(_loc9_.mX / _loc9_.mY),scidd.Math.CMath.Sign(_loc9_.mY) * CMapwho.mCellSize.y);
            _loc10_ = Math.ceil(Math.abs(_loc9_.mY / CMapwho.mCellSize.y));
            _loc8_ = sp.Clone();
            while(_loc10_ >= 0)
            {
                _loc7_ = this.GetCellPosition(_loc8_.mX,_loc8_.mY);
                _loc4_ = this._LineIntersectsCell_CONT(_loc3_,this.mMap[_loc7_.y][_loc7_.x - _loc11_]);
                _loc5_ = this._LineIntersectsCell_CONT(_loc3_,this.mMap[_loc7_.y][_loc7_.x + 0]);
                _loc6_ = this._LineIntersectsCell_CONT(_loc3_,this.mMap[_loc7_.y][_loc7_.x + _loc11_]);
                _loc2_.mThingList = _loc2_.mThingList.concat(_loc4_.mThingList.concat(_loc5_.mThingList.concat(_loc6_.mThingList)));
                if(_loc4_.mCollide)
                {
                    _loc2_.mWallPoint = _loc4_.mWallPoint;
                    return _loc2_;
                }
                if(_loc5_.mCollide)
                {
                    _loc2_.mWallPoint = _loc5_.mWallPoint;
                    return _loc2_;
                }
                if(_loc6_.mCollide)
                {
                    _loc2_.mWallPoint = _loc6_.mWallPoint;
                    return _loc2_;
                }
                _loc10_ = _loc10_ - 1;
                _loc8_ = _loc8_.Add(_loc13_);
            }
        }
        return _loc2_;
    }
    function _LineIntersectsCell_CONT(cLine, oCell)
    {
        var _loc6_ = {mThingList:new Array(),mCollide:false};
        var _loc2_ = oCell.mChild;
        100;
        while(_loc2_ != undefined && true)
        {
            var _loc1_ = _loc2_.mObject;
            if(cLine.mTag.mID != _loc1_.mID && _loc1_.mAffectable == true)
            {
                var _loc7_ = cLine.Distance_PointToLine_SQR(_loc1_.mPosition.toPoint());
                if(_loc7_ < _loc1_.mRadius * _loc1_.mRadius)
                {
                    _loc6_.mThingList[_loc6_.mThingList.length] = _loc1_;
                }
            }
            _loc2_ = _loc2_.mChild;
            99;
            100;
        }
        oCell.mDraw = true;
        if((oCell.mCollide & CMapwho.mCollide_Solid) == CMapwho.mCollide_Solid)
        {
            var _loc8_ = undefined;
            var _loc9_ = undefined;
            if(cLine.mTag.xDirection > 0)
            {
                var _loc10_ = cLine.mP1.y + (oCell.mPoint.x - cLine.mP1.x) * cLine.mTag.xGradient;
                if(_loc10_ >= oCell.mPoint.y && _loc10_ <= oCell.mPoint.y + CMapwho.mCellSize.y)
                {
                    _loc8_ = new flash.geom.Point(oCell.mPoint.x,_loc10_);
                }
            }
            else if(cLine.mTag.xDirection < 0)
            {
                _loc10_ = cLine.mP1.y + (oCell.mPoint.x + CMapwho.mCellSize.x - cLine.mP1.x) * cLine.mTag.xGradient;
                if(_loc10_ >= oCell.mPoint.y && _loc10_ <= oCell.mPoint.y + CMapwho.mCellSize.y)
                {
                    _loc8_ = new flash.geom.Point(oCell.mPoint.x + CMapwho.mCellSize.x,_loc10_);
                }
            }
            if(cLine.mTag.yDirection > 0)
            {
                var _loc11_ = cLine.mP1.x + (oCell.mPoint.y - cLine.mP1.y) * cLine.mTag.yGradient;
                if(_loc11_ >= oCell.mPoint.x && _loc11_ <= oCell.mPoint.x + CMapwho.mCellSize.x)
                {
                    _loc9_ = new flash.geom.Point(_loc11_,oCell.mPoint.y);
                }
            }
            else if(cLine.mTag.yDirection < 0)
            {
                _loc11_ = cLine.mP1.x + (oCell.mPoint.y + CMapwho.mCellSize.y - cLine.mP1.y) * cLine.mTag.yGradient;
                if(_loc11_ >= oCell.mPoint.x && _loc11_ <= oCell.mPoint.x + CMapwho.mCellSize.x)
                {
                    _loc9_ = new flash.geom.Point(_loc11_,oCell.mPoint.y + CMapwho.mCellSize.y);
                }
            }
            if(_loc8_ != undefined || _loc9_ != undefined)
            {
                if(_loc8_ != undefined && _loc9_ != undefined)
                {
                    _loc6_.mWallPoint = scidd.Math.CMath.Distance_Sqr(_loc8_,cLine.mP1) >= scidd.Math.CMath.Distance_Sqr(_loc9_,cLine.mP1) ? _loc9_ : _loc8_;
                }
                else
                {
                    _loc6_.mWallPoint = _loc8_ != undefined ? _loc8_ : _loc9_;
                }
                _loc6_.mCollide = true;
            }
        }
        if(false)
        {
            CMapwho._ERROR = true;
        }
        return _loc6_;
    }
    function QCollide(p, collideFlags)
    {
        var _loc2_ = this.GetCellPosition(p.mX,p.mY);
        return this._QCollide(_loc2_.x,_loc2_.y) & collideFlags;
    }
    function Collide(p, d, collideFlags)
    {
        var _loc3_ = this.GetCellPosition(p.mX + d.mX,p.mY + d.mX);
        var _loc5_ = this.GetCellPosition(p.mX,p.mY);
        var _loc2_ = new Object();
        _loc2_.xCollide = this._QCollide(_loc3_.x,_loc5_.y) & collideFlags;
        _loc2_.yCollide = this._QCollide(_loc5_.x,_loc3_.y) & collideFlags;
        _loc2_.xyCollide = this._QCollide(_loc3_.x,_loc3_.y) & collideFlags && (_loc2_.xCollide == false && _loc2_.yCollide == false);
        _loc2_.zCollide = p.mZ + d.mZ < 0;
        return _loc2_;
    }
    function AffectArea(tArea, tAffect)
    {
        var _loc9_ = Math.floor(tArea.left / CMapwho.mCellSize.x);
        var _loc11_ = Math.floor(tArea.top / CMapwho.mCellSize.y);
        var _loc8_ = Math.ceil(tArea.right / CMapwho.mCellSize.x);
        var _loc10_ = Math.ceil(tArea.bottom / CMapwho.mCellSize.y);
        var _loc7_ = _loc11_;
        while(_loc7_ < _loc10_)
        {
            var _loc4_ = _loc9_;
            var _loc5_ = this.mMap[_loc7_];
            while(_loc4_ < _loc8_)
            {
                var _loc2_ = _loc5_[_loc4_].mChild;
                while(_loc2_ != undefined)
                {
                    var _loc3_ = _loc2_.mObject;
                    if(tAffect.mOwner.mID != _loc3_.mID && _loc3_.mAffectable == true)
                    {
                        _loc3_.AddAffect(tAffect);
                    }
                    _loc2_ = _loc2_.mChild;
                }
                _loc4_ = _loc4_ + 1;
            }
            _loc7_ = _loc7_ + 1;
        }
    }
    function AffectCell(cx, cy, tAffect)
    {
        var _loc2_ = this.GetCell(cx,cy).mChild;
        while(_loc2_ != undefined)
        {
            var _loc3_ = _loc2_.mObject;
            if(tAffect.mOwner.mID != _loc3_.mID && _loc3_.mAffectable == true)
            {
                _loc3_.AddAffect(tAffect);
            }
            _loc2_ = _loc2_.mChild;
        }
    }
    function GetCellObjectByField(tField, tValue, cx, cy)
    {
        var _loc2_ = this.GetCell(cx,cy).mChild;
        while(_loc2_ != undefined)
        {
            if(_loc2_.mObject[tField] == tValue)
            {
                return _loc2_.mObject;
            }
            _loc2_ = _loc2_.mChild;
        }
        return undefined;
    }
    function _QCollide(cx, cy)
    {
        var _loc2_ = this.mMap[cy][cx].mCollide;
        return _loc2_ != undefined ? _loc2_ : CMapwho.mCollide_Solid;
    }
    function GetCell(cx, cy)
    {
        return this.mMap[cy][cx];
    }
    function GetCellXYZ(pxyz)
    {
        return this.mMap[pxyz.mY >> CMapwho.mCellSizeShift][pxyz.mX >> CMapwho.mCellSizeShift];
    }
    function CellChildCount(pxyz)
    {
        return this.mMap[pxyz.mY >> CMapwho.mCellSizeShift][pxyz.mX >> CMapwho.mCellSizeShift].mChildCount;
    }
    function SetCollideFlags(cx, cy, tFlags)
    {
        return this.mMap[cy][cx].mCollide |= tFlags;
    }
    function ClearCollideFlags(cx, cy, tFlags)
    {
        return this.mMap[cy][cx].mCollide &= tFlags ^ -1;
    }
    function GetCellPosition(x, y)
    {
        return new flash.geom.Point(x >> CMapwho.mCellSizeShift,y >> CMapwho.mCellSizeShift);
    }
    function CellToWorldPosition(x, y)
    {
        return new scidd.Math.CPointXYZ(x << CMapwho.mCellSizeShift,y << CMapwho.mCellSizeShift,0);
    }
    function GetCentreCell(x, y)
    {
        return new flash.geom.Point(scidd.Math.CMath.Floor(x,CMapwho.mCellSize.x) + CMapwho.mCellSize.x / 2,scidd.Math.CMath.Floor(y,CMapwho.mCellSize.y) + CMapwho.mCellSize.y / 2);
    }
    function CentreOnCell(p)
    {
        return p.SetXYZ(scidd.Math.CMath.Floor(p.mX,CMapwho.mCellSize.x) + CMapwho.mCellSize.x / 2,scidd.Math.CMath.Floor(p.mY,CMapwho.mCellSize.y) + CMapwho.mCellSize.y / 2,p.mZ);
    }
    function Create(tObject)
    {
        return {mObject:tObject,mMapwho:this,mCell:{mID:new flash.geom.Point(-1,-1)}};
    }
    function Move(oMapwho, px, py)
    {
        var _loc2_ = oMapwho.mCell.mID;
        if(px >> CMapwho.mCellSizeShift == _loc2_.x && py >> CMapwho.mCellSizeShift == _loc2_.y)
        {
            return false;
        }
        this.Remove(oMapwho);
        this.Add(oMapwho,px >> CMapwho.mCellSizeShift,py >> CMapwho.mCellSizeShift);
        return true;
    }
    function Remove(oMapwho)
    {
        if(oMapwho.mCell == undefined)
        {
            return false;
        }
        if(oMapwho.mParent == undefined)
        {
            oMapwho.mCell.mChild = oMapwho.mChild;
            delete oMapwho.mChild.mParent;
        }
        else
        {
            oMapwho.mParent.mChild = oMapwho.mChild;
            oMapwho.mChild.mParent = oMapwho.mParent;
        }
        oMapwho.mCell.mChildCount--;
        delete oMapwho.mCell;
        return true;
    }
    function Add(oMapwho, cx, cy)
    {
        var _loc3_ = this.mMap[cy][cx];
        delete oMapwho.mParent;
        oMapwho.mChild = _loc3_.mChild;
        oMapwho.mChild.mParent = oMapwho;
        _loc3_.mChild = oMapwho;
        oMapwho.mCell = _loc3_;
        _loc3_.mChildCount++;
    }
    function DrawObjects(tArea)
    {
        if(CMapwho._ERROR)
        {
            return undefined;
        }
        var _loc12_ = Math.floor(tArea.left / CMapwho.mCellSize.x);
        var _loc16_ = Math.floor(tArea.top / CMapwho.mCellSize.y);
        var _loc11_ = Math.ceil(tArea.right / CMapwho.mCellSize.x);
        var _loc15_ = Math.ceil(tArea.bottom / CMapwho.mCellSize.y);
        0;
        0;
        var _loc10_ = _loc16_;
        while(_loc10_ <= _loc15_)
        {
            var _loc8_ = _loc12_;
            var _loc9_ = this.mMap[_loc10_];
            while(_loc8_ < _loc11_)
            {
                1;
                var _loc7_ = _loc9_[_loc8_];
                if(_loc7_.mChildCount != 0)
                {
                    if(_loc7_.mChildCount > 1)
                    {
                        1;
                        var _loc2_ = new Array();
                        var _loc3_ = _loc7_.mChild;
                        while(_loc3_ != undefined)
                        {
                            var _loc4_ = _loc3_.mObject;
                            var _loc6_ = _loc2_.length - 1;
                            while(_loc6_ >= 0)
                            {
                                var _loc5_ = _loc2_[_loc6_];
                                if(_loc4_.mPosition.mY >= _loc5_.mPosition.mY && _loc4_.mAlwaysBehind != true)
                                {
                                    break;
                                }
                                _loc2_[_loc6_ + 1] = _loc5_;
                                _loc6_ = _loc6_ - 1;
                            }
                            _loc2_[_loc6_ + 1] = _loc4_;
                            _loc3_ = _loc3_.mChild;
                        }
                        _loc2_.reverse();
                        _loc6_ = _loc2_.length - 1;
                        while(_loc6_ >= 0)
                        {
                            _loc2_[_loc6_].Draw();
                            _loc6_ = _loc6_ - 1;
                        }
                    }
                    else
                    {
                        _loc3_ = _loc7_.mChild;
                        while(_loc3_ != undefined)
                        {
                            _loc3_.mObject.Draw();
                            _loc3_ = _loc3_.mChild;
                        }
                    }
                }
                _loc8_ = _loc8_ + 1;
            }
            _loc10_ = _loc10_ + 1;
        }
    }
    function ResetFear()
    {
        this.mFearAreas = new Array();
    }
    function AddFearArea(tPosition, tCellRadius)
    {
        var _loc4_ = tCellRadius << CMapwho.mCellSizeShift;
        var _loc3_ = new flash.geom.Rectangle(tPosition.mX - _loc4_,tPosition.mY - _loc4_,_loc4_ * 2,_loc4_ * 2);
        for(var _loc5_ in this.mFearAreas)
        {
            if(_loc3_.intersects(this.mFearAreas[_loc5_].mRect))
            {
                var _loc2_ = this.mFearAreas[_loc5_].mRect.union(_loc3_);
                this.mFearAreas[_loc5_].mCentre = flash.geom.Point.interpolate(_loc2_.topLeft,_loc2_.bottomRight,0.5);
                this.mFearAreas[_loc5_].mRect = _loc2_;
                return undefined;
            }
        }
        this.mFearAreas[this.mFearAreas.length] = {mCentre:flash.geom.Point.interpolate(_loc3_.topLeft,_loc3_.bottomRight,0.5),mRect:_loc3_};
    }
    function InFearArea(p)
    {
        for(var _loc6_ in this.mFearAreas)
        {
            var _loc4_ = this.mFearAreas[_loc6_];
            var _loc2_ = _loc4_.mRect;
            if(p.mX >= _loc2_.left && p.mX <= _loc2_.right && p.mY >= _loc2_.top && p.mY <= _loc2_.bottom)
            {
                var _loc5_ = _loc4_.mCentre;
                return new flash.geom.Point(p.mX - _loc5_.x,p.mY - _loc5_.y);
            }
        }
        return undefined;
    }
}
