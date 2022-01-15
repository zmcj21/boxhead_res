class World.Map.CMap_Cell
{
    var Dispose = 0;
    var _CLASSID_ = "CMap_Cell";
    var _BASECLASSID_ = "CMap_Cell";
    static var mCellSize = 32;
    static var mSize = new flash.geom.Point(World.Map.CMap_Cell.mCellSize,World.Map.CMap_Cell.mCellSize);
    static var mCollide_None = 0;
    static var mCollide_Solid = 1;
    static var mCollide_Ledge = 2;
    static var mCollide_Shot = 4;
    static var mCollide_Path = 8;
    static var mCollide_Road = 16;
    static var mCollide_Creature = 32;
    static var mCollide_Player = 64;
    static var mCollide_Object = 128;
    static var mCollide_EdgeOfMap = 256;
    static var mCollide_StaticImpassable = World.Map.CMap_Cell.mCollide_Ledge | World.Map.CMap_Cell.mCollide_Solid;
    static var mCollide_NonShootable = World.Map.CMap_Cell.mCollide_Solid;
    static var mCollide_NonMovable = World.Map.CMap_Cell.mCollide_StaticImpassable | World.Map.CMap_Cell.mCollide_Creature | World.Map.CMap_Cell.mCollide_Object | World.Map.CMap_Cell.mCollide_Player;
    static var mCollide_Moving = World.Map.CMap_Cell.mCollide_Creature | World.Map.CMap_Cell.mCollide_Player;
    static var mCollide_NonMovablePlayer = World.Map.CMap_Cell.mCollide_StaticImpassable | World.Map.CMap_Cell.mCollide_Creature | World.Map.CMap_Cell.mCollide_Object | World.Map.CMap_Cell.mCollide_Player;
    static var mCollide_NoSpawn = World.Map.CMap_Cell.mCollide_Creature | World.Map.CMap_Cell.mCollide_Object;
    static var mCollide_Navigation = World.Map.CMap_Cell.mCollide_StaticImpassable | World.Map.CMap_Cell.mCollide_Object;
    static var mAdjacentCells_Amount = 8;
    static var mCurrentSessionID = 0;
    static var mDirection_E = 1;
    static var mDirection_SE = 2;
    static var mDirection_S = 4;
    static var mDirection_SW = 8;
    static var mDirection_W = 16;
    static var mDirection_NW = 32;
    static var mDirection_N = 64;
    static var mDirection_NE = 128;
    static var mDirections_Diagonal = World.Map.CMap_Cell.mDirection_SE | World.Map.CMap_Cell.mDirection_SW | World.Map.CMap_Cell.mDirection_NW | World.Map.CMap_Cell.mDirection_NE;
    static var mDirections_Straight = World.Map.CMap_Cell.mDirection_E | World.Map.CMap_Cell.mDirection_S | World.Map.CMap_Cell.mDirection_W | World.Map.CMap_Cell.mDirection_N;
    static var mDirections_All = World.Map.CMap_Cell.mDirections_Diagonal | World.Map.CMap_Cell.mDirections_Straight;
    static var mDirectionM_E = (World.Map.CMap_Cell.mDirection_E | World.Map.CMap_Cell.mDirection_NE | World.Map.CMap_Cell.mDirection_SE) ^ -1;
    static var mDirectionM_SE = World.Map.CMap_Cell.mDirection_SE ^ -1;
    static var mDirectionM_S = (World.Map.CMap_Cell.mDirection_S | World.Map.CMap_Cell.mDirection_SE | World.Map.CMap_Cell.mDirection_SW) ^ -1;
    static var mDirectionM_SW = World.Map.CMap_Cell.mDirection_SW ^ -1;
    static var mDirectionM_W = (World.Map.CMap_Cell.mDirection_W | World.Map.CMap_Cell.mDirection_SW | World.Map.CMap_Cell.mDirection_NW) ^ -1;
    static var mDirectionM_NW = World.Map.CMap_Cell.mDirection_NW ^ -1;
    static var mDirectionM_N = (World.Map.CMap_Cell.mDirection_N | World.Map.CMap_Cell.mDirection_NW | World.Map.CMap_Cell.mDirection_NE) ^ -1;
    static var mDirectionM_NE = World.Map.CMap_Cell.mDirection_NE ^ -1;
    static var xPOI = new flash.geom.Point();
    static var yPOI = new flash.geom.Point();
    static var nSDist = 0;
    static var nInterations = 5;
    static var nTimeOut = 3;
    function CMap_Cell(x, y)
    {
        this.mPosition = new flash.geom.Point(x,y);
        this.mP1 = this.mPosition;
        this.mP2 = new flash.geom.Point(x + 1,y + 1);
        this.mCentre = new Thing.Math.CThing_Position(x + 0.5,y + 0.5,0);
        this.mArea = new flash.geom.Rectangle(this.mPosition.x,this.mPosition.y,1,1);
        this.mID = this.mPosition;
        this.mChildCount = 0;
        this.mCollide = World.Map.CMap_Cell.mCollide_None;
        this.mObjects = new Array();
        this.nID = -1;
    }
    function SetAdjacents(tList)
    {
        this.mAdjacentCells = tList;
        this.ac = this.mAdjacentCells;
        this.mEast = this.mAdjacentCells[0];
        this.mSouth = this.mAdjacentCells[2];
        this.mWest = this.mAdjacentCells[4];
        this.mNorth = this.mAdjacentCells[6];
        this.mNext = this.mEast;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function ContainsClassID(cCLASSID)
    {
        for(var _loc2_ in this.mObjects)
        {
            if(this.mObjects[_loc2_]._CLASSID_ == cCLASSID)
            {
                return this.mObjects[_loc2_];
            }
        }
        return undefined;
    }
    function ContainsBaseClassID(cBASECLASSID)
    {
        for(var _loc2_ in this.mObjects)
        {
            if(this.mObjects[_loc2_]._BASECLASSID_ == cBASECLASSID)
            {
                return this.mObjects[_loc2_];
            }
        }
        return undefined;
    }
    function Draw()
    {
        if(this.mChildCount > 1)
        {
            this.mObjects.sort(this._SortOrder);
        }
        for(var _loc2_ in this.mObjects)
        {
            this.mObjects[_loc2_].Draw();
        }
    }
    function DebugDraw()
    {
        if(this.mCollide & World.Map.CMap_Cell.mCollide_Solid)
        {
            DrawPrimitive.CDrawPrimitive_Square.Draw(World.Map.CMap.mcDebug,new flash.geom.Point(this.mPosition.x * World.Map.CMap_Cell.mSize.x,this.mPosition.y * World.Map.CMap_Cell.mSize.y),World.Map.CMap_Cell.mSize.x,65280,50,false);
        }
    }
    function DebugMark(tColor, tSolid)
    {
        DrawPrimitive.CDrawPrimitive_Square.Draw(World.Map.CMap.mcDebug,new flash.geom.Point(this.mPosition.x * World.Map.CMap_Cell.mSize.x,this.mPosition.y * World.Map.CMap_Cell.mSize.y),World.Map.CMap_Cell.mSize.x,tColor,50,tSolid);
    }
    function _SortOrder(a, b)
    {
        var _loc2_ = a.mPosition.mY;
        var _loc1_ = b.mPosition.mY;
        return _loc2_ <= _loc1_ ? (_loc2_ >= _loc1_ ? 0 : 1) : -1;
    }
    function DeleteThing(tObject)
    {
        delete this.mObjects[tObject.sUniqueID];
        this.mChildCount--;
    }
    function AddThing(tObject)
    {
        this.mObjects[tObject.sUniqueID] = tObject;
        this.mChildCount++;
    }
    function Affect(tAffect)
    {
        for(var _loc4_ in this.mObjects)
        {
            var _loc2_ = this.mObjects[_loc4_];
            if(_loc2_.mAffectFlags & tAffect.mType && tAffect.mAffector.mID != _loc2_.mID)
            {
                this.mObjects[_loc4_].Affect(tAffect);
            }
        }
    }
    function CollideFlagsInDirection(d)
    {
        var _loc2_ = this.ac[d].mCollide;
        return !(d & 1) ? _loc2_ : _loc2_ | (this.ac[d - 1 & 7].mCollide | this.ac[d + 1 & 7].mCollide);
    }
    function GetClearMoveDirection(d2, d1)
    {
        var _loc2_ = undefined;
        var _loc5_ = d2 <= d1 ? (Math.abs(d2 - d1) <= 4 ? -1 : 1) : (Math.abs(d2 - d1) <= 4 ? 1 : -1);
        if(d2 & 1)
        {
            1;
            while(true)
            {
                _loc2_ = d2 + 1 * _loc5_ & 7;
                if(!(this.CollideFlagsInDirection(_loc2_) & World.Map.CMap_Cell.mCollide_NonMovable))
                {
                    return _loc2_;
                }
                _loc2_ = d2 - 1 * _loc5_ & 7;
                if(!(this.CollideFlagsInDirection(_loc2_) & World.Map.CMap_Cell.mCollide_NonMovable))
                {
                    return _loc2_;
                }
                3;
            }
        }
        else
        {
            _loc2_ = d2 + 2 * _loc5_ & 7;
            if(!(this.CollideFlagsInDirection(_loc2_) & World.Map.CMap_Cell.mCollide_NonMovable))
            {
                return _loc2_;
            }
            _loc2_ = d2 - 2 * _loc5_ & 7;
            if(!(this.CollideFlagsInDirection(_loc2_) & World.Map.CMap_Cell.mCollide_NonMovable))
            {
                return _loc2_;
            }
        }
        return -1;
    }
    function ValidMoveDirection()
    {
        0;
        while(true)
        {
            if(this.mAdjacentCells[0] != undefined && (this.mAdjacentCells[0].mCollide & World.Map.CMap_Cell.mCollide_StaticImpassable) == 0)
            {
                return this.mAdjacentCells[0];
            }
            2;
        }
        trace("NO VALID DIRECTION!");
        return undefined;
    }
    function LineIntersection(cLine)
    {
        var _loc10_ = this.LineIntersection_Map(cLine);
        if(_loc10_)
        {
            return _loc10_;
        }
        for(var _loc9_ in this.mObjects)
        {
            var _loc3_ = cLine.mTag;
            var _loc2_ = this.mObjects[_loc9_];
            if(_loc3_.mID != _loc2_.mID && _loc2_.mAffectFlags & _loc3_.cAffectFlags)
            {
                World.Map.CMap_Cell.xPOI.x = _loc2_.mPosition.mX;
                World.Map.CMap_Cell.xPOI.y = _loc2_.mPosition.mY;
                var _loc4_ = cLine.QDistance_PointToLine_SQR(World.Map.CMap_Cell.xPOI);
                if(_loc4_ < _loc2_.mRadius_SQR)
                {
                    return {mCollideType:"thing",mThing:_loc2_,mPOI:World.Map.CMap_Cell.xPOI};
                }
            }
        }
        return undefined;
    }
    function LineIntersection_ThingList(cLine)
    {
        var _loc4_ = cLine.mTag;
        var _loc5_ = new Array();
        for(var _loc7_ in this.mObjects)
        {
            var _loc2_ = this.mObjects[_loc7_];
            if(_loc4_.mID != _loc2_.mID && _loc2_.mAffectFlags & _loc4_.cAffectFlags)
            {
                World.Map.CMap_Cell.xPOI.x = _loc2_.mPosition.mX;
                World.Map.CMap_Cell.xPOI.y = _loc2_.mPosition.mY;
                var _loc3_ = cLine.QDistance_PointToLine_SQR(World.Map.CMap_Cell.xPOI);
                if(_loc3_ < _loc2_.mRadius_SQR)
                {
                    _loc5_.push(_loc2_);
                }
            }
        }
        return _loc5_.length <= 0 ? undefined : _loc5_;
    }
    function LineIntersection_Map(cLine)
    {
        var _loc3_ = cLine.mTag;
        if((this.mCollide & World.Map.CMap_Cell.mCollide_Solid) == World.Map.CMap_Cell.mCollide_Solid)
        {
            var _loc4_ = undefined;
            var _loc5_ = undefined;
            if(cLine.mTag.xDirection > 0)
            {
                var _loc6_ = cLine.mP1.y + (this.mP1.x - cLine.mP1.x) * _loc3_.xGradient;
                if(_loc6_ >= this.mP1.y && _loc6_ <= this.mP2.y)
                {
                    true;
                    World.Map.CMap_Cell.xPOI.x = this.mP1.x;
                    World.Map.CMap_Cell.xPOI.y = _loc6_;
                }
            }
            else if(_loc3_.xDirection < 0)
            {
                _loc6_ = cLine.mP1.y + (this.mP2.x - cLine.mP1.x) * _loc3_.xGradient;
                if(_loc6_ >= this.mP1.y && _loc6_ <= this.mP2.y)
                {
                    true;
                    World.Map.CMap_Cell.xPOI.x = this.mP2.x;
                    World.Map.CMap_Cell.xPOI.y = _loc6_;
                }
            }
            if(_loc3_.yDirection > 0)
            {
                var _loc7_ = cLine.mP1.x + (this.mP1.y - cLine.mP1.y) * _loc3_.yGradient;
                if(_loc7_ >= this.mP1.x && _loc7_ <= this.mP2.x)
                {
                    true;
                    World.Map.CMap_Cell.yPOI.x = _loc7_;
                    World.Map.CMap_Cell.yPOI.y = this.mP1.y;
                }
            }
            else if(_loc3_.yDirection < 0)
            {
                _loc7_ = cLine.mP1.x + (this.mP2.y - cLine.mP1.y) * _loc3_.yGradient;
                if(_loc7_ >= this.mP1.x && _loc7_ <= this.mP2.x)
                {
                    true;
                    World.Map.CMap_Cell.yPOI.x = _loc7_;
                    World.Map.CMap_Cell.yPOI.y = this.mP2.y;
                }
            }
            if(true != undefined && true != undefined)
            {
                return {mCollideType:"wall",mPOI:(scidd.Math.CMath.Distance_Sqr(World.Map.CMap_Cell.xPOI,cLine.mP1) >= scidd.Math.CMath.Distance_Sqr(World.Map.CMap_Cell.yPOI,cLine.mP1) ? World.Map.CMap_Cell.yPOI : World.Map.CMap_Cell.xPOI)};
            }
            if(true != undefined || true != undefined)
            {
                return {mCollideType:"wall",mPOI:(true != undefined ? World.Map.CMap_Cell.xPOI : World.Map.CMap_Cell.yPOI)};
            }
        }
        return undefined;
    }
    function Nav_Direction(cDir, tDir, tCollideFlags, tForceIt)
    {
        var _loc10_ = undefined;
        if(World.Map.CMap_Cell.nSTimer - this.nID < 2000)
        {
            "NavDir_CW_";
            if(this.ac[tDir].nDist < this.nDist)
            {
                if(!(this["NavReal_" + tDir]() & tCollideFlags))
                {
                    return tDir;
                }
            }
            if(this.ac[cDir].nDist < this.nDist)
            {
                if(!(this["NavReal_" + cDir]() & tCollideFlags))
                {
                    return cDir;
                }
            }
            if(tForceIt == false)
            {
                if(++World.Map.CMap_Cell.nFullScanCount > 5)
                {
                    return -1;
                }
            }
            if(this.Nav_VD(tCollideFlags) == 0)
            {
                if(tForceIt == true)
                {
                    trace("NO NAV DIRECTION");
                }
                return -1;
            }
            var _loc4_ = this.ac.sortOn("nDist",Array.RETURNINDEXEDARRAY | Array.NUMERIC | Array.DESCENDING);
            var _loc2_ = _loc4_.length - 1;
            while(_loc2_ >= 0)
            {
                var _loc3_ = _loc4_[_loc2_];
                if(this.nVD & 1 << _loc3_)
                {
                    return _loc3_;
                }
                _loc2_ = _loc2_ - 1;
            }
            if(tForceIt == true)
            {
                trace("NO VALID NAV DIRECTIONS");
            }
            return -1;
        }
        return this.NavReal_Dir(tDir,cDir,tCollideFlags);
    }
    function NavReal_Dir(d2, d1, tCollideFlags)
    {
        "NavReal_";
        var _loc6_ = undefined;
        var _loc3_ = undefined;
        if(!(this["NavReal_" + d2]() & tCollideFlags))
        {
            return d2;
        }
        if(d1 != d2)
        {
            if(!(this["NavReal_" + d1]() & tCollideFlags))
            {
                return d1;
            }
            _loc6_ = d2 <= d1 ? (Math.abs(d2 - d1) <= 4 ? -1 : 1) : (Math.abs(d2 - d1) <= 4 ? 1 : -1);
        }
        else
        {
            _loc6_ = random(2) * 2 - 1;
        }
        if(d2 & 1)
        {
            1;
            while(true)
            {
                if(!(this["NavReal_" + (_loc3_ = d2 + 1 * _loc6_ & 7)]() & tCollideFlags))
                {
                    return _loc3_;
                }
                if(!(this["NavReal_" + (_loc3_ = d2 - 1 * _loc6_ & 7)]() & tCollideFlags))
                {
                    return _loc3_;
                }
                3;
            }
        }
        else
        {
            if(!(this["NavReal_" + (_loc3_ = d2 + 2 * _loc6_ & 7)]() & tCollideFlags))
            {
                return _loc3_;
            }
            if(!(this["NavReal_" + (_loc3_ = d2 - 2 * _loc6_ & 7)]() & tCollideFlags))
            {
                return _loc3_;
            }
        }
        return -1;
    }
    function Nav_VD(tCollideFlags)
    {
        this.nVD = World.Map.CMap_Cell.mDirections_All;
        if(this.mEast.mCollide & tCollideFlags)
        {
            this.nVD &= World.Map.CMap_Cell.mDirectionM_E;
        }
        if(this.mSouth.mCollide & tCollideFlags)
        {
            this.nVD &= World.Map.CMap_Cell.mDirectionM_S;
        }
        if(this.mWest.mCollide & tCollideFlags)
        {
            this.nVD &= World.Map.CMap_Cell.mDirectionM_W;
        }
        if(this.mNorth.mCollide & tCollideFlags)
        {
            this.nVD &= World.Map.CMap_Cell.mDirectionM_N;
        }
        if(this.nVD == 0)
        {
            return this.nVD;
        }
        if(this.nVD & World.Map.CMap_Cell.mDirections_Diagonal)
        {
            if(this.nVD & World.Map.CMap_Cell.mDirection_SE)
            {
                if(this.ac[1].mCollide & tCollideFlags)
                {
                    this.nVD &= World.Map.CMap_Cell.mDirectionM_SE;
                }
            }
            if(this.nVD & World.Map.CMap_Cell.mDirection_SW)
            {
                if(this.ac[3].mCollide & tCollideFlags)
                {
                    this.nVD &= World.Map.CMap_Cell.mDirectionM_SW;
                }
            }
            if(this.nVD & World.Map.CMap_Cell.mDirection_NW)
            {
                if(this.ac[5].mCollide & tCollideFlags)
                {
                    this.nVD &= World.Map.CMap_Cell.mDirectionM_NW;
                }
            }
            if(this.nVD & World.Map.CMap_Cell.mDirection_NE)
            {
                if(this.ac[7].mCollide & tCollideFlags)
                {
                    this.nVD &= World.Map.CMap_Cell.mDirectionM_NE;
                }
            }
        }
        return this.nVD;
    }
    function NavDir_CW_0()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_E) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_S) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_N) ? -1 : 6) : 2) : 0;
    }
    function NavDir_CW_2()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_S) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_W) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_E) ? -1 : 0) : 4) : 2;
    }
    function NavDir_CW_4()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_W) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_N) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_S) ? -1 : 2) : 6) : 4;
    }
    function NavDir_CW_6()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_N) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_E) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_W) ? -1 : 4) : 0) : 6;
    }
    function NavDir_CW_1()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_SE) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_S) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_E) ? -1 : 0) : 2) : 1;
    }
    function NavDir_CW_3()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_SW) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_W) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_S) ? -1 : 2) : 4) : 3;
    }
    function NavDir_CW_5()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_NW) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_N) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_W) ? -1 : 4) : 6) : 5;
    }
    function NavDir_CW_7()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_NE) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_E) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_N) ? -1 : 6) : 0) : 7;
    }
    function NavDir_CCW_0()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_E) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_N) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_S) ? -1 : 2) : 6) : 0;
    }
    function NavDir_CCW_2()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_S) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_E) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_W) ? -1 : 4) : 0) : 2;
    }
    function NavDir_CCW_4()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_W) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_S) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_N) ? -1 : 6) : 2) : 4;
    }
    function NavDir_CCW_6()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_N) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_W) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_E) ? -1 : 0) : 4) : 6;
    }
    function NavDir_CCW_1()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_SE) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_E) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_S) ? -1 : 2) : 0) : 1;
    }
    function NavDir_CCW_3()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_SW) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_S) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_W) ? -1 : 4) : 2) : 3;
    }
    function NavDir_CCW_5()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_NW) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_W) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_N) ? -1 : 6) : 4) : 5;
    }
    function NavDir_CCW_7()
    {
        return !(this.nVD & World.Map.CMap_Cell.mDirection_NE) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_N) ? (!(this.nVD & World.Map.CMap_Cell.mDirection_E) ? -1 : 0) : 6) : 7;
    }
    function NavReal_0()
    {
        return this.ac[0].mCollide;
    }
    function NavReal_1()
    {
        return this.ac[1].mCollide | this.ac[0].mCollide | this.ac[2].mCollide;
    }
    function NavReal_2()
    {
        return this.ac[2].mCollide;
    }
    function NavReal_3()
    {
        return this.ac[3].mCollide | this.ac[2].mCollide | this.ac[4].mCollide;
    }
    function NavReal_4()
    {
        return this.ac[4].mCollide;
    }
    function NavReal_5()
    {
        return this.ac[5].mCollide | this.ac[4].mCollide | this.ac[6].mCollide;
    }
    function NavReal_6()
    {
        return this.ac[6].mCollide;
    }
    function NavReal_7()
    {
        return this.ac[7].mCollide | this.ac[6].mCollide | this.ac[0].mCollide;
    }
    static function Nav_Reset()
    {
        World.Map.CMap_Cell.nState = "restart";
        World.Map.CMap_Cell.nSID = 0;
        delete World.Map.CMap_Cell.pList;
    }
    static function Nav_Restart()
    {
        World.Map.CMap_Cell.nState = World.Map.CMap_Cell.nState != "finished" ? World.Map.CMap_Cell.nState : "restart";
        if(World.Map.CMap_Cell.nState == "restart")
        {
            World.Map.CMap_Cell.nSID++;
        }
    }
    static function Nav_Update(sCell)
    {
        World.Map.CMap_Cell.nSTimer = 2497;
        World.Map.CMap_Cell.nFullScanCount = 0;
        if(World.Map.CMap_Cell.nState == "restart" || World.Map.CMap_Cell.nState == undefined)
        {
            World.Map.CMap_Cell.nList = new Array();
            World.Map.CMap_Cell.nSID = World.Map.CMap_Cell.nSTimer;
            World.Map.CMap_Cell.nSDist = 0;
            sCell.NF_4();
            0;
            while(World.Map.CMap_Cell.nList.length)
            {
                World.Map.CMap_Cell.pList = World.Map.CMap_Cell.nList;
                World.Map.CMap_Cell.nList = new Array();
                for(var _loc2_ in World.Map.CMap_Cell.pList)
                {
                    var _loc1_ = World.Map.CMap_Cell.pList[_loc2_].ac;
                    _loc1_[0].NF_4();
                    _loc1_[2].NF_4();
                    _loc1_[4].NF_4();
                    _loc1_[6].NF_4();
                }
                World.Map.CMap_Cell.nSDist++;
                1;
            }
            World.Map.CMap_Cell.nState = !World.Map.CMap_Cell.nList.length ? "finished" : "resume";
        }
        else if(World.Map.CMap_Cell.nState == "resume")
        {
            0;
            while(World.Map.CMap_Cell.nList.length)
            {
                World.Map.CMap_Cell.pList = World.Map.CMap_Cell.nList;
                World.Map.CMap_Cell.nList = new Array();
                while(World.Map.CMap_Cell.pList.length)
                {
                    _loc2_ = World.Map.CMap_Cell.nInterations && World.Map.CMap_Cell.pList.length;
                    while(_loc2_)
                    {
                        _loc1_ = World.Map.CMap_Cell.pList.pop().ac;
                        _loc1_[0].NF_4();
                        _loc1_[2].NF_4();
                        _loc1_[4].NF_4();
                        _loc1_[6].NF_4();
                        _loc2_ = _loc2_ - 1;
                    }
                    if(4819 - World.Map.CMap_Cell.nSTimer > World.Map.CMap_Cell.nTimeOut)
                    {
                        World.Map.CMap_Cell.nState = "continue";
                        return undefined;
                    }
                }
                World.Map.CMap_Cell.nSDist++;
                1;
            }
            World.Map.CMap_Cell.nState = !World.Map.CMap_Cell.nList.length ? "finished" : "resume";
        }
        else if(World.Map.CMap_Cell.nState == "continue")
        {
            while(World.Map.CMap_Cell.pList.length)
            {
                _loc2_ = World.Map.CMap_Cell.nInterations;
                while(_loc2_ && World.Map.CMap_Cell.pList.length)
                {
                    _loc1_ = World.Map.CMap_Cell.pList.pop().ac;
                    _loc1_[0].NF_4();
                    _loc1_[2].NF_4();
                    _loc1_[4].NF_4();
                    _loc1_[6].NF_4();
                    _loc2_ = _loc2_ - 1;
                }
                if(1480 - World.Map.CMap_Cell.nSTimer > World.Map.CMap_Cell.nTimeOut)
                {
                    World.Map.CMap_Cell.nState = "continue";
                    return undefined;
                }
            }
            World.Map.CMap_Cell.nSDist++;
            World.Map.CMap_Cell.nState = !World.Map.CMap_Cell.nList.length ? "finished" : "resume";
        }
    }
    function NF_4()
    {
        if(!(this.mCollide & World.Map.CMap_Cell.mCollide_Navigation || this.nID == World.Map.CMap_Cell.nSID))
        {
            this.nID = World.Map.CMap_Cell.nSID;
            this.nDist = World.Map.CMap_Cell.nSDist;
            World.Map.CMap_Cell.nList.push(this);
        }
        return undefined;
    }
}
