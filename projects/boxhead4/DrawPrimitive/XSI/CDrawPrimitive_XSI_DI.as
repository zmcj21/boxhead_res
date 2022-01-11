class DrawPrimitive.XSI.CDrawPrimitive_XSI_DI extends DrawPrimitive.XSI.CDrawPrimitive_XSI
{
    var _CLASSID_ = "CDrawPrimitive_XSI_DI";
    var _BASECLASSID_ = "CDrawPrimitive_XSI_DI";
    static var mAnimationSets = new Object();
    static var mGroups = new Object();
    static var mShader_Contrast = 0.5;
    static var mContrast = 0.5;
    static var mQuiet = true;
    var mRenderFlag_Shadow = 1;
    var mRenderFlag_Edge = 2;
    var mRenderFlag_ProfileEdge = 4;
    var mRenderFlag_ModelEdge = 8;
    var mRenderFlag_Texture = 16;
    var mRenderFlag_Shader = 32;
    var mRenderFlag_All = 255;
    var mRenderFlags = DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.prototype.mRenderFlag_Shadow | DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.prototype.mRenderFlag_Texture | DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.prototype.mRenderFlag_Shader | DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.prototype.mRenderFlag_ProfileEdge;
    function CDrawPrimitive_XSI_DI(tXSI_List)
    {
        super();
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mXSI_DI = this;
        this.mMasterMaterials = new Object();
        this.mModels = new Object();
        this.mTotalFrames = 0;
        this.mTotalPixels = 0;
        this.mVertex_Count = 0;
        DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mRenderCount_Frames = 0;
        DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mRenderStack = new Array();
        1117;
        for(var _loc7_ in tXSI_List)
        {
            var _loc5_ = tXSI_List[_loc7_];
            var _loc4_ = new Object();
            _loc4_.mGroupID = _loc5_.mGroupID;
            _loc4_.mAnimID = _loc5_.mAnimID;
            _loc4_.mID = _loc5_.mGroupID + "_" + _loc5_.mAnimID;
            _loc4_.mDimensions = 0;
            _loc4_.pClass = this;
            this.Register_Materials(_loc5_.mXSI.mMaterials);
            _loc4_.mDirections = this.CompileXSIData(_loc5_.mXSI,_loc4_.mAnimID,_loc5_.mRenderPartner);
            _loc4_.mTilt = _loc5_.mXSI.mXSIInfo.mTilt * 3.141592653589793 / 180;
            _loc4_.mLight = _loc5_.mXSI.mXSIInfo.mLight;
            _loc4_.mFrameSequence = _loc5_.mFrameSquence;
            if(!DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mGroups[_loc4_.mGroupID])
            {
                DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mGroups[_loc4_.mGroupID] = new Object();
            }
            DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mGroups[_loc4_.mGroupID][_loc4_.mAnimID] = _loc4_;
            DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mAnimationSets[_loc4_.mID] = _loc4_;
            if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mQuiet)
            {
            }
        }
        if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mQuiet)
        {
        }
        this.LoadMaterials(this.mMasterMaterials);
        if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mQuiet)
        {
        }
        if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mQuiet)
        {
        }
        this.mcContainer = _root.createEmptyMovieClip("CDrawPrimitive_XSI_DI_mcContainer",_root.getNextHighestDepth());
        this.mcShadow = this.mcContainer.createEmptyMovieClip("CDrawPrimitive_XSI_DI_Shadow",this.mcContainer.getNextHighestDepth());
        this.mcGraphic = this.mcContainer.createEmptyMovieClip("CDrawPrimitive_XSI_DI_Graphics",this.mcContainer.getNextHighestDepth());
        this.mcPlanes = new Array();
        this.mcShadow.filters = [new flash.filters.DropShadowFilter(0,0,0,1,4,4,0.25,1,false,false,true)];
        this.mcContainer._visible = false;
    }
    function CompileXSIData(tXSIData, animID, tPartner)
    {
        var _loc4_ = tXSIData.mRotations;
        for(var _loc8_ in _loc4_)
        {
            var _loc3_ = _loc4_[_loc8_];
            for(var _loc7_ in _loc3_)
            {
                var _loc2_ = _loc3_[_loc7_];
                _loc2_.mDirection = Number(_loc8_);
                _loc2_.mFrameIndex = Number(_loc7_);
                _loc2_.mAnimID = animID;
                _loc2_.rPartner = tPartner;
                this.mTotalFrames++;
            }
        }
        return tXSIData.mRotations;
    }
    function GetStyleSheet(tAnimationSetID)
    {
        var _loc3_ = new Object();
        var _loc10_ = undefined;
        if(_loc10_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mAnimationSets[tAnimationSetID])
        {
            _loc3_.mDirectionCount = _loc10_.mDirections.length;
            _loc3_.mFrameCount = _loc10_.mDirections[0].length;
            _loc3_.mModels = new Object();
            var _loc6_ = _loc10_.mDirections[0][0].Models;
            for(var _loc9_ in _loc6_)
            {
                var _loc8_ = _loc6_[_loc9_];
                _loc3_.mModels[_loc9_] = new Object();
                _loc3_.mModels[_loc9_].mGroup_Remap = undefined;
                _loc3_.mModels[_loc9_].mVisible = true;
            }
            var _loc5_ = this.mMasterMaterials;
            _loc3_.mMaterials = new Object();
            for(_loc9_ in _loc5_)
            {
                var _loc2_ = _loc5_[_loc9_];
                var _loc4_ = new Object();
                for(var _loc7_ in _loc2_)
                {
                    _loc4_[_loc7_] = _loc2_[_loc7_];
                }
                _loc3_.mMaterials[_loc9_] = _loc4_;
            }
            _loc3_.mScale = 0.35;
            return _loc3_;
        }
        if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mQuiet)
        {
        }
        return undefined;
    }
    function ApplyStyleSheet(tStyleSheet)
    {
        if(this.mStyleSheet == tStyleSheet)
        {
            return undefined;
        }
        this.mStyleSheet = tStyleSheet;
        this.LoadMaterials(!this.mStyleSheet ? this.mMasterMaterials : this.mStyleSheet.mMaterials);
    }
    static function LoadAnimation(oXSI_Animation, linkID, tRetrieveID)
    {
        7926;
        var _loc4_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mAnimationSets[linkID];
        if(!_loc4_)
        {
            return false;
        }
        var _loc8_ = _loc4_.pClass;
        var _loc6_ = oXSI_Animation.Init_AnimationObject(_loc4_.mDirections.length);
        _loc6_.XSI_Info.Tilt = _loc4_.mTilt;
        _loc6_.XSI_Info.Light = _loc4_.mLight;
        _loc6_.XSI_Info.PFactor = 0 - Math.sin(_loc4_.mTilt);
        Thing.Math.CThing_Position.mPFactor = _loc6_.XSI_Info.PFactor;
        0;
        while(0 < _loc6_.mDirections.length)
        {
            var _loc3_ = _loc4_.mDirections[0];
            var _loc0_ = null;
            var _loc11_ = _loc6_.mDirections[0] = {mFrames:new Array(_loc3_.length)};
            var _loc7_ = !_loc4_.mFrameSequence ? _loc3_.length : _loc4_.mFrameSequence.length;
            _loc6_.mFrameCount = _loc7_;
            0;
            while(0 < _loc7_)
            {
                var _loc2_ = undefined;
                if(_loc4_.mFrameSequence && _loc4_.mFrameSequence[0] != 0)
                {
                    _loc2_ = _loc6_.mDirections[0].mFrames[_loc4_.mFrameSequence[0]];
                }
                if(!_loc2_)
                {
                    _loc2_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.AddToRenderStack(_loc8_,_loc3_[0],oXSI_Animation);
                    _loc2_.XSI_Info = new Object();
                    DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.FillXSIInfo(_loc3_[0].Models,_loc2_,"Hand_Right");
                    DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.FillXSIInfo(_loc3_[0].Models,_loc2_,"Hand_Left");
                    DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.FillXSIInfo(_loc3_[0].Models,_loc2_,"GunPosition_Right");
                }
                _loc6_.mDirections[0].mFrames[0] = _loc2_;
                _loc8_.mTotalPixels += _loc2_.sBMD.width * _loc2_.sBMD.height;
                1;
            }
            1;
        }
        if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mQuiet)
        {
        }
        if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mQuiet)
        {
        }
        if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mQuiet)
        {
        }
        return true;
    }
    static function FillXSIInfo(tModels, oFrame, mprop)
    {
        var _loc2_ = tModels[mprop].XSIInfo;
        var _loc0_ = null;
        var _loc1_ = oFrame.XSI_Info["XSI_Model_" + mprop] = new Object();
        _loc1_.vPosition = new Thing.Math.CThing_Position(_loc2_.vPosition.mX,_loc2_.vPosition.mY,_loc2_.vPosition.mZ).ScaleN(DrawPrimitive.XSI.CDrawPrimitive_XSI.mGlobalScale);
        _loc1_.nPosition = new Thing.Math.CThing_Position(_loc1_.vPosition.mX,Thing.Math.CThing_Position.mPFactor * _loc1_.vPosition.mY,0 - _loc1_.vPosition.mZ).ScaleN(1 / World.Map.CMap_Cell.mCellSize);
    }
    static function AddToRenderStack(asParent, oFrame, oXSI_Animation)
    {
        var _loc7_ = {asParent:asParent,oFrame:oFrame,oXSI_Animation:oXSI_Animation,mStyleSheet:asParent.mStyleSheet};
        var _loc1_ = {sBMD:undefined,mDisp:undefined,XSI_Info:undefined,renderInfo:_loc7_};
        DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mRenderStack.push(_loc1_);
        return _loc1_;
    }
    static function RenderStack_Process(timeStamp, timeAmount)
    {
        DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection.StartRender();
        0;
        while(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mRenderStack.length)
        {
            var _loc2_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mRenderStack.pop();
            var _loc1_ = _loc2_.renderInfo;
            DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.SS_APPLY(_loc1_.mStyleSheet);
            _loc1_.asParent.Render(_loc1_.oFrame);
            var _loc3_ = _loc1_.asParent.RenderToBitmap(_loc1_.oXSI_Animation);
            _loc2_.sBMD = _loc3_.sBMD;
            _loc2_.mDisp = _loc3_.mDisp;
            1;
            if(1779 - timeStamp >= timeAmount)
            {
                DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection.EndRender();
                return true;
            }
        }
        DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection.EndRender();
        return false;
    }
    static function RenderStack_Finished()
    {
        return DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mRenderStack.length == 0;
    }
    function RenderToBitmap(oXSI_Animation)
    {
        var _loc2_ = oXSI_Animation.RenderToBitmap(this.mcContainer);
        return _loc2_;
    }
    function CombineRenderObjects(oBMD1, oBMD2)
    {
        return undefined;
    }
    function Register_Materials(XSIMaterials)
    {
        for(var _loc3_ in XSIMaterials)
        {
            this.mMasterMaterials[_loc3_] = XSIMaterials[_loc3_];
        }
    }
    function ConvertVLIST(mvListX, mvListY, vList)
    {
        for(var _loc5_ in vList)
        {
            vList[_loc5_] = {x:mvListX[vList[_loc5_]],y:mvListY[vList[_loc5_]]};
            this.mVertex_Count++;
        }
    }
    function Render(oFrame)
    {
        if(!oFrame)
        {
            if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mQuiet)
            {
            }
            return undefined;
        }
        DrawPrimitive.XSI.CDrawPrimitive_XSI.mGlobalScale = !this.mStyleSheet.mScale ? DrawPrimitive.XSI.CDrawPrimitive_XSI.mGlobalScale : this.mStyleSheet.mScale;
        this.mcShadow.clear();
        for(var _loc29_ in this.mcPlanes)
        {
            this.mcPlanes[_loc29_].clear();
        }
        0;
        var _loc17_ = this.mMaterials;
        var _loc18_ = undefined;
        var _loc22_ = this.mStyleSheet.mModels;
        var _loc32_ = oFrame.mDirection;
        var _loc31_ = oFrame.mFrameIndex;
        var _loc30_ = oFrame.mAnimID;
        var _loc27_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mGroups[this.mStyleSheet.mGroup_Remap][_loc30_].mDirections[_loc32_][_loc31_].Models;
        var _loc26_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mGroups[oFrame.rPartner][_loc30_].mDirections[_loc32_][_loc31_].Models;
        var _loc33_ = this.mStyleSheet.mScalarMatrix;
        var _loc23_ = oFrame.Models;
        -1;
        for(_loc29_ in _loc23_)
        {
            var _loc5_ = _loc23_[_loc29_];
            var _loc24_ = _loc5_;
            var _loc16_ = _loc29_;
            0;
            if(!this.mcPlanes[0])
            {
                this.mcPlanes[0] = this.mcGraphic.createEmptyMovieClip("_Plane0",10000);
            }
            var _loc2_ = this.mcPlanes[0];
            if(_loc5_.Empty)
            {
                _loc5_ = !(_loc18_ = _loc26_[_loc16_]) ? _loc5_ : _loc18_;
            }
            if(_loc22_)
            {
                var _loc15_ = _loc22_[_loc16_];
                if(_loc15_)
                {
                    if(!_loc15_.mVisible)
                    {
                        continue;
                    }
                    if(_loc15_.mGroup_Remap)
                    {
                        _loc5_ = !(_loc18_ = _loc27_[_loc16_]) ? _loc5_ : _loc18_;
                    }
                }
            }
            if(this.mRenderFlags & this.mRenderFlag_ProfileEdge)
            {
                var _loc10_ = _loc17_.PEdge;
                _loc2_.lineStyle(_loc10_.mThickness,_loc10_.mColor,_loc10_.mAlpha);
                var _loc14_ = _loc5_.PEdge;
                for(var _loc25_ in _loc14_)
                {
                    var _loc4_ = _loc14_[_loc25_];
                    _loc2_.moveTo(_loc4_[0],_loc4_[1]);
                    2;
                    var _loc7_ = _loc4_.length;
                    while(2 < _loc7_)
                    {
                        _loc2_.lineTo(_loc4_[2],_loc4_[3]);
                        4;
                    }
                }
                _loc2_.beginFill(0,0);
                _loc2_.lineStyle(0,0,0);
                _loc2_.endFill();
            }
            var _loc11_ = _loc5_.Shape_vList;
            var _loc19_ = _loc5_.Shape_Matrix;
            var _loc13_ = _loc5_.Shape_Material;
            var _loc21_ = _loc5_.Shape_Brightness;
            for(_loc29_ in _loc11_)
            {
                _loc4_ = _loc11_[_loc29_];
                var _loc8_ = _loc19_[_loc29_];
                var _loc20_ = _loc13_[_loc29_];
                var _loc6_ = _loc21_[_loc29_];
                _loc10_ = _loc17_[_loc13_[_loc29_]];
                if(_loc8_)
                {
                    _loc2_.beginBitmapFill(_loc10_.sBMD,_loc8_,true,true);
                }
                else
                {
                    _loc2_.beginFill(_loc10_.mColor,_loc10_.mAlpha);
                }
                _loc2_.moveTo(_loc4_[0],_loc4_[1]);
                2;
                _loc7_ = _loc4_.length;
                while(2 < _loc7_)
                {
                    _loc2_.lineTo(_loc4_[2],_loc4_[3]);
                    4;
                }
                _loc2_.endFill();
                if(this.mRenderFlags & this.mRenderFlag_Shader && _loc6_)
                {
                    _loc2_.beginFill(_loc6_ >= 0 ? 16777215 : 0,100 * Math.abs(_loc6_) * DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mShader_Contrast);
                    _loc2_.moveTo(_loc4_[0],_loc4_[1]);
                    2;
                    _loc7_ = _loc4_.length;
                    while(2 < _loc7_)
                    {
                        _loc2_.lineTo(_loc4_[2],_loc4_[3]);
                        4;
                    }
                    _loc2_.endFill();
                }
            }
            if(this.mRenderFlags & this.mRenderFlag_Shadow)
            {
                _loc10_ = _loc17_.Shadow;
                var _loc12_ = _loc5_.Shadow;
                for(_loc29_ in _loc12_)
                {
                    _loc4_ = _loc12_[_loc29_];
                    this.mcShadow.beginFill(_loc10_.mColor,_loc10_.mAlpha);
                    this.mcShadow.moveTo(_loc4_[0],_loc4_[1]);
                    2;
                    _loc7_ = _loc4_.length;
                    while(2 < _loc7_)
                    {
                        this.mcShadow.lineTo(_loc4_[2],_loc4_[3]);
                        4;
                    }
                    this.mcShadow.endFill();
                }
            }
        }
        DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.mRenderCount_Frames++;
    }
    function LoadMaterials(tMaterials)
    {
        for(var _loc4_ in tMaterials)
        {
            var _loc2_ = tMaterials[_loc4_];
            this.LoadMaterial(_loc2_);
        }
        this.mMaterials = tMaterials;
    }
    function LoadMaterial(tMat)
    {
        if(tMat.mcLinkID)
        {
            if(tMat.mcLinkID != tMat.mcBMD.LoadedID)
            {
                tMat.mcBMD.removeMovieClip();
                tMat.mcBMD = _root.attachMovie(tMat.mcLinkID,"_temp",_root.getNextHighestDepth(),{_visible:false});
                tMat.mcBMD.LoadedID = tMat.mcLinkID;
            }
            tMat.sBMD = !tMat.sBMD ? new flash.display.BitmapData(tMat.mSize.x,tMat.mSize.y,true,0) : tMat.sBMD;
            tMat.sBMD.draw(tMat.mcBMD);
        }
    }
    function DP(mc, p, c, s)
    {
        mc.lineStyle(s / 2.5,c,100);
        mc.moveTo(p.x - s,p.y - s);
        mc.lineTo(p.x + s,p.y + s);
        mc.moveTo(p.x + s,p.y - s);
        mc.lineTo(p.x - s,p.y + s);
    }
}
