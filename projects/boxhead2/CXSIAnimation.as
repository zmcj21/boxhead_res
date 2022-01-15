class CXSIAnimation
{
    var _CLASSID_ = "CXSIAnimation";
    static var zPoint = new flash.geom.Point(0,0);
    static var mGlobalScale = 0.35;
    static var PI360 = 6.283185307179586;
    static var PI360x100 = 628.3185307179587;
    function CXSIAnimation()
    {
        CXSIAnimation._this = this;
        this.mAnimationList = new Array();
        this.XSI_Info = new Object();
    }
    function Load(linkID, animID)
    {
        var animOBJ = {mAnimID:animID,mLinkID:linkID,XSI_Info:this.XSI_Info};
        this.mAnimationList[animID] = animOBJ;
        var pMC = _root;
        var d = pMC.getNextHighestDepth();
        var mc = pMC.attachMovie(linkID,linkID + d,d,{_visible:false});
        mc.stop();
        mc.targetClass = animOBJ;
        mc.parentClass = this;
        mc.onEnterFrame = function()
        {
            this.parentClass.Propagate_XSI_Info(this.targetClass,this.XSI_Info);
            this.removeMovieClip();
        };
        animOBJ.mDirections = new Array(mc._totalframes);
        animOBJ.divDir = 1 / (CXSIAnimation.PI360 / animOBJ.mDirections.length);
        animOBJ.roundDir = CXSIAnimation.PI360 / animOBJ.mDirections.length / 2;
        while(i < animOBJ.mDirections.length)
        {
            mc.gotoAndStop(i + 1);
            var mcAnim = eval("mc.XSI_Rotation" + i);
            animOBJ.mDirections[i] = {mFrames:new Array(mcAnim._totalframes)};
            animOBJ.mFrameCount = oDirection.mFrames.length;
            var oDirection = animOBJ.mDirections[i];
            while(f < oDirection.mFrames.length)
            {
                oDirection.mFrames[f] = this._renderToBitmap(mcAnim,f + 1);
                f++;
            }
            i++;
        }
    }
    function Mimic(mimicID, existID)
    {
        this.mAnimationList[mimicID] = this.mAnimationList[existID];
    }
    function Propagate_XSI_Info(animOBJ, XSI_Info)
    {
        animOBJ.XSI_Info.Tilt = XSI_Info.Tilt * 3.141592653589793 / 180;
        animOBJ.XSI_Info.Light = XSI_Info.Light;
        animOBJ.XSI_Info.PFactor = 0 - Math.sin(animOBJ.XSI_Info.Tilt);
        0;
        while(0 < animOBJ.mDirections.length)
        {
            var _loc3_ = animOBJ.mDirections[0];
            0;
            while(0 < _loc3_.mFrames.length)
            {
                _loc3_.mFrames[0].XSI_Info = XSI_Info.Positions[0][0];
                _loc3_.mFrames[0].XSI_Info.Tilt = animOBJ.XSI_Info.Tilt;
                _loc3_.mFrames[0].XSI_Info.PFactor = animOBJ.XSI_Info.PFactor;
                for(var _loc6_ in _loc3_.mFrames[0].XSI_Info)
                {
                    var _loc1_ = _loc3_.mFrames[0].XSI_Info[_loc6_];
                    _loc1_.vPosition = new scidd.Math.CVector3(_loc1_.vPosition.mX,_loc1_.vPosition.mY,_loc1_.vPosition.mZ).ScaleN(CXSIAnimation.mGlobalScale);
                    _loc1_.nPosition = new scidd.Math.CVector3(_loc1_.vPosition.mX,animOBJ.XSI_Info.PFactor * _loc1_.vPosition.mY,0 - _loc1_.vPosition.mZ);
                }
                1;
            }
            1;
        }
    }
    function _renderToBitmap(mc, frameIndex)
    {
        mc.gotoAndStop(frameIndex);
        mc.filters = [new flash.filters.GlowFilter(0,1,4,4,2,1)];
        var _loc2_ = mc.getBounds(mc);
        var _loc1_ = new flash.geom.Rectangle(Math.floor(_loc2_.xMin),Math.floor(_loc2_.yMin),Math.ceil(_loc2_.xMax) - Math.floor(_loc2_.xMin),Math.ceil(_loc2_.yMax) - Math.floor(_loc2_.yMin));
        _loc1_.width *= CXSIAnimation.mGlobalScale;
        _loc1_.height *= CXSIAnimation.mGlobalScale;
        _loc1_.inflate(1,1);
        var _loc6_ = new flash.display.BitmapData(Math.ceil(_loc1_.width),Math.ceil(_loc1_.height),true,16711680);
        var _loc5_ = new flash.geom.Point(Math.floor(_loc1_.x * CXSIAnimation.mGlobalScale),Math.floor(_loc1_.y * CXSIAnimation.mGlobalScale));
        var _loc4_ = new flash.geom.Matrix();
        _loc4_.scale(CXSIAnimation.mGlobalScale,CXSIAnimation.mGlobalScale);
        _loc4_.translate(0 - _loc5_.x,0 - _loc5_.y);
        _loc6_.draw(mc,_loc4_,undefined,"normal",undefined,false);
        var _loc7_ = {sBMD:_loc6_,mDisp:_loc5_,XSI_Info:undefined};
        return _loc7_;
    }
    function CreateAnimationObject()
    {
        var _loc3_ = new Object();
        _loc3_.pClass = this;
        _loc3_.SetAnimation = function(animID, tRotation, tFrameID)
        {
            var _loc2_ = this.pClass.mAnimationList[animID];
            if(this.mAnimation == _loc2_)
            {
                return undefined;
            }
            if(_loc2_ == undefined)
            {
            }
            this.mAnimation = _loc2_;
            this.mCurrentFrameID = tFrameID != undefined ? tFrameID : 0;
            this.Animate(tRotation != undefined ? tRotation : 0,0);
        };
        _loc3_.Animate = function(tRotation, tSpeed)
        {
            var _loc4_ = this.mCurrentFrameID;
            var _loc3_ = this.mCurrentFrameID + tSpeed;
            var _loc2_ = this.mAnimation;
            this.mCurrentFrameID = _loc3_ % _loc2_.mFrameCount;
            this.mCurrentDirection = _loc2_.mDirections[Math.round((tRotation + CXSIAnimation.PI360x100) * _loc2_.divDir) % _loc2_.mDirections.length];
            this.mCurrentFrame = this.mCurrentDirection.mFrames[Math.floor(this.mCurrentFrameID)];
            this.mAnimEnd = _loc3_ >= _loc2_.mFrameCount && _loc3_ > _loc4_;
            return this.mAnimEnd;
        };
        _loc3_.Render = function(pos, tAlpha)
        {
            var _loc3_ = this.mCurrentFrame;
            var _loc4_ = pos.add(_loc3_.mDisp);
            if(tAlpha == undefined || tAlpha == 100 || _root._quality == "LOW")
            {
                CXSIAnimation.bmRenderPlane.copyPixels(_loc3_.sBMD,_loc3_.sBMD.rectangle,_loc4_,undefined,undefined,true);
            }
            else
            {
                var _loc6_ = new flash.geom.Matrix(1,0,0,1,_loc4_.x,_loc4_.y);
                CXSIAnimation.bmRenderPlane.draw(_loc3_.sBMD,_loc6_,new flash.geom.ColorTransform(1,1,1,tAlpha / 100,0,0,0,0));
            }
        };
        _loc3_.XSI_Info = function()
        {
            return this.mCurrentFrame.XSI_Info;
        };
        return _loc3_;
    }
    function Render(animObj, pos, tAlpha)
    {
        var _loc1_ = animObj;
        var _loc2_ = pos.add(_loc1_.mDisp);
        if(tAlpha == undefined)
        {
            CXSIAnimation.bmRenderPlane.copyPixels(_loc1_.sBMD,_loc1_.sBMD.rectangle,_loc2_,undefined,undefined,true);
        }
        else
        {
            var _loc3_ = new flash.geom.Matrix(1,0,0,1,_loc2_.x,_loc2_.y);
            CXSIAnimation.bmRenderPlane.draw(_loc1_.sBMD,_loc3_,new flash.geom.ColorTransform(1,1,1,tAlpha / 100,0,0,0,0));
        }
    }
}
