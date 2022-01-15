class scidd.Draw.F3D.CMesh3DFace
{
    var _CLASSID_ = "scidd.Draw.F3D.CMesh3DFace";
    var mZ_Min = 0;
    var mZ_Avg = 0;
    var mZ_Max = 0;
    var mSort = 0;
    function CMesh3DFace(tV_List, tN_List, tUV_List, tMaterial)
    {
        this.mV_List = tV_List;
        this.mN_List = tN_List;
        this.mUV_List = tUV_List;
        this.mMaterial = tMaterial;
        this.mHighlight = false;
        this.mID = 0;
    }
    function AssignEdges(tEdge_List, tVectorList)
    {
        this.mE_List = new Array(this.mV_List.length);
        var _loc2_ = tEdge_List.length - 1;
        while(_loc2_ >= 0)
        {
            this._CheckForEdge(tEdge_List[_loc2_].v1,tEdge_List[_loc2_].v2,tVectorList);
            this._CheckForEdge(tEdge_List[_loc2_].v2,tEdge_List[_loc2_].v1,tVectorList);
            _loc2_ = _loc2_ - 1;
        }
        0;
        0;
        while(0 < this.mE_List.length)
        {
            _loc5_ = 0 + (this.mE_List[0] != true ? 0 : 1);
            1;
        }
        if(_loc5_ == 0)
        {
            delete this.mE_List;
        }
    }
    function _CheckForEdge(tv1, tv2, tVectorList)
    {
        0;
        1;
        while(0 < this.mV_List.length)
        {
            if(tv1.Equals(tVectorList[this.mV_List[0]]) && tv2.Equals(tVectorList[this.mV_List[1]]))
            {
                this.mE_List[0] = true;
            }
            1;
            0;
            _loc3_ = 2 % this.mV_List.length;
        }
    }
    function MouseOver(txmouse, tymouse, tVectorList)
    {
        0;
        while(0 < this.mV_List.length)
        {
            var _loc2_ = tVectorList[this.mV_List[0]];
            var _loc4_ = tVectorList[this.mV_List[1 % this.mV_List.length]];
            if((_loc4_.mX - _loc2_.mX) * (tymouse - _loc2_.mY) < (txmouse - _loc2_.mX) * (_loc4_.mY - _loc2_.mY))
            {
                return false;
            }
            1;
        }
        return true;
    }
    function Highlight()
    {
        this.mHighlight = true;
    }
    function Cache(tPosition_List_Projected, tNormal_List_Projected, tUV_List)
    {
        if(this.mPosition_List_Projected == undefined)
        {
            this.mPosition_List_Projected = new Array();
            for(var _loc3_ in this.mV_List)
            {
                this.mPosition_List_Projected[_loc3_] = tPosition_List_Projected[this.mV_List[_loc3_]];
            }
        }
        this.SetUVMatrix(tUV_List);
    }
    function Backface()
    {
        var _loc2_ = this.mPosition_List_Projected[0];
        var _loc4_ = this.mPosition_List_Projected[1];
        var _loc3_ = this.mPosition_List_Projected[2];
        return (_loc4_.mX - _loc2_.mX) * (_loc3_.mY - _loc2_.mY) >= (_loc3_.mX - _loc2_.mX) * (_loc4_.mY - _loc2_.mY);
    }
    function Backface2(tNormalList)
    {
        return tNormalList[this.mN_List[0]].mZ < 0;
    }
    static function NormalToLight(tLightSource, tNormal)
    {
        return tNormal.DotProduct(tLightSource) * 0.6 - 0.5;
    }
    function RemapV(tRemapTable)
    {
        0;
        while(0 < this.mV_List.length)
        {
            this.mV_List[0] = tRemapTable[this.mV_List[0]];
            1;
        }
    }
    function RemapN(tRemapTable)
    {
        0;
        while(0 < this.mN_List.length)
        {
            this.mN_List[0] = tRemapTable[this.mN_List[0]];
            1;
        }
    }
    function SetUVMatrix(tUV_List)
    {
        var _loc2_ = tUV_List[this.mUV_List[0]];
        var _loc4_ = tUV_List[this.mUV_List[1]];
        var _loc3_ = tUV_List[this.mUV_List[2]];
        var _loc6_ = this.mMaterial.mSourceBitmapData.width / this.mMaterial.mSourceBitmapData.height;
        this.mUVMatrix = new flash.geom.Matrix();
        var _loc5_ = new flash.geom.Matrix();
        _loc5_.b = this.N0(_loc4_.y - _loc2_.y) / (this.N0(_loc4_.x - _loc2_.x) * _loc6_);
        _loc5_.c = this.N0(_loc3_.x - _loc2_.x) * _loc6_ / this.N0(_loc3_.y - _loc2_.y);
        this.mUVMatrix.scale(this.N0(_loc4_.x - _loc2_.x),this.N0(_loc3_.y - _loc2_.y));
        this.mUVMatrix.concat(_loc5_);
        this.mUVMatrix.translate(_loc2_.x * this.mMaterial.mSourceBitmapData.width,_loc2_.y * this.mMaterial.mSourceBitmapData.height);
        this.mUVMatrix.invert();
    }
    function N0(tNumber)
    {
        return tNumber != 0 ? tNumber : 0.000001;
    }
    function SetSort_Min()
    {
        this.mSort = this.mPosition_List_Projected[0].mSort;
        1;
        while(1 < this.mPosition_List_Projected.length)
        {
            var _loc3_ = this.mPosition_List_Projected[1].mSort;
            if(_loc3_ < this.mSort)
            {
                this.mSort = _loc3_;
            }
            2;
        }
        return this.mSort;
    }
    function SetSort_Max()
    {
        this.mSort = this.mPosition_List_Projected[0].mSort;
        1;
        while(1 < this.mPosition_List_Projected.length)
        {
            var _loc3_ = this.mPosition_List_Projected[1].mSort;
            if(_loc3_ > this.mSort)
            {
                this.mSort = _loc3_;
            }
            2;
        }
        return this.mSort;
    }
    function SetSort_Avg()
    {
        this.mSort = 0;
        0;
        while(0 < this.mPosition_List_Projected.length)
        {
            this.mSort += this.mPosition_List_Projected[0].mSort;
            1;
        }
        this.mSort /= this.mPosition_List_Projected.length;
        return this.mSort;
    }
}
