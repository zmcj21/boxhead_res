if(!_global.CSprite3D)
{
    var _loc1_ = null;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    };
    var _loc2_ = _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.prototype;
    _loc2_.toString = function toString()
    {
        return "CSprite3D::" + this.mID + " Frames = " + this.mFrameList.length;
    };
    _loc2_.Dispose = 0;
    _loc2_.Render_Solid = function Render_Solid(bmRender, pOrigin)
    {
        var _loc2_ = this.__get__mPosition().Add(pOrigin).toPoint();
        true;
        var _loc3_ = this.GetFrame();
        if(CSprite3D.mCombineSolid)
        {
            this._RenderComponent(_loc3_.mOutline,_loc2_,bmRender,this.mTint);
        }
        else
        {
            this._RenderComponent(_loc3_.mOutline,_loc2_,bmRender,this.mTint);
            this._RenderComponent(_loc3_.mSolid,_loc2_,bmRender,this.mTint);
        }
    };
    _loc2_.Render_Shadow = function Render_Shadow(bmRender, pOrigin)
    {
        this._RenderComponent(this.GetFrame().mShadow,this.__get__mPosition().Subtract(pOrigin).toPoint(),bmRender,undefined,true);
    };
    _loc2_._RenderComponent = function _RenderComponent(tBitmapObject, tOrigin, dBMD, tColor)
    {
        var _loc3_ = tBitmapObject.sBMD;
        if(tColor != undefined)
        {
            if(tBitmapObject._cacheBuffer == undefined || tBitmapObject.mColor != tColor)
            {
                var _loc8_ = scidd.Draw.CColor.GetColorMatrixFilter(scidd.Draw.CColor.ColorMatrix_Colorize(scidd.Draw.CColor.FromRGB(tColor),1,0));
                tBitmapObject._cacheBuffer = tBitmapObject._cacheBuffer != undefined ? tBitmapObject._cacheBuffer : _loc3_.clone();
                tBitmapObject.mColor = tColor;
                tBitmapObject._cacheBuffer.applyFilter(_loc3_,_loc3_.rectangle,CSprite3D.zPoint,_loc8_);
            }
            _loc3_ = tBitmapObject._cacheBuffer;
        }
        switch(this.mType)
        {
            case CSprite3D.mType_FullRotation:
                var _loc4_ = new flash.geom.Matrix();
                _loc4_.translate(tBitmapObject.mDisp.x,tBitmapObject.mDisp.y);
                _loc4_.rotate(this.GetFrameAngle(this._AngleXYZ.mZ));
                _loc4_.translate(tOrigin.x,tOrigin.y);
                dBMD.draw(_loc3_,_loc4_,undefined,"normal",undefined,true);
                break;
            case CSprite3D.mType_NoRotation:
            default:
                var _loc7_ = new flash.geom.Point(tOrigin.x + tBitmapObject.mDisp.x,tOrigin.y + tBitmapObject.mDisp.y);
                dBMD.copyPixels(_loc3_,_loc3_.rectangle,_loc7_,undefined,undefined,true);
        }
    };
    _loc2_.GetFrame = function GetFrame()
    {
        switch(this.mDescription.mType)
        {
            case CSprite3D.mDescType_Flat:
                return this.mFrameList[this.GetFrameIndex(this._AngleXYZ.mZ)];
            case CSprite3D.mDescType_Roll:
                break;
            case CSprite3D.mDescType_Tilt:
                break;
            default:
                break;
            case CSprite3D.mDescType_RollAndTilt:
                return this.mFrameList[this.GetFrameIndex(this._AngleXYZ.mZ)].mFrames[0][1];
        }
        return this.mFrameList[0];
    };
    _loc2_.GetFrameIndex = function GetFrameIndex(radians)
    {
        return (Math.round((radians - this.mRadianStep / 2) * this.mNumberOfFrames / 6.283185307179586) + this.mNumberOfFrames * 1000) % this.mNumberOfFrames;
    };
    _loc2_.GetFrameAngle = function GetFrameAngle(radians)
    {
        return radians - this.GetFrameIndex(radians) * this.mRadianStep;
    };
    _loc2_.CorrectAngle = function CorrectAngle(radians)
    {
        return radians % 6.283185307179586;
    };
    _loc2_.__get__mCollisionShape2D = function __get__mCollisionShape2D()
    {
        if(this._CollisionShape2D == undefined)
        {
            this._CollisionShape2D = new Array();
            var _loc2_ = this.__get__mBounds();
            this._CollisionShape2D = [new flash.geom.Point(_loc2_.mMin.mX,_loc2_.mMin.mZ),new flash.geom.Point(_loc2_.mMax.mX,_loc2_.mMin.mZ),new flash.geom.Point(_loc2_.mMax.mX,_loc2_.mMax.mZ),new flash.geom.Point(_loc2_.mMin.mX,_loc2_.mMax.mZ)];
        }
        return this._CollisionShape2D;
    };
    _loc2_.__get__mCollisionShape2DI = function __get__mCollisionShape2DI()
    {
        if(this._CollisionShape2DI == undefined)
        {
            this._CollisionShape2DI = new Array();
            var _loc2_ = this.__get__mBounds();
            this._CollisionShape2DI = [new flash.geom.Point(_loc2_.mMin.mX,_loc2_.mMin.mZ),new flash.geom.Point(_loc2_.mMax.mX,_loc2_.mMin.mZ),new flash.geom.Point(_loc2_.mMax.mX,_loc2_.mMax.mZ),new flash.geom.Point(_loc2_.mMin.mX,_loc2_.mMax.mZ),new flash.geom.Point(_loc2_.mMin.mX,_loc2_.mMin.mZ)];
        }
        return this._CollisionShape2DI;
    };
    _loc2_.GetCollisionShape2D = function GetCollisionShape2D(m)
    {
        return m != undefined ? this.mFrameList[0].mCollisionShape.ApplyMatrix(m) : this.mFrameList[0].mCollisionShape;
    };
    _loc2_.__get__mRadius2D = function __get__mRadius2D()
    {
        if(this._Radius2D == undefined)
        {
            var _loc2_ = this.__get__mBounds();
            this._Radius2D = Math.abs(_loc2_.mMin.mX);
            if(Math.abs(_loc2_.mMax.mX) > this._Radius2D)
            {
                this._Radius2D = Math.abs(_loc2_.mMax.mX);
            }
            if(Math.abs(_loc2_.mMax.mZ) > this._Radius2D)
            {
                this._Radius2D = Math.abs(_loc2_.mMax.mZ);
            }
            if(Math.abs(_loc2_.mMin.mZ) > this._Radius2D)
            {
                this._Radius2D = Math.abs(_loc2_.mMin.mZ);
            }
        }
        return this._Radius2D;
    };
    _loc2_.__get__mRadius2D_SQR = function __get__mRadius2D_SQR()
    {
        if(this._mRadius2D_SQR == undefined)
        {
            this._mRadius2D_SQR = this.__get__mRadius2D() * this.__get__mRadius2D();
        }
        return this._mRadius2D_SQR;
    };
    _loc2_.__get__pRadius2D = function __get__pRadius2D()
    {
        if(this._pRadius2D == undefined)
        {
            this._pRadius2D = new flash.geom.Point(this.__get__mRadius2D(),this.__get__mRadius2D());
        }
        return this._pRadius2D;
    };
    _loc2_.__get__mRadius2D_D = function __get__mRadius2D_D()
    {
        if(this._Radius2D_D == undefined)
        {
            var _loc2_ = this.__get__mRadius2D();
            this._Radius2D_D = Math.sqrt(_loc2_ * _loc2_ + _loc2_ * _loc2_);
        }
        return this._Radius2D_D;
    };
    _loc2_.__get__mHeight2D = function __get__mHeight2D()
    {
        if(this._Height2D == undefined)
        {
            var _loc2_ = this.__get__mBounds();
            this._Height2D = Math.abs(_loc2_.mMax.mY - _loc2_.mMin.mY);
        }
        return this._Height2D;
    };
    _loc2_.__get__mTotalFrames = function __get__mTotalFrames()
    {
        return this.mFrameList.length;
    };
    _loc2_.__set__mPosition = function __set__mPosition(a)
    {
        this._Position.mX = a.mX;
        this._Position.mY = a.mY;
        this._Position.mZ = a.mZ;
        return this.__get__mPosition();
    };
    _loc2_.__get__mPosition = function __get__mPosition()
    {
        return this._Position;
    };
    _loc2_.__set__mAngle = function set mAngle(a)
    {
        this._AngleXYZ.mZ = a;
    };
    _loc2_.__get__mAngle = function get mAngle()
    {
        return this._AngleXYZ.mZ;
    };
    _loc2_.__set__mTilt = function __set__mTilt(a)
    {
        this._AngleXYZ.mY = a;
        return this.__get__mTilt();
    };
    _loc2_.__get__mTilt = function __get__mTilt()
    {
        return this._AngleXYZ.mY;
    };
    _loc2_.__set__mRoll = function __set__mRoll(a)
    {
        this._AngleXYZ.mX = a;
        return this.__get__mRoll();
    };
    _loc2_.__get__mRoll = function __get__mRoll()
    {
        return this._AngleXYZ.mX;
    };
    _loc2_.__get__mBounds = function get mBounds()
    {
        var _loc2_ = this.mMeshScale;
        var _loc4_ = this.mMesh3D.mMin.Clone().Scale(_loc2_);
        var _loc3_ = this.mMesh3D.mMax.Clone().Scale(_loc2_);
        return {mMin:_loc4_,mMax:_loc3_,mSize:_loc3_.Clone().Sub(_loc4_)};
    };
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.PreRender_Process = function PreRender_Process()
    {
        5355;
        0;
        for(var _loc6_ in CSprite3D.mSpriteList)
        {
            var _loc3_ = CSprite3D.mSpriteList[_loc6_];
            if(_loc3_.mProgressIndex != _loc3_.mProgressTotal)
            {
                while(_loc3_.mProgressIndex < _loc3_.mProgressTotal)
                {
                    var _loc1_ = _loc3_.mSprite.mFrameList[_loc3_.mProgressIndex];
                    if(_loc3_.mSprite._Render(_loc1_))
                    {
                        if(false)
                        {
                            return 0.5;
                        }
                        1;
                    }
                    _loc3_.mProgressIndex++;
                }
            }
        }
        for(_loc6_ in CSprite3D.mSpriteList)
        {
            _loc3_ = CSprite3D.mSpriteList[_loc6_];
            var _loc2_ = _loc3_.mSprite;
        }
        CSprite3D.mPreRendering = false;
        return 1;
    };
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.PreRenderAll = function PreRenderAll()
    {
        for(var _loc2_ in CSprite3D.mSpriteList)
        {
            var _loc1_ = CSprite3D.mSpriteList[_loc2_];
        }
        CSprite3D.mPreRendering = true;
    };
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.Exists = function Exists(tID)
    {
        for(var _loc2_ in CSprite3D.mSpriteList)
        {
            var _loc1_ = CSprite3D.mSpriteList[_loc2_];
            if(_loc1_.mID == tID)
            {
                return _loc1_.mSprite;
            }
        }
        return undefined;
    };
    _loc2_._Render = function _Render(tFrame)
    {
        if(tFrame.mRendered == false)
        {
            5845;
            tFrame.mRendered = true;
            var _loc2_ = new scidd.Math.CPointXYZ(0,0,tFrame.mRadians);
            loop4:
            switch(this.mDescription.mType)
            {
                case CSprite3D.mDescType_Flat:
                    this._RenderFrame(tFrame,_loc2_);
                    break;
                case CSprite3D.mDescType_Roll:
                    tFrame.mFrames = new Array();
                    _loc2_.mX = this.mDescription.mRoll.mMin;
                    while(_loc2_.mX <= this.mDescription.mRoll.mMax)
                    {
                        var _loc4_ = new Object();
                        tFrame.mFrames[tFrame.mFrames.length] = _loc4_;
                        this._RenderFrame(_loc4_,_loc2_);
                        _loc2_.mX += this.mDescription.mRoll.mStep;
                    }
                    break;
                case CSprite3D.mDescType_Tilt:
                    tFrame.mFrames = new Array();
                    _loc2_.mY = this.mDescription.mTilt.mMin;
                    while(_loc2_.mY <= this.mDescription.mTilt.mMax)
                    {
                        _loc4_ = new Object();
                        tFrame.mFrames[tFrame.mFrames.length] = _loc4_;
                        this._RenderFrame(_loc4_,_loc2_);
                        _loc2_.mY += this.mDescription.mTilt.mStep;
                    }
                    break;
                case CSprite3D.mDescType_RollAndTilt:
                    tFrame.mFrames = new Array();
                    _loc2_.mX = this.mDescription.mRoll.mMin;
                    while(true)
                    {
                        if(_loc2_.mX > this.mDescription.mRoll.mMax)
                        {
                            break loop4;
                        }
                        var _loc5_ = tFrame.mFrames.length;
                        tFrame.mFrames[_loc5_] = new Array();
                        _loc2_.mY = this.mDescription.mTilt.mMin;
                        while(_loc2_.mY <= this.mDescription.mTilt.mMax)
                        {
                            _loc4_ = new Object();
                            tFrame.mFrames[_loc5_][tFrame.mFrames[_loc5_].length] = _loc4_;
                            this._RenderFrame(_loc4_,_loc2_);
                            _loc2_.mY += this.mDescription.mTilt.mStep;
                        }
                        _loc2_.mX += this.mDescription.mRoll.mStep;
                    }
            }
            return true;
        }
        return false;
    };
    _loc2_._RenderFrame = function _RenderFrame(tFrame, pAngle)
    {
        this.mProjection.Project(this.mMesh3D,pAngle);
        CSprite3D.mcRenderPlane.clear();
        this.mMesh3D.QRender_MCList([CSprite3D.mcRenderPlane],[undefined],CSprite3D.mLight.toCVector3());
        tFrame.mOutline = this._renderToBitmap(CSprite3D.mcRenderPlane);
    };
    _loc2_._renderToBitmap = function _renderToBitmap(mc)
    {
        var _loc2_ = undefined;
        var _loc3_ = undefined;
        var _loc1_ = mc.getBounds(mc);
        _loc3_ = new flash.display.BitmapData(Math.ceil(_loc1_.xMax - _loc1_.xMin),Math.ceil(_loc1_.yMax - _loc1_.yMin),true,0);
        _loc2_ = new flash.geom.Point(_loc1_.xMin,_loc1_.yMin);
        var _loc4_ = new flash.geom.Matrix();
        _loc4_.translate(0 - _loc2_.x,0 - _loc2_.y);
        _loc3_.draw(mc,_loc4_,undefined,"normal",undefined,true);
        return {sBMD:_loc3_,mDisp:_loc2_};
    };
    _loc2_._CLASSID_ = "CSprite3D";
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.zPoint = new flash.geom.Point(0,0);
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mLight = new scidd.Math.CPointXYZ(0,1,0).Normalize(1);
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mGlobalScale = 1;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mCombineSolid = true;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mOutlineSize = 2;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mAngleOffset = 3.141592653589793;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mDescType_Flat = 0;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mDescType_Roll = 1;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mDescType_Tilt = 2;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mDescType_RollAndTilt = 3;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mType_None = 0;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mType_FullRotation = 1;
    _global.CSprite3D = function(tID, tCompileString, pDescription, tType, tTint, tScaleAdjust)
    {
        this.mID = tID;
        this._Position = new scidd.Math.CPointXYZ(0,0,0);
        this._AngleXYZ = new scidd.Math.CPointXYZ(0,0,0);
        if((this.mSpriteMaster = CSprite3D.Exists(this.mID)) == undefined)
        {
            this.mMeshTint = tTint;
            this.mType = tType != undefined ? tType : CSprite3D.mType_None;
            this.mMesh3D = new scidd.Draw.F3D.CMesh3D_FromString(tCompileString).mMesh3D;
            this.mProjection = new CProjection3D_Axis();
            var _loc4_ = 10 * (tScaleAdjust != undefined ? tScaleAdjust : 1) * CSprite3D.mGlobalScale;
            this.mMeshScale = new scidd.Math.CVector3(_loc4_,_loc4_,_loc4_);
            this.mMeshOffset = new scidd.Math.CVector3(0,0,0);
            this.mMesh3D.Scale(this.mMeshScale);
            this.mNumberOfFrames = pDescription.mNumberOfFrames;
            this.mRadianStep = 6.283185307179586 / this.mNumberOfFrames;
            this.mDegreeStep = 360 / this.mNumberOfFrames;
            this.mFrameList = new Array();
            this.mDescription = pDescription;
            if(this.mDescription.mRoll != undefined && this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_RollAndTilt;
            }
            else if(this.mDescription.mRoll != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Roll;
            }
            else if(this.mDescription.mTilt != undefined)
            {
                this.mDescription.mType = CSprite3D.mDescType_Tilt;
            }
            else
            {
                this.mDescription.mType = CSprite3D.mDescType_Flat;
            }
            0;
            0;
            while(0 < this.mNumberOfFrames)
            {
                this.mFrameList[0] = new Object();
                this.mFrameList[0].mRendered = false;
                this.mFrameList[0].mRadians = 0;
                this.mFrameList[0].mIndex = 0;
                1;
                0;
                _loc3_ = 0 + this.mRadianStep;
            }
            CSprite3D.mSpriteList = CSprite3D.mSpriteList != undefined ? CSprite3D.mSpriteList : new Array();
            CSprite3D.mSpriteList[CSprite3D.mSpriteList.length] = {mSprite:this,mID:this.mID,mProgressIndex:0,mProgressTotal:this.__get__mTotalFrames()};
        }
        else
        {
            this.mType = this.mSpriteMaster.mType;
            this.mProjection = this.mSpriteMaster.mProjection;
            this.mMeshTint = this.mSpriteMaster.mMeshTint;
            this.mMesh3D = this.mSpriteMaster.mMesh3D;
            this.mNumberOfFrames = this.mSpriteMaster.mNumberOfFrames;
            this.mRadianStep = this.mSpriteMaster.mRadianStep;
            this.mFrameList = this.mSpriteMaster.mFrameList;
            this.mMeshOffset = this.mSpriteMaster.mMeshOffset;
            this.mMeshScale = this.mSpriteMaster.mMeshScale;
        }
    }.mType_NoRotation = 2;
    §§push(_loc2_.addProperty("mAngle",_loc2_.__get__mAngle,_loc2_.__set__mAngle));
    §§push(_loc2_.addProperty("mBounds",_loc2_.__get__mBounds,0));
    §§push(_loc2_.addProperty("mCollisionShape2D",_loc2_.__get__mCollisionShape2D,0));
    §§push(_loc2_.addProperty("mCollisionShape2DI",_loc2_.__get__mCollisionShape2DI,0));
    §§push(_loc2_.addProperty("mHeight2D",_loc2_.__get__mHeight2D,0));
    §§push(_loc2_.addProperty("mPosition",_loc2_.__get__mPosition,_loc2_.__set__mPosition));
    §§push(_loc2_.addProperty("mRadius2D",_loc2_.__get__mRadius2D,0));
    §§push(_loc2_.addProperty("mRadius2D_D",_loc2_.__get__mRadius2D_D,0));
    §§push(_loc2_.addProperty("mRadius2D_SQR",_loc2_.__get__mRadius2D_SQR,0));
    §§push(_loc2_.addProperty("mRoll",_loc2_.__get__mRoll,_loc2_.__set__mRoll));
    §§push(_loc2_.addProperty("mTilt",_loc2_.__get__mTilt,_loc2_.__set__mTilt));
    §§push(_loc2_.addProperty("mTotalFrames",_loc2_.__get__mTotalFrames,0));
    §§push(_loc2_.addProperty("pRadius2D",_loc2_.__get__pRadius2D,0));
    §§push(ASSetPropFlags(_global.CSprite3D.prototype,null,1));
}
§§pop();
