if(!_global.DrawPrimitive)
{
    _global.DrawPrimitive = new Object();
}
§§pop();
if(!_global.DrawPrimitive.XSI)
{
    _global.DrawPrimitive.XSI = new Object();
}
§§pop();
if(!_global.DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation)
{
    var _loc1_ = null;
    DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation = function()
    {
        super();
    };
    DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation extends DrawPrimitive.XSI.CDrawPrimitive_XSI;
    var _loc2_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation = function()
    {
        super();
    }.prototype;
    DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation = function()
    {
        super();
    }.CreateAnimationObject = function CreateAnimationObject(tXSI_Collection)
    {
        var _loc1_ = new DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation();
        _loc1_.mCollection = tXSI_Collection;
        return _loc1_;
    };
    _loc2_.SetAnimation = function SetAnimation(animID, tFrameID)
    {
        if(this.mAnimationObject != this.mCollection.mItems[animID].mAnimationObject)
        {
            this.mAnimationObject = this.mCollection.mItems[animID].mAnimationObject;
            this.mFrameCount = this.mAnimationObject.mFrameCount;
            this.mCurrentFrameID = tFrameID != undefined ? tFrameID : 0;
            this.Animate(0);
        }
    };
    _loc2_.SetAnimation_FORCED = function SetAnimation_FORCED(animID, tFrameID)
    {
        this.mAnimationObject = this.mCollection.mItems[animID].mAnimationObject;
        this.mFrameCount = this.mAnimationObject.mFrameCount;
        this.mCurrentFrameID = tFrameID != undefined ? tFrameID : 0;
        this.Animate(0);
    };
    _loc2_.Animate = function Animate(tSpeed)
    {
        if(this.mAnimationObject == undefined)
        {
            return false;
        }
        var _loc3_ = this.mCurrentFrameID;
        var _loc2_ = this.mCurrentFrameID + tSpeed;
        this.mCurrentFrameID = _loc2_ % this.mFrameCount;
        this.mAnimEnd = _loc2_ >= this.mFrameCount && _loc2_ > _loc3_;
        return this.mAnimEnd;
    };
    _loc2_.QAnimate = function QAnimate(tSpeed)
    {
        this.mCurrentFrameID = (this.mCurrentFrameID + tSpeed) % this.mFrameCount;
    };
    _loc2_.Animate_RetObj = function Animate_RetObj(tSpeed)
    {
        if(this.mAnimationObject == undefined)
        {
            return false;
        }
        var _loc4_ = this.mCurrentFrameID;
        var _loc2_ = this.mCurrentFrameID + tSpeed;
        this.mCurrentFrameID = _loc2_ % this.mFrameCount;
        var _loc3_ = {mAnimEnd:_loc2_ >= this.mFrameCount && _loc2_ > _loc4_};
        _loc3_.mNewFrame = (_loc4_ & 16777215) != (_loc2_ & 16777215);
        _loc3_.mFrameIndex = this.mCurrentFrameID & 16777215;
        return _loc3_;
    };
    _loc2_.Update_CurrentFrame = function Update_CurrentFrame(tAngle)
    {
        this.mCurrentDirection = this.mAnimationObject.mDirections[this.mAnimationObject.mLookup256[tAngle.__get__mAngle256()]];
        this.mCurrentFrame = this.mCurrentDirection.mFrames[this.mCurrentFrameID & 16777215];
        this.mPreUpdate = true;
    };
    _loc2_.Render = function Render(pos, tAngle, tAlpha)
    {
        if(this.mPreUpdate == true)
        {
            this.mPreUpdate = false;
        }
        else
        {
            this.mCurrentDirection = this.mAnimationObject.mDirections[this.mAnimationObject.mLookup256[tAngle.__get__mAngle256() & 255]];
            this.mCurrentFrame = this.mCurrentDirection.mFrames[this.mCurrentFrameID & 16777215];
        }
        this._Render(this.mCurrentFrame,pos,tAlpha);
        return true;
    };
    _loc2_._Render = function _Render(oBMD, pos, tAlpha)
    {
        var _loc1_ = oBMD.mDisp;
        var _loc2_ = oBMD.sBMD;
        if(tAlpha >= 100)
        {
            DrawPrimitive.CDrawPrimitive.dPoint.x = pos.x + _loc1_.x;
            DrawPrimitive.CDrawPrimitive.dPoint.y = pos.y + _loc1_.y;
            DrawPrimitive.XSI.CDrawPrimitive_XSI.bmDraw.copyPixels(_loc2_,_loc2_.rectangle,DrawPrimitive.CDrawPrimitive.dPoint,undefined,undefined,true);
        }
        else
        {
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.identity();
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.tx = pos.x + _loc1_.x;
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.ty = pos.y + _loc1_.y;
            DrawPrimitive.CDrawPrimitive.mDrawColorTransform.alphaMultiplier = tAlpha / 100;
            DrawPrimitive.XSI.CDrawPrimitive_XSI.bmDraw.draw(_loc2_,DrawPrimitive.CDrawPrimitive.mDrawMatrix,DrawPrimitive.CDrawPrimitive.mDrawColorTransform);
        }
    };
    _loc2_.__get__XSI_Info = function get XSI_Info()
    {
        return this.mCurrentFrame.XSI_Info;
    };
    DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation = function()
    {
        super();
    }.Load = function Load(linkID, tRetrieveID)
    {
        var _loc1_ = new DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation(tRetrieveID);
        _loc1_.mID = tRetrieveID;
        if(DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.LoadAnimation(_loc1_,linkID,tRetrieveID))
        {
        }
        return _loc1_;
    };
    _loc2_._Load = function _Load(linkID)
    {
        var pMC = _root;
        var d = pMC.getNextHighestDepth();
        var mc = pMC.attachMovie(linkID,linkID + d,d,{_visible:false});
        mc.stop();
        if(mc == undefined)
        {
            return undefined;
        }
        mc.parentClass = this;
        mc.onEnterFrame = function()
        {
            this.parentClass.Propagate_XSI_Info(this.XSI_Info);
            this.removeMovieClip();
        };
        this.Init_AnimationObject(mc._totalframes);
        var i = 0;
        while(i < this.mAnimationObject.mDirections.length)
        {
            mc.gotoAndStop(i + 1);
            var mcAnim = eval("mc.XSI_Rotation" + i);
            this.mAnimationObject.mDirections[i] = {mFrames:new Array(mcAnim._totalframes)};
            var oDirection = this.mAnimationObject.mDirections[i];
            this.mAnimationObject.mFrameCount = oDirection.mFrames.length;
            var f = 0;
            while(f < oDirection.mFrames.length)
            {
                oDirection.mFrames[f] = this.RenderToBitmap(mcAnim,f + 1);
                f++;
            }
            i++;
        }
    };
    _loc2_.Init_AnimationObject = function Init_AnimationObject(nDirections)
    {
        if(!Thing.Math.CThing_Angle.mLookup256)
        {
            Thing.Math.CThing_Angle.Create_LookupTables();
        }
        this.mXSI_Info = new Object();
        this.mAnimationObject = {XSI_Info:this.mXSI_Info};
        this.mAnimationObject.mDirections = new Array(nDirections);
        this.mAnimationObject.mDirectionAmount = nDirections;
        this.mAnimationObject.mLookup256 = Thing.Math.CThing_Angle.mLookup256[nDirections];
        this.mAnimationObject.divDir = 1 / (DrawPrimitive.CDrawPrimitive.PI360 / nDirections);
        this.mAnimationObject.roundDir = DrawPrimitive.CDrawPrimitive.PI360 / nDirections / 2;
        return this.mAnimationObject;
    };
    _loc2_.Propagate_XSI_Info = function Propagate_XSI_Info(XSI_Info)
    {
        this.mAnimationObject.XSI_Info.Tilt = XSI_Info.Tilt * 3.141592653589793 / 180;
        this.mAnimationObject.XSI_Info.Light = XSI_Info.Light;
        this.mAnimationObject.XSI_Info.PFactor = 0 - Math.sin(this.mAnimationObject.XSI_Info.Tilt);
        0;
        while(0 < this.mAnimationObject.mDirections.length)
        {
            var _loc4_ = this.mAnimationObject.mDirections[0];
            0;
            while(0 < _loc4_.mFrames.length)
            {
                _loc4_.mFrames[0].XSI_Info = XSI_Info.Positions[0][0];
                _loc4_.mFrames[0].XSI_Info.Tilt = this.mAnimationObject.XSI_Info.Tilt;
                _loc4_.mFrames[0].XSI_Info.PFactor = this.mAnimationObject.XSI_Info.PFactor;
                for(var _loc6_ in _loc4_.mFrames[0].XSI_Info)
                {
                    var _loc2_ = _loc4_.mFrames[0].XSI_Info[_loc6_];
                    _loc2_.vPosition = new Thing.Math.CThing_Position(_loc2_.vPosition.mX,_loc2_.vPosition.mY,_loc2_.vPosition.mZ).ScaleN(DrawPrimitive.XSI.CDrawPrimitive_XSI.mGlobalScale);
                    _loc2_.nPosition = new Thing.Math.CThing_Position(_loc2_.vPosition.mX,this.mAnimationObject.XSI_Info.PFactor * _loc2_.vPosition.mY,0 - _loc2_.vPosition.mZ).ScaleN(1 / World.Map.CMap_Cell.mCellSize);
                }
                1;
            }
            1;
        }
        Thing.Math.CThing_Position.mPFactor = this.mAnimationObject.XSI_Info.PFactor;
    };
    _loc2_.RenderToBitmap = function RenderToBitmap(mc, frameIndex, tBlendMode)
    {
        var _loc2_ = DrawPrimitive.XSI.CDrawPrimitive_XSI.mGlobalScale;
        if(frameIndex != undefined && frameIndex != 1)
        {
            mc.gotoAndStop(frameIndex);
        }
        var _loc3_ = mc.getBounds(mc);
        var _loc1_ = new flash.geom.Rectangle(Math.floor(_loc3_.xMin),Math.floor(_loc3_.yMin),Math.ceil(_loc3_.xMax) - Math.floor(_loc3_.xMin),Math.ceil(_loc3_.yMax) - Math.floor(_loc3_.yMin));
        _loc1_.width *= _loc2_;
        _loc1_.height *= _loc2_;
        _loc1_.inflate(2,2);
        var _loc4_ = new flash.display.BitmapData(Math.ceil(_loc1_.width),Math.ceil(_loc1_.height),true,16711680);
        var _loc6_ = new flash.geom.Point(Math.floor(_loc1_.x * _loc2_),Math.floor(_loc1_.y * _loc2_));
        var _loc5_ = new flash.geom.Matrix();
        _loc5_.scale(_loc2_,_loc2_);
        _loc5_.translate(0 - _loc6_.x,0 - _loc6_.y);
        _loc4_.draw(mc,_loc5_);
        _loc4_.applyFilter(_loc4_,_loc4_.rectangle,new flash.geom.Point(0,0),new flash.filters.GlowFilter(0,1,4,4,2,1));
        var _loc9_ = {sBMD:_loc4_,mDisp:_loc6_,XSI_Info:undefined};
        return _loc9_;
    };
    _loc2_._CLASSID_ = "CDrawPrimitive_XSI_Animation";
    DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation = function()
    {
        super();
    }.mReturnFlag_EndOfAnimation = 1;
    DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation = function()
    {
        super();
    }.mReturnFlag_NewFrame = 2;
    §§push(_loc2_.addProperty("XSI_Info",_loc2_.__get__XSI_Info,0));
    §§push(ASSetPropFlags(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.prototype,null,1));
}
§§pop();
