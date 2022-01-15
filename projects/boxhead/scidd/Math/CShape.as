class scidd.Math.CShape
{
    var Cache = 0;
    var _CLASSID_ = "scidd.Math.CShape";
    function CShape(pList, tCentre)
    {
        this.mPointList = [tCentre].concat(pList);
        this.mLineList = new Array();
        1;
        while(1 < this.mPointList.length - 1)
        {
            this.mLineList[this.mLineList.length] = new scidd.Math.CLine(this.mPointList[1],this.mPointList[2]);
            2;
        }
        this.mLineList[this.mLineList.length] = new scidd.Math.CLine(this.mPointList[this.mPointList.length - 1],this.mPointList[1]);
    }
    function Draw(mc, tColor)
    {
        for(var _loc4_ in this.mLineList)
        {
            this.mLineList[_loc4_].Draw(mc,tColor);
        }
    }
    function DrawNormals(mc, tColor)
    {
        for(var _loc4_ in this.mLineList)
        {
            this.mLineList[_loc4_].DrawNormal(mc,tColor);
        }
    }
    function Clone()
    {
        var _loc3_ = new Array();
        1;
        while(1 < this.mPointList.length)
        {
            _loc3_[1 - 1] = this.mPointList[1].clone();
            2;
        }
        return new scidd.Math.CShape(_loc3_,this.mPointList[0].clone());
    }
    function toString()
    {
        return "CShape " + this.mLineList;
    }
    function PointInShape(p)
    {
        var _loc3_ = this.mLineList[0].SideOfLine(this.mPointList[0]);
        for(var _loc5_ in this.mLineList.length)
        {
            var _loc2_ = scidd.Math.CMath.Sign(this.mLineList[_loc5_].SideOfLine(p));
            if(!(_loc2_ == 0 || _loc3_ == _loc2_))
            {
                return false;
            }
        }
        return true;
    }
    function PointListInShape(pList)
    {
        0;
        var _loc3_ = new Array();
        for(var _loc4_ in pList.length)
        {
            if(this.PointInShape(pList[_loc4_]))
            {
                _loc3_[_loc3_.length] = pList[_loc4_];
            }
        }
        return !_loc3_.length ? undefined : _loc3_;
    }
    function Intersects(tLine)
    {
        var _loc2_ = {mPOI:new flash.geom.Point(0,0)};
        for(var _loc4_ in this.mLineList)
        {
            _loc2_.mLine = this.mLineList[_loc4_];
            if(tLine.Intersects(_loc2_.mLine,_loc2_.mPOI))
            {
                _loc2_.mIndex = _loc4_;
                return _loc2_;
            }
        }
        return undefined;
    }
    function Intersects_LL(tLineList)
    {
        var _loc2_ = {mPOI:new flash.geom.Point(0,0),mIndex:0,cIndex:0};
        for(var _loc5_ in tLineList)
        {
            _loc2_.cLine = tLineList[_loc5_];
            for(var _loc3_ in this.mLineList)
            {
                _loc2_.mLine = this.mLineList[_loc3_];
                if(_loc2_.cLine.Intersects(_loc2_.mLine,_loc2_.mPOI))
                {
                    _loc2_.mIndex = _loc3_;
                    _loc2_.cIndex = _loc5_;
                    return _loc2_;
                }
            }
        }
        return false;
    }
    function ApplyMatrix(m)
    {
        var _loc3_ = new Array();
        1;
        while(1 < this.mPointList.length)
        {
            _loc3_[1 - 1] = m.transformPoint(this.mPointList[1]);
            2;
        }
        return new scidd.Math.CShape(_loc3_,m.transformPoint(this.mPointList[0]));
    }
    function ApplyMatrix_PointList(pList, m)
    {
        var _loc2_ = new Array(pList.length);
        for(var _loc4_ in pList)
        {
            _loc2_[_loc4_] = m.transformPoint(pList[_loc4_]);
        }
        return _loc2_;
    }
    function ShapeIntersect(csLineList, cLine)
    {
        if(this.PointInShape(cLine.mP1,csLineList))
        {
            var _loc3_ = new flash.geom.Point(0,0);
            for(var _loc8_ in csLineList)
            {
                if(cLine.Intersects(csLineList[_loc8_],_loc3_))
                {
                    return {mPOI:_loc3_,mLineIndex:_loc8_,mLine:csLineList[_loc8_]};
                }
            }
        }
        return undefined;
    }
}
