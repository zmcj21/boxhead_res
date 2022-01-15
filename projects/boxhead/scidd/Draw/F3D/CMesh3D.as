class scidd.Draw.F3D.CMesh3D
{
    var _CLASSID_ = "scidd.Draw.F3D.CMesh3D";
    var mScaleFactor = 1;
    function CMesh3D(tID)
    {
        this.mPosition_List = new Array();
        this.mPosition_List_Projected = new Array();
        this.mNormal_List = new Array();
        this.mNormal_List_Projected = new Array();
        this.mUV_List = new Array();
        this.mFace_List = new Array();
        this.mFace_List_Render = new Array();
        this.mMaterial_List = new Array();
        this.mEdge_List = new Array();
        this.mID = tID != undefined ? tID : "DEFAULT";
        this.mUniqueID = 0;
        this.mXMLLoaded = false;
        this.AddPosition(new scidd.Math.CVector3(0,0,0));
        this.mLightSourceDef = new scidd.Math.CVector3(0,0,-1);
    }
    function Render(tDraw_MC, tLightSource, tNoDisplacement, tOverRideMaterial)
    {
        if(!tDraw_MC._visible)
        {
            return undefined;
        }
        if(tLightSource == undefined)
        {
            tLightSource = this.mLightSourceDef;
        }
        this.mFace_List_Render = new Array();
        for(var _loc8_ in this.mFace_List)
        {
            var _loc2_ = this.mFace_List[_loc8_];
            if(_loc2_.Backface())
            {
                this.mFace_List_Render[this.mFace_List_Render.length] = _loc2_;
            }
            else if(_loc2_.mMaterial.mType == scidd.Draw.F3D.CMaterial.mType_MovieClip)
            {
                _loc2_.mMaterial.ClearMC(tDraw_MC,_loc2_.mID);
            }
        }
        if(tNoDisplacement == undefined || !tNoDisplacement)
        {
            var _loc9_ = this.mPosition_List_Projected[0].Clone();
            this.Render_Displace(_loc9_);
            tDraw_MC._x = _loc9_.mX;
            tDraw_MC._y = _loc9_.mY;
            tDraw_MC._xscale = 100;
            tDraw_MC._yscale = 100;
        }
        tDraw_MC._z = this.mPosition_List_Projected[0].mZ;
        tDraw_MC.mZSort = tDraw_MC._z;
        tDraw_MC.mZRender = tDraw_MC._z;
        tDraw_MC.cacheAsBitmap = false;
        tDraw_MC.clear();
        for(_loc8_ in this.mFace_List_Render)
        {
            _loc2_ = this.mFace_List_Render[_loc8_];
            var _loc4_ = this.mNormal_List_Projected[_loc2_.mN_List[0]];
            var _loc5_ = tOverRideMaterial != undefined ? tOverRideMaterial : _loc2_.mMaterial;
            _loc5_.Render(tDraw_MC,_loc2_,scidd.Draw.F3D.CMesh3DFace.NormalToLight(tLightSource,_loc4_));
        }
    }
    function QRender(tDraw_MC, tOverRideMaterial, tLightSource, tShadow)
    {
        if(tLightSource == undefined)
        {
            tLightSource = this.mLightSourceDef;
        }
        tShadow = tShadow != undefined ? tShadow : false;
        this.mSortDepth = 1000000;
        if(tShadow)
        {
            this.mFace_List_Render = this.mFace_List;
        }
        else
        {
            this.mFace_List_Render = new Array();
            for(var _loc3_ in this.mFace_List)
            {
                var _loc2_ = this.mFace_List[_loc3_];
                if(_loc2_.Backface())
                {
                    var _loc4_ = _loc2_.SetSort_Min();
                    if(_loc4_ < this.mSortDepth)
                    {
                        this.mSortDepth = _loc4_;
                    }
                    this.mFace_List_Render[this.mFace_List_Render.length] = _loc2_;
                }
            }
            this.mFace_List_Render = this.mFace_List_Render.sortOn("mSort",Array.NUMERIC | Array.DESCENDING);
        }
        _loc3_ = this.mFace_List_Render.length - 1;
        while(_loc3_ >= 0)
        {
            _loc2_ = this.mFace_List_Render[_loc3_];
            var _loc5_ = this.mNormal_List_Projected[_loc2_.mN_List[0]];
            var _loc6_ = tOverRideMaterial != undefined ? tOverRideMaterial : _loc2_.mMaterial;
            _loc6_.Render(tDraw_MC,_loc2_,scidd.Draw.F3D.CMesh3DFace.NormalToLight(tLightSource,_loc5_));
            _loc3_ = _loc3_ - 1;
        }
    }
    function QRender_MCList(mcList, tMaterialList, tLightSource, tShadow)
    {
        if(tLightSource == undefined)
        {
            tLightSource = this.mLightSourceDef;
        }
        tShadow = tShadow != undefined ? tShadow : false;
        if(tShadow)
        {
            this.mFace_List_Render = this.mFace_List;
        }
        else
        {
            this.mFace_List_Render = new Array();
            for(var _loc3_ in this.mFace_List)
            {
                var _loc2_ = this.mFace_List[_loc3_];
                if(_loc2_.Backface())
                {
                    _loc2_.SetSort_Min();
                    this.mFace_List_Render[this.mFace_List_Render.length] = _loc2_;
                }
                else if(_loc2_.mMaterial.mType == scidd.Draw.F3D.CMaterial.mType_MovieClip)
                {
                    _loc2_.mMaterial.ClearMC(tDraw_MC,_loc2_.mID);
                }
            }
            this.mFace_List_Render = this.mFace_List_Render.sortOn("mSort",Array.NUMERIC | Array.DESCENDING);
        }
        for(var _loc10_ in mcList)
        {
            var tDraw_MC = mcList[_loc10_];
            var _loc6_ = tMaterialList[_loc10_];
            tDraw_MC._z = this.mPosition_List_Projected[0].mZ;
            tDraw_MC.mZSort = tDraw_MC._z;
            tDraw_MC.mZRender = tDraw_MC._z;
            tDraw_MC.clear();
            _loc3_ = this.mFace_List_Render.length - 1;
            while(_loc3_ >= 0)
            {
                _loc2_ = this.mFace_List_Render[_loc3_];
                var _loc4_ = this.mNormal_List_Projected[_loc2_.mN_List[0]];
                var _loc5_ = _loc6_ != undefined ? _loc6_ : _loc2_.mMaterial;
                _loc5_.Render(tDraw_MC,_loc2_,scidd.Draw.F3D.CMesh3DFace.NormalToLight(tLightSource,_loc4_));
                _loc3_ = _loc3_ - 1;
            }
        }
    }
    function Render_Displace(tDisp)
    {
        for(var _loc4_ in this.mPosition_List_Projected)
        {
            var _loc2_ = this.mPosition_List_Projected[_loc4_];
            _loc2_.mX -= tDisp.mX;
            _loc2_.mY -= tDisp.mY;
        }
    }
    function UpdatePosition(tDraw_MC, tPosition)
    {
        if(tDraw_MC._visible)
        {
            var _loc3_ = tPosition;
            tDraw_MC._x = _loc3_.mX;
            tDraw_MC._y = _loc3_.mY;
            var _loc4_ = this.ZAlpha(_loc3_.mZ);
            if(tDraw_MC._alpha != _loc4_)
            {
                tDraw_MC._alpha = _loc4_;
            }
            tDraw_MC.mZSort = _loc3_.mZ;
            if(tDraw_MC.cacheAsBitmap == false)
            {
                tDraw_MC.cacheAsBitmap = true;
            }
        }
    }
    function ZAlpha(tz)
    {
        2500;
        var _loc2_ = (2500 - (Math.abs(tz) - 2500)) / 2500;
        if(_loc2_ > 1)
        {
            return 100;
        }
        return _loc2_ * 100;
    }
    function Finalize(tCompress, tTriangulateTextures, tRenewNormal, tMakeUnitSize)
    {
        if(tCompress != undefined && tCompress)
        {
            this.Compress();
        }
        if(tTriangulateTextures != undefined && tTriangulateTextures)
        {
            this.TriangulateTextures();
        }
        this.Create_ListProjected();
        this.MakeUnitLength(tMakeUnitSize);
        if(this.mEdge_List != undefined && this.mEdge_List.length > 0)
        {
            0;
            while(0 < this.mFace_List.length)
            {
                this.mFace_List[0].AssignEdges(this.mEdge_List,this.mPosition_List);
                1;
            }
        }
    }
    function Create_ListProjected()
    {
        0;
        while(0 < this.mPosition_List.length)
        {
            this.mPosition_List_Projected[0] = new scidd.Math.CVector3(0,0,0);
            1;
        }
        0;
        while(0 < this.mNormal_List.length)
        {
            this.mNormal_List_Projected[0] = new scidd.Math.CVector3(0,0,0);
            1;
        }
        0;
        while(0 < this.mFace_List.length)
        {
            this.mFace_List[0].Cache(this.mPosition_List_Projected,this.mNormal_List_Projected,this.mUV_List);
            1;
        }
    }
    function RenewNormals()
    {
        var _loc4_ = this.mFace_List.length - 1;
        while(_loc4_ >= 0)
        {
            var _loc3_ = this.mFace_List[_loc4_];
            var _loc7_ = this.mPosition_List[_loc3_.mV_List[0]];
            var _loc6_ = this.mPosition_List[_loc3_.mV_List[1]];
            var _loc5_ = this.mPosition_List[_loc3_.mV_List[2]];
            var _loc2_ = _loc3_.mN_List.length - 1;
            while(_loc2_ >= 0)
            {
                this.mNormal_List[_loc3_.mN_List[_loc2_]] = this.PlaneNormal(_loc5_,_loc6_,_loc7_);
                _loc2_ = _loc2_ - 1;
            }
            _loc4_ = _loc4_ - 1;
        }
    }
    function TriangulateTextures()
    {
        var _loc3_ = this.mFace_List.length - 1;
        while(_loc3_ >= 0)
        {
            var _loc2_ = this.mFace_List[_loc3_];
            if(_loc2_.mV_List.length == 4 && _loc2_.mMaterial.__get__mNeedsTriangluation())
            {
                var _loc13_ = this.mUV_List[_loc2_.mUV_List[0]];
                var _loc12_ = this.mUV_List[_loc2_.mUV_List[1]];
                var _loc11_ = this.mUV_List[_loc2_.mUV_List[2]];
                var _loc10_ = this.mUV_List[_loc2_.mUV_List[3]];
                var _loc8_ = new Array(_loc2_.mV_List[0],_loc2_.mV_List[1],_loc2_.mV_List[2]);
                var _loc9_ = new Array(_loc2_.mV_List[0],_loc2_.mV_List[2],_loc2_.mV_List[3]);
                var _loc4_ = new Array(_loc2_.mN_List[0],_loc2_.mN_List[1],_loc2_.mN_List[2]);
                var _loc5_ = new Array(_loc2_.mN_List[0],_loc2_.mN_List[2],_loc2_.mN_List[3]);
                var _loc7_ = new Array(_loc2_.mUV_List[0],_loc2_.mUV_List[1],_loc2_.mUV_List[2]);
                var _loc6_ = new Array(_loc2_.mUV_List[0],_loc2_.mUV_List[2],_loc2_.mUV_List[3]);
                this.AddFace(new scidd.Draw.F3D.CMesh3DFace(_loc8_,_loc4_,_loc7_,_loc2_.mMaterial));
                this.AddFace(new scidd.Draw.F3D.CMesh3DFace(_loc9_,_loc5_,_loc6_,_loc2_.mMaterial));
                delete this.mFace_List[_loc3_];
                this.mFace_List.splice(_loc3_,1);
            }
            _loc3_ = _loc3_ - 1;
        }
    }
    function SetP(tp, x, y)
    {
        tp.x = x;
        tp.y = y;
    }
    function MakeUnitLength(tMakeUnitSize)
    {
        this.mMin = this.mPosition_List[0].Clone();
        this.mMax = this.mPosition_List[0].Clone();
        1;
        while(1 < this.mPosition_List.length)
        {
            if(this.mPosition_List[1].mX < this.mMin.mX)
            {
                this.mMin.mX = this.mPosition_List[1].mX;
            }
            else if(this.mPosition_List[1].mX > this.mMax.mX)
            {
                this.mMax.mX = this.mPosition_List[1].mX;
            }
            if(this.mPosition_List[1].mY < this.mMin.mY)
            {
                this.mMin.mY = this.mPosition_List[1].mY;
            }
            else if(this.mPosition_List[1].mY > this.mMax.mY)
            {
                this.mMax.mY = this.mPosition_List[1].mY;
            }
            if(this.mPosition_List[1].mZ < this.mMin.mZ)
            {
                this.mMin.mZ = this.mPosition_List[1].mZ;
            }
            else if(this.mPosition_List[1].mZ > this.mMax.mZ)
            {
                this.mMax.mZ = this.mPosition_List[1].mZ;
            }
            2;
        }
        this.mOriginalSize = this.mMax.Clone().Sub(this.mMin);
        this.mUnitSize = this.mOriginalSize.Clone().Normalize(1);
        var _loc3_ = this.mOriginalSize.Clone();
        if(_loc3_.mX > _loc3_.mY && _loc3_.mX > _loc3_.mZ)
        {
            this.mScaleFactor = _loc3_.mX;
        }
        else if(_loc3_.mY > _loc3_.mX && _loc3_.mY > _loc3_.mZ)
        {
            this.mScaleFactor = _loc3_.mY;
        }
        else
        {
            this.mScaleFactor = _loc3_.mZ;
        }
        if(this.mScaleFactor > 0 && (tMakeUnitSize == undefined || tMakeUnitSize == true))
        {
            this.mMin.ScaleN(1 / this.mScaleFactor);
            this.mMax.ScaleN(1 / this.mScaleFactor);
            0;
            while(0 < this.mPosition_List.length)
            {
                this.mPosition_List[0].ScaleN(1 / this.mScaleFactor);
                1;
            }
        }
    }
    function Scale(tScale)
    {
        1;
        while(1 < this.mPosition_List.length)
        {
            this.mPosition_List[1].Scale(tScale);
            2;
        }
    }
    function Size(tSize)
    {
        this.Scale(new scidd.Math.CVector3(tSize.mX / (this.mMax.mX - this.mMin.mX),tSize.mY / (this.mMax.mY - this.mMin.mY),tSize.mZ / (this.mMax.mZ - this.mMin.mZ)));
    }
    function GetScaleFromSize(tSize)
    {
        return new scidd.Math.CVector3(tSize.mX / (this.mMax.mX - this.mMin.mX),tSize.mY / (this.mMax.mY - this.mMin.mY),tSize.mZ / (this.mMax.mZ - this.mMin.mZ));
    }
    function Compress()
    {
        var _loc5_ = this.Compress_1(this.mPosition_List);
        var _loc4_ = this.Compress_1(this.mNormal_List);
        var _loc2_ = this.mFace_List.length - 1;
        while(_loc2_ >= 0)
        {
            var _loc3_ = this.mFace_List[_loc2_];
            _loc3_.RemapV(_loc5_);
            _loc3_.RemapN(_loc4_);
            _loc2_ = _loc2_ - 1;
        }
    }
    function Compress_1(tPositionList)
    {
        var _loc4_ = new Array(tPositionList.length);
        0;
        while(0 < _loc4_.length)
        {
            _loc4_[0] = -1;
            1;
        }
        0;
        while(0 < tPositionList.length - 1)
        {
            1;
            while(1 < tPositionList.length)
            {
                if(tPositionList[0].Equals(tPositionList[1]))
                {
                    delete tPositionList[1];
                    _loc4_[1] = 0;
                }
                2;
            }
            1;
        }
        0;
        0;
        while(0 < tPositionList.length)
        {
            if(_loc4_[0] == -1)
            {
                _loc4_[0] = 0;
                1;
            }
            1;
        }
        0;
        while(0 < tPositionList.length)
        {
            if(tPositionList[0] == undefined)
            {
                tPositionList.splice(0,1);
                -1;
            }
            0;
        }
        return _loc4_;
    }
    function AddFace(tFace)
    {
        tFace.mID = ++this.mUniqueID;
        this.mFace_List[this.mFace_List.length] = tFace;
    }
    function AddCollideFace(tFace)
    {
        tFace.mID = ++this.mUniqueID;
        this.mCollideFace_List = this.mCollideFace_List != undefined ? this.mCollideFace_List : new Array();
        this.mCollideFace_List[this.mCollideFace_List.length] = tFace;
    }
    function AddPosition(tVector3)
    {
        this.mPosition_List[this.mPosition_List.length] = tVector3;
        return this.mPosition_List.length - 1;
    }
    function AddNormal(tVector3, tInvert)
    {
        if(tInvert != undefined && tInvert)
        {
            tVector3.Invert();
        }
        this.mNormal_List[this.mNormal_List.length] = tVector3;
        return this.mNormal_List.length - 1;
    }
    function AddUV(tPoint)
    {
        this.mUV_List[this.mUV_List.length] = tPoint;
        return this.mUV_List.length - 1;
    }
    function AddEdge(tV1, tV2)
    {
        this.mEdge_List[this.mEdge_List.length] = {v1:tV1,v2:tV2};
        return this.mEdge_List.length - 1;
    }
    function AddMaterial(tMaterial)
    {
        this.mMaterial_List[this.mMaterial_List] = tMaterial;
    }
    function PlaneNormal(tv1, tv2, tv3)
    {
        var _loc1_ = tv3.Clone();
        var _loc3_ = tv1.Clone();
        _loc1_.Sub(tv2);
        _loc3_.Sub(tv2);
        var _loc2_ = _loc1_.CrossProduct(_loc3_);
        _loc2_.Normalize(1);
        return _loc2_;
    }
    function ApplyTransformation(tMatrix)
    {
        for(var _loc5_ in this.mPosition_List)
        {
            var _loc3_ = new scidd.Math.CVector3(0,0,0);
            tMatrix.TransformVector(this.mPosition_List[_loc5_],_loc3_);
            this.mPosition_List[_loc5_] = _loc3_;
        }
        for(_loc5_ in this.mNormal_List)
        {
            var _loc2_ = new scidd.Math.CVector3(0,0,0);
            tMatrix.TransformVector_NoTranslate(this.mNormal_List[_loc5_],_loc2_);
            _loc2_.Normalize(1);
            this.mNormal_List[_loc5_] = _loc2_;
        }
    }
}
