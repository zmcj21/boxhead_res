class CAnimation extends MovieClip
{
    var _CLASSID_ = "CAnimation";
    static var zPoint = new flash.geom.Point(0,0);
    static var mLight = new scidd.Math.CVector3(1,1,1);
    static var mGlobalScale = 0.28;
    static var mDebug = false;
    static var mDescriptor_Left_Foot = 0;
    static var mDescriptor_Right_Foot = 1;
    static var mDescriptor_Left_Hand = 2;
    static var mDescriptor_Left_LowerArm = 3;
    static var mDescriptor_Left_UpperArm = 4;
    static var mDescriptor_Body = 5;
    static var mDescriptor_Head = 6;
    static var mDescriptor_Right_Hand = 7;
    static var mDescriptor_Right_LowerArm = 8;
    static var mDescriptor_Right_UpperArm = 9;
    static var mDescriptor_Amount = 10;
    var mRights = new Array();
    var mLefts = new Array();
    function CAnimation()
    {
        super();
        CAnimation._this = this;
        this.SetupDescriptors();
        CAnimation.mProjection = CAnimation.mProjection != undefined ? CAnimation.mProjection : new CProjection3D_Axis();
        var _loc8_ = _root;
        if(CAnimation.mBlox_Front == undefined)
        {
            CAnimation.mBlox_Front = _loc8_.attachMovie("Blox.Front","Blox_Front",_loc8_.getNextHighestDepth(),{_visible:false});
            CAnimation.mBlox_Side = _loc8_.attachMovie("Blox.Side","Blox_Side",_loc8_.getNextHighestDepth(),{_visible:false});
        }
        this.mcSprite = _loc8_.createEmptyMovieClip("_Sprite",_loc8_.getNextHighestDepth());
        this.mcSprite._visible = false;
        var _loc9_ = this.mcSprite.attachMovie("Blox.Shadow","_Shadow",this.mcSprite.getNextHighestDepth(),{_yscale:100 * CAnimation.mGlobalScale,_xscale:200 * CAnimation.mGlobalScale,_alpha:50});
        "0001";
        0;
        while(0 < CAnimation.mDescriptors.length)
        {
            var _loc5_ = CAnimation.mDescriptors[0];
            if(!CAnimation.mDebug)
            {
            }
            this.LoadMesh(0,_global[_loc5_.mModelName + "0001"],_loc5_.mAnimationHook,_loc5_.mSide);
            1;
        }
        CAnimation.mDescriptors.reverse();
        this.pDirection = 0;
    }
    function LoadMesh(tIndex, tCompileString, tElement, tSide)
    {
        var _loc2_ = this.mcSprite.createEmptyMovieClip(tElement + this.mcSprite.getNextHighestDepth(),this.mcSprite.getNextHighestDepth());
        _loc2_.pAngle = new scidd.Math.CPointXYZ(0,0,0);
        _loc2_.mSide = tSide;
        _loc2_.mElement = tElement;
        var _loc4_ = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
        _loc2_.mInitialMeshScale = _loc4_.GetScaleFromSize(new scidd.Math.CVector3(CAnimation.mBlox_Side[tElement]._width * CAnimation.mGlobalScale,CAnimation.mBlox_Front[tElement]._width * CAnimation.mGlobalScale,CAnimation.mBlox_Side[tElement]._height * CAnimation.mGlobalScale));
        _loc4_.Scale(_loc2_.mInitialMeshScale);
        switch(tSide)
        {
            case "r":
                this.mRights[this.mRights.length] = _loc2_;
                break;
            case "l":
                this.mLefts[this.mLefts.length] = _loc2_;
        }
        _loc4_.mPosition_List[0].Set(new scidd.Math.CVector3(CAnimation.mBlox_Side[tElement]._x * CAnimation.mGlobalScale,CAnimation.mBlox_Front[tElement]._x * CAnimation.mGlobalScale,(0 - CAnimation.mBlox_Side[tElement]._y) * CAnimation.mGlobalScale));
        _loc2_.mMesh3D = _loc4_;
        CAnimation.mDescriptors[tIndex].mcSprite = _loc2_;
        return _loc2_;
    }
    function ReloadMesh(tSprite, tCompileString)
    {
        var _loc1_ = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
        _loc1_.Scale(tSprite.mInitialMeshScale);
        tSprite.mMesh3D = _loc1_;
    }
    function UpdateSprites(tFrameIndex)
    {
        CAnimation.mBlox_Front.gotoAndStop(tFrameIndex);
        CAnimation.mBlox_Side.gotoAndStop(tFrameIndex);
        if(!CAnimation.mDebug)
        {
        }
        0;
        while(0 < CAnimation.mDescriptors.length)
        {
            var _loc2_ = CAnimation.mDescriptors[0].mcSprite;
            if(!CAnimation.mDebug)
            {
            }
            _loc2_.pAngle = new scidd.Math.CPointXYZ(0,scidd.Math.CMath.DegToRad * CAnimation.mBlox_Side[_loc2_.mElement]._rotation,0);
            var _loc4_ = _loc2_.mMesh3D;
            _loc4_.mPosition_List[0].Set(new scidd.Math.CVector3(CAnimation.mBlox_Side[_loc2_.mElement]._x * CAnimation.mGlobalScale,CAnimation.mBlox_Front[_loc2_.mElement]._x * CAnimation.mGlobalScale,(0 - CAnimation.mBlox_Side[_loc2_.mElement]._y) * CAnimation.mGlobalScale));
            1;
        }
        delete this.mShotVector1;
        delete this.mShotVector2;
        if(CAnimation.mBlox_Side._Shot_Direction_1 != undefined)
        {
            this.mShotVector1 = new scidd.Math.CVector3(CAnimation.mBlox_Side._Shot_Direction_1._x * CAnimation.mGlobalScale,CAnimation.mBlox_Front._Shot_Direction._x * CAnimation.mGlobalScale,(0 - CAnimation.mBlox_Side._Shot_Direction_1._y) * CAnimation.mGlobalScale);
        }
        if(CAnimation.mBlox_Side._Shot_Direction_2 != undefined)
        {
            this.mShotVector2 = new scidd.Math.CVector3(CAnimation.mBlox_Side._Shot_Direction_2._x * CAnimation.mGlobalScale,CAnimation.mBlox_Front._Shot_Direction._x * CAnimation.mGlobalScale,(0 - CAnimation.mBlox_Side._Shot_Direction_2._y) * CAnimation.mGlobalScale);
        }
    }
    function CreateAnimation(tID, tModelInfo, tDirectionAmount, tAnimations)
    {
        var _loc12_ = undefined;
        for(var _loc16_ in CAnimation.mAnimationList)
        {
            if(CAnimation.mAnimationList[_loc16_].mID == tID)
            {
                _loc12_ = CAnimation.mAnimationList[_loc16_];
            }
        }
        var _loc6_ = new Object();
        _loc6_.mID = tID;
        _loc6_.mDirectionAmount = tDirectionAmount;
        _loc6_.mDirectionDiv = 6.283185307179586 / tDirectionAmount;
        if(!CAnimation.mDebug)
        {
        }
        if(_loc12_ == undefined)
        {
            0;
            while(0 < CAnimation.mDescriptors.length)
            {
                var _loc10_ = CAnimation.mDescriptors[0];
                if(!CAnimation.mDebug)
                {
                }
                this.ReloadMesh(_loc10_.mcSprite,_global[_loc10_.mModelName + tModelInfo[0].mModelName]);
                _loc10_.mcSprite._visible = tModelInfo[0].mVisible;
                1;
            }
        }
        for(_loc16_ in tAnimations)
        {
            var _loc8_ = tAnimations[_loc16_].mAnimation;
            var _loc3_ = tAnimations[_loc16_].mID;
            _loc6_[_loc3_] = new Object();
            _loc6_[_loc3_].mID = _loc3_;
            if(_loc12_ == undefined)
            {
                _loc6_[_loc3_].mFrames = new Array();
                CAnimation.mBlox_Side.gotoAndStop(_loc8_);
                var _loc11_ = CAnimation.mBlox_Side[_loc8_];
                _loc6_[_loc3_].mFrameCount = _loc11_;
                0;
                var _loc7_ = CAnimation.mBlox_Side._currentframe;
                while(0 < _loc11_)
                {
                    this.UpdateSprites(_loc7_);
                    _loc6_[_loc3_].mFrames[0] = new Array();
                    this.pDirection = 0;
                    0;
                    while(0 < tDirectionAmount)
                    {
                        _loc6_[_loc3_].mFrames[0][0] = this.BufferSprite();
                        if(!CAnimation.mDebug)
                        {
                        }
                        1;
                        0;
                        this.pDirection -= 6.283185307179586 / tDirectionAmount;
                    }
                    1;
                    0;
                    _loc7_;
                    _loc7_++;
                }
            }
            else
            {
                _loc6_[_loc3_].mFrameCount = _loc12_[_loc3_].mFrameCount;
                _loc6_[_loc3_].mFrames = _loc12_[_loc3_].mFrames;
            }
        }
        CAnimation.mAnimationList = CAnimation.mAnimationList != undefined ? CAnimation.mAnimationList : new Array();
        if(_loc12_ == undefined)
        {
            CAnimation.mAnimationList[CAnimation.mAnimationList.length] = _loc6_;
        }
        if(!CAnimation.mDebug)
        {
        }
        return _loc6_;
    }
    function SetAnimation(tAnimationObject, tAnim, tFrameIndex, tAngle)
    {
        if(tAnimationObject[tAnim] == undefined)
        {
            return undefined;
        }
        var _loc0_ = null;
        var _loc2_ = tAnimationObject.mCurrentAnimation = tAnimationObject[tAnim];
        if(tFrameIndex != undefined)
        {
            _loc2_.mFrameIndex = tFrameIndex;
        }
        else if(_loc2_.mFrameIndex == undefined)
        {
            _loc2_.mFrameIndex = random(_loc2_.mFrameCount);
        }
        this.Animate(tAnimationObject,0,tAngle);
    }
    function Animate(tAnimationObject, tTick, tAngle)
    {
        var _loc1_ = tAnimationObject.mCurrentAnimation;
        _loc1_.mFrameIndex = (_loc1_.mFrameIndex + tTick) % _loc1_.mFrameCount;
        var _loc4_ = Math.floor(_loc1_.mFrameIndex);
        tAngle = Math.round(tAngle / tAnimationObject.mDirectionDiv);
        tAngle %= tAnimationObject.mDirectionAmount;
        if(tAngle < 0)
        {
            if(!CAnimation.mDebug)
            {
            }
        }
        tAnimationObject.mCurrent = _loc1_.mFrames[_loc4_][tAngle];
        return _loc1_.mFrameIndex + tTick >= _loc1_.mFrameCount;
    }
    function BufferSprite()
    {
        this.mcSprite.clear();
        0;
        while(0 < CAnimation.mDescriptors.length)
        {
            var _loc2_ = CAnimation.mDescriptors[0].mcSprite;
            _loc2_.clear();
            _loc2_.pAngle.mZ = this.pDirection;
            var _loc4_ = _loc2_.mMesh3D;
            CAnimation.mProjection.Project(_loc4_,_loc2_.pAngle);
            _loc4_.QRender(_loc2_,undefined,CAnimation.mLight);
            CAnimation.mProjection.Project0(_loc4_,new scidd.Math.CPointXYZ(0,0,this.pDirection));
            _loc2_._x = _loc2_.mMesh3D.mPosition_List_Projected[0].mX;
            _loc2_._y = _loc2_.mMesh3D.mPosition_List_Projected[0].mY;
            _loc2_.mSort = _loc2_.mMesh3D.mPosition_List_Projected[0].mSort;
            1;
        }
        var _loc10_ = this.mLefts[2]._y;
        var _loc8_ = this.mRights[2]._y;
        var _loc11_ = this.mLefts[2].getDepth();
        var _loc9_ = this.mRights[2].getDepth();
        if(_loc10_ > _loc8_ && _loc11_ < _loc9_ || _loc10_ < _loc8_ && _loc11_ > _loc9_)
        {
            0;
            while(0 < this.mLefts.length)
            {
                this.mRights[0].swapDepths(this.mLefts[0].getDepth());
                1;
            }
        }
        var _loc5_ = this._renderToBitmap(this.mcSprite);
        if(this.mShotVector1 != undefined)
        {
            var _loc6_ = CAnimation.mProjection.Project_Vector3(_loc4_,new scidd.Math.CPointXYZ(0,0,this.pDirection),this.mShotVector1);
            _loc5_.mShotInfo = _loc5_.mShotInfo != undefined ? _loc5_.mShotInfo : new Array();
            _loc5_.mShotInfo[_loc5_.mShotInfo.length] = {mPosition:new scidd.Math.CPointXYZ(_loc6_.mX,_loc6_.mY,_loc6_.mZ),mDirection:new scidd.Math.CPointXYZ(0,0,3.141592653589793 - this.pDirection + 3.141592653589793)};
        }
        if(this.mShotVector2 != undefined)
        {
            var _loc7_ = CAnimation.mProjection.Project_Vector3(_loc4_,new scidd.Math.CPointXYZ(0,0,this.pDirection),this.mShotVector2);
            _loc5_.mShotInfo = _loc5_.mShotInfo != undefined ? _loc5_.mShotInfo : new Array();
            _loc5_.mShotInfo[_loc5_.mShotInfo.length] = {mPosition:new scidd.Math.CPointXYZ(_loc7_.mX,_loc7_.mY,_loc7_.mZ),mDirection:new scidd.Math.CPointXYZ(0,0,3.141592653589793 - this.pDirection + 3.141592653589793)};
        }
        return _loc5_;
    }
    function OrderSprites(s1, s2)
    {
        return s1.mSort <= s2.mSort ? (s1.mSort >= s2.mSort ? 0 : -1) : 1;
    }
    function _renderToBitmap(mc)
    {
        var _loc4_ = undefined;
        var _loc3_ = undefined;
        var _loc1_ = mc.getBounds(mc);
        var _loc2_ = new flash.geom.Rectangle(Math.floor(_loc1_.xMin),Math.floor(_loc1_.yMin),Math.ceil(_loc1_.xMax) - Math.floor(_loc1_.xMin),Math.ceil(_loc1_.yMax) - Math.floor(_loc1_.yMin));
        _loc2_.inflate(1,1);
        _loc3_ = new flash.display.BitmapData(_loc2_.width,_loc2_.height,true,16711680);
        _loc4_ = new flash.geom.Point(_loc2_.x,_loc2_.y);
        var _loc5_ = new flash.geom.Matrix();
        _loc5_.translate(0 - _loc4_.x,0 - _loc4_.y);
        _loc3_.draw(mc,_loc5_,undefined,"normal",undefined,false);
        _loc3_.applyFilter(_loc3_,_loc3_.rectangle,CAnimation.zPoint,CAnimation.colorMatrix);
        return {sBMD:_loc3_,mDisp:_loc4_};
    }
    function Render(dBMD, tAnimationObject, tPosition, tAlpha)
    {
        var _loc1_ = tAnimationObject.mCurrent;
        var _loc2_ = tPosition.add(_loc1_.mDisp);
        if(tAlpha == undefined)
        {
            dBMD.copyPixels(_loc1_.sBMD,_loc1_.sBMD.rectangle,_loc2_,undefined,undefined,true);
        }
        else
        {
            var _loc3_ = new flash.geom.Matrix(1,0,0,1,_loc2_.x,_loc2_.y);
            dBMD.draw(_loc1_.sBMD,_loc3_,new flash.geom.ColorTransform(1,1,1,tAlpha / 100,0,0,0,0));
        }
    }
    function SetupDescriptors()
    {
        if(CAnimation.mDescriptors != undefined)
        {
            return undefined;
        }
        CAnimation.mDescriptors = new Array();
        CAnimation.mDescriptors[CAnimation.mDescriptor_Left_Foot] = {mModelName:"MODEL_Foot_",mAnimationHook:"_Left_Foot",mSide:"l"};
        CAnimation.mDescriptors[CAnimation.mDescriptor_Right_Foot] = {mModelName:"MODEL_Foot_",mAnimationHook:"_Right_Foot",mSide:"r"};
        CAnimation.mDescriptors[CAnimation.mDescriptor_Left_Hand] = {mModelName:"MODEL_Hand_",mAnimationHook:"_Left_Hand",mSide:"l"};
        CAnimation.mDescriptors[CAnimation.mDescriptor_Left_LowerArm] = {mModelName:"MODEL_LowerArm_",mAnimationHook:"_Left_LowerArm",mSide:"l"};
        CAnimation.mDescriptors[CAnimation.mDescriptor_Left_UpperArm] = {mModelName:"MODEL_UpperArm_",mAnimationHook:"_Left_UpperArm",mSide:"l"};
        CAnimation.mDescriptors[CAnimation.mDescriptor_Body] = {mModelName:"MODEL_Body_",mAnimationHook:"_Body",mSide:"n"};
        CAnimation.mDescriptors[CAnimation.mDescriptor_Head] = {mModelName:"MODEL_Head_",mAnimationHook:"_Head",mSide:"n"};
        CAnimation.mDescriptors[CAnimation.mDescriptor_Right_Hand] = {mModelName:"MODEL_Hand_",mAnimationHook:"_Right_Hand",mSide:"r"};
        CAnimation.mDescriptors[CAnimation.mDescriptor_Right_LowerArm] = {mModelName:"MODEL_LowerArm_",mAnimationHook:"_Right_LowerArm",mSide:"r"};
        CAnimation.mDescriptors[CAnimation.mDescriptor_Right_UpperArm] = {mModelName:"MODEL_UpperArm_",mAnimationHook:"_Right_UpperArm",mSide:"r"};
    }
    static function CreateDefaultDescriptors(tModelName)
    {
        var _loc4_ = new Array();
        0;
        while(0 < CAnimation.mDescriptor_Amount)
        {
            _loc4_[0] = {mModelName:tModelName,mVisible:true};
            1;
        }
        return _loc4_;
    }
}
