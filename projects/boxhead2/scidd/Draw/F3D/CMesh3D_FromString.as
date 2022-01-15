class scidd.Draw.F3D.CMesh3D_FromString
{
    var _CLASSID_ = "scidd.Draw.F3D.CMesh3D_FromString";
    var mJustOnce = true;
    var mDebug = true;
    function CMesh3D_FromString(tString)
    {
        this.CreateMesh3D(tString);
    }
    function CreateMesh3D(tCompileString)
    {
        this.mMesh3D = new scidd.Draw.F3D.CMesh3D("DONT_MATTER");
        var _loc4_ = tCompileString.split("@0");
        0;
        while(0 < _loc4_.length)
        {
            var _loc2_ = _loc4_[0].split("@1");
            switch(_loc2_[0])
            {
                case "MATERIALLIST":
                    this.Compile_MaterialLibrary(_loc2_);
                    break;
                case "MODEL":
                    this.Compile_Model(_loc2_,2,false);
            }
            1;
        }
        this.mMesh3D.Finalize(false,false,false,false);
    }
    function Compile_MaterialLibrary(tCompileList)
    {
        this.mMaterialList = new Array();
        1;
        while(1 < tCompileList.length)
        {
            var _loc6_ = tCompileList[1].split("@2");
            var _loc5_ = new Object();
            0;
            while(0 < _loc6_.length)
            {
                var _loc3_ = _loc6_[0].split(":");
                switch(_loc3_[0])
                {
                    case "MATERIAL":
                        break;
                    case "NAME":
                        _loc5_.mName = _loc3_[1];
                        break;
                    case "COLOR":
                        var _loc2_ = _loc3_[1].split(",");
                        _loc5_.mColor = new scidd.Draw.CColor(Number(_loc2_[1]),Number(_loc2_[2]),Number(_loc2_[3]),Number(_loc2_[0]));
                }
                1;
            }
            this.mMaterialList[this.mMaterialList.length] = _loc5_;
            2;
        }
    }
    function Compile_GetMaterial(tMaterialName)
    {
        for(var _loc2_ in this.mMaterialList)
        {
            if(this.mMaterialList[_loc2_].mName == tMaterialName)
            {
                return this.mMaterialList[_loc2_];
            }
        }
        return undefined;
    }
    function Compile_Model(tCompileList, tKey, tCollideFace)
    {
        this.mCollideFace = tCollideFace;
        this.mVOffset = this.mMesh3D.mPosition_List.length;
        this.mNOffset = this.mMesh3D.mNormal_List.length;
        this.mUVOffset = this.mMesh3D.mUV_List.length;
        1;
        while(1 < tCompileList.length)
        {
            var _loc2_ = tCompileList[1].split("@" + tKey);
            if(_loc2_.length == 1)
            {
                var _loc4_ = _loc2_[0].split(":");
                switch(_loc4_[0])
                {
                    case "NAME":
                        if(_loc4_[1] == "COLLISIONSHAPE2D")
                        {
                            this.mCollideFace = true;
                            break;
                        }
                        break;
                    case "ID":
                }
            }
            else
            {
                switch(_loc2_[0])
                {
                    case "MODEL":
                        this.Compile_Model(_loc2_,tKey + 1,this.mCollideFace);
                        break;
                    case "MESH":
                        this.Compile_Mesh(_loc2_,tKey + 1);
                }
            }
            2;
        }
    }
    function Compile_Mesh(tCompileList, tKey)
    {
        1;
        while(1 < tCompileList.length)
        {
            var _loc2_ = tCompileList[1].split("@" + tKey);
            if(_loc2_.length != 1)
            {
                switch(_loc2_[0])
                {
                    case "POSITIONLIST":
                        this.Compile_PositionList(_loc2_,tKey + 1);
                        break;
                    case "POLYGONLIST":
                        this.Compile_PolygonList(_loc2_,tKey + 1);
                }
            }
            2;
        }
    }
    function Compile_PolygonList(tCompileList, tKey)
    {
        var _loc9_ = undefined;
        var _loc6_ = undefined;
        var _loc5_ = undefined;
        1;
        while(1 < tCompileList.length)
        {
            var _loc2_ = tCompileList[1].split("@" + tKey);
            if(_loc2_.length == 1)
            {
                var _loc3_ = _loc2_[0].split(":");
                switch(_loc3_[0])
                {
                    case "NAME":
                        _loc9_ = _loc3_[1];
                        break;
                    case "MATERIAL":
                        _loc6_ = _loc3_[1];
                        _loc5_ = scidd.Draw.F3D.CMaterial.newSolidColor(_loc6_,this.Compile_GetMaterial(_loc6_).mColor);
                        _loc5_.mBrightnessOffset = 0.25;
                        this.mMesh3D.AddMaterial(_loc5_);
                }
            }
            else if(_loc2_[0] === "FACE")
            {
                this.Compile_Face(_loc2_,tKey + 1,_loc5_);
            }
            2;
        }
    }
    function Compile_Face(tCompileList, tKey, tMaterial)
    {
        var _loc6_ = new Array();
        var _loc5_ = new Array();
        1;
        while(1 < tCompileList.length)
        {
            var _loc4_ = tCompileList[1].split("@" + tKey);
            if(_loc4_.length == 1)
            {
                var _loc2_ = _loc4_[0].split(":");
                switch(_loc2_[0])
                {
                    case "V":
                        _loc5_[_loc5_.length] = Number(_loc2_[1]);
                        break;
                    case "N":
                        _loc6_[_loc6_.length] = Number(_loc2_[1]);
                }
            }
            2;
        }
        this.Compile_AddFace(_loc5_,_loc6_,tMaterial);
    }
    function Compile_AddFace(tvlist, tnlist, tMaterial)
    {
        0;
        while(0 < tvlist.length)
        {
            tvlist[0] += this.mVOffset;
            1;
        }
        0;
        while(0 < tnlist.length)
        {
            tnlist[0] += this.mNOffset;
            1;
        }
        if(this.mCollideFace)
        {
            this.mMesh3D.AddCollideFace(new scidd.Draw.F3D.CMesh3DFace(tvlist,tnlist,[],tMaterial));
        }
        else
        {
            this.mMesh3D.AddFace(new scidd.Draw.F3D.CMesh3DFace(tvlist,tnlist,[],tMaterial));
        }
    }
    function Compile_PositionList(tCompileList, tKey)
    {
        1;
        while(1 < tCompileList.length)
        {
            var _loc5_ = tCompileList[1].split("@" + tKey);
            if(_loc5_.length == 1)
            {
                var _loc2_ = _loc5_[0].split(":");
                switch(_loc2_[0])
                {
                    case "V":
                        var _loc3_ = _loc2_[1].split(",");
                        this.mMesh3D.AddPosition(new scidd.Math.CVector3(Number(_loc3_[0]),Number(_loc3_[1]),Number(_loc3_[2])));
                        break;
                    case "N":
                        _loc3_ = _loc2_[1].split(",");
                        this.mMesh3D.AddNormal(new scidd.Math.CVector3(Number(_loc3_[0]),Number(_loc3_[1]),Number(_loc3_[2])));
                }
            }
            2;
        }
    }
}
