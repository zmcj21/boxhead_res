class CCity extends MovieClip
{
    var Scroll = 0;
    var _CLASSID_ = "CCity";
    static var zPoint = new flash.geom.Point(0,0);
    static var zMatrix = new flash.geom.Matrix();
    static var dMatrix = new flash.geom.Matrix();
    static var mRetry = false;
    static var mBrightness = 0;
    static var mLevelIndex = "0001";
    static var _RenderScratch = false;
    static var mDrawPosition = new flash.geom.Point(0,0);
    var mAmbienceTicker = 0;
    var mZombieSampleIndex = 0;
    function CCity()
    {
        super();
        CSaveData.QualityActive(true);
        CCity._this = this;
        this.mCollisionList = new Array();
        this.mInitList = new Array();
        this.mPausedToRetry = false;
        this.mPaused = false;
        this.mScreenRect = new flash.geom.Rectangle(0,0,CMain._this.mScreenSize.x,CMain._this.mScreenSize.y);
        this.oScreenRect = this.mScreenRect.clone();
        this.cScreenRect = this.mScreenRect.clone();
        this.mcInitPlane = this.attachMovie("City." + CCity.mLevelIndex + ".Contents","_InitPlane",this.getNextHighestDepth());
        this.mRectangle = new flash.geom.Rectangle(0,0,this.mcInitPlane._Size._width,this.mcInitPlane._Size._height);
        this._visible = false;
        this.mCountInToDraw = 0;
    }
    function set mScrollPosition(a)
    {
        this._ScrollPosition = a;
    }
    function get mScrollPosition()
    {
        return this._ScrollPosition;
    }
    function Dispose()
    {
        CSaveData.QualityActive(false);
        this.mcHUD.removeMovieClip();
        this.mcDraw.removeMovieClip();
    }
    function AddCollideMC(mcCollisionShape)
    {
        var _loc2_ = mcCollisionShape.getBounds(this);
        mcCollisionShape.mRectangle = new flash.geom.Rectangle(_loc2_.xMin,_loc2_.yMin,_loc2_.xMax - _loc2_.xMin,_loc2_.yMax - _loc2_.yMin);
        this.mCollisionList[this.mCollisionList.length] = mcCollisionShape;
        mcCollisionShape._visible = false;
    }
    function AddInitObject(mcInit)
    {
        this.mInitList[this.mInitList.length] = mcInit;
        mcInit._visible = false;
    }
    function Setup()
    {
        var _loc9_ = _root._quality;
        _root._quality = "HIGH";
        this.mMapwho = new CMapwho(this.mRectangle);
        for(var _loc7_ in this.mCollisionList)
        {
            var _loc5_ = this.mCollisionList[_loc7_];
            this.mMapwho.MarkCollision(_loc5_.mRectangle,_loc5_.mType);
        }
        CThing.Renew();
        this.mZombieSpawnPosition = new Array();
        this.mCivilianSpawnPosition = new Array();
        this.mCivilianWaypoints = new Array();
        this.mLevel = new CCity_Level();
        for(_loc7_ in this.mInitList)
        {
            var _loc3_ = this.mInitList[_loc7_];
            switch(_loc3_._CLASSID_)
            {
                case "CCity_InitPosition":
                    var _loc4_ = new scidd.Math.CPointXYZ(_loc3_._x,_loc3_._y,0);
                    if((_loc0_ = _loc3_.mType) !== "zombie.spawn")
                    {
                        if(_loc0_ !== "civilian.spawn")
                        {
                            if(_loc0_ !== "civilian.waypoint.1")
                            {
                                if(_loc0_ !== "civilian.waypoint.2")
                                {
                                    if(_loc0_ !== "civilian.waypoint.3")
                                    {
                                        if(_loc0_ !== "civilian.waypoint.4")
                                        {
                                            if(_loc0_ === "civilian.waypoint.final")
                                            {
                                                this.mCivilianWaypoints[4] = _loc0_ = _loc4_;
                                                this.mCivilianDestinationPosition = _loc0_;
                                            }
                                        }
                                        else
                                        {
                                            this.mCivilianWaypoints[3] = _loc4_;
                                        }
                                    }
                                    else
                                    {
                                        this.mCivilianWaypoints[2] = _loc4_;
                                    }
                                }
                                else
                                {
                                    this.mCivilianWaypoints[1] = _loc4_;
                                }
                            }
                            else
                            {
                                this.mCivilianWaypoints[0] = _loc4_;
                            }
                        }
                        else
                        {
                            this.mCivilianSpawnPosition[this.mCivilianSpawnPosition.length] = {mPosition:_loc4_,mLevel:_loc3_.mLevel};
                        }
                    }
                    else
                    {
                        this.mZombieSpawnPosition[this.mZombieSpawnPosition.length] = {mPosition:_loc4_,mLevel:_loc3_.mLevel};
                    }
                    break;
                case "CCity_StartPosition":
                    this.mStartPosition = new flash.geom.Point(_loc3_._x,_loc3_._y);
                    break;
                case "CCity_CratePickup":
                    CThing.AddThing(new CThing_Crate(new scidd.Math.CPointXYZ(_loc3_._x,_loc3_._y,0),0,undefined,_loc3_.mType));
                    break;
                case "CCity_InitBarrel":
                    CThing.AddThing(new CThing_Object_Barrel(new scidd.Math.CPointXYZ(_loc3_._x,_loc3_._y,0),0,undefined));
            }
        }
        -0.1;
        0.1;
        var _loc8_ = scidd.Draw.CColor.GetColorMatrixFilter(scidd.Draw.CColor.MatrixMulti(scidd.Draw.CColor.ColorMatrix_Brightness(-0.1),scidd.Draw.CColor.ColorMatrix_Contrast(0.1)));
        CAnimation.colorMatrix = _loc8_;
        this.mcDraw = this;
        this.bmFloorPlane = new flash.display.BitmapData(this.mRectangle.width,this.mRectangle.height,false,4278190335);
        this.bmCoverPlane = new flash.display.BitmapData(this.mRectangle.width,this.mRectangle.height,true,0);
        this.bmFloorPlane.draw(this);
        this.bmCoverPlane.draw(this.mcInitPlane._CoverMask);
        this.bmFloorPlane.applyFilter(this.bmFloorPlane,this.bmFloorPlane.rectangle,CCity.zPoint,_loc8_);
        this.bmCoverPlane.applyFilter(this.bmCoverPlane,this.bmCoverPlane.rectangle,CCity.zPoint,_loc8_);
        this.mcScratch = this.createEmptyMovieClip("_DEBUG",this.getNextHighestDepth());
        this.mcScratch._visible = false;
        this.bmRenderPlane = new flash.display.BitmapData(this.mScreenRect.width,this.mScreenRect.height,true,2164195328);
        this.mcDraw.attachBitmap(this.bmRenderPlane,this.mcDraw.getNextHighestDepth(),"always",false);
        this.mShake = new flash.geom.Point(0,0);
        this.mcHUD = this.mcDraw.attachMovie("Hud","_hud",this.mcDraw.getNextHighestDepth());
        CThing.AddThing(new CThing_Player(new scidd.Math.CPointXYZ(this.mStartPosition.x,this.mStartPosition.y,0),0));
        this.mcInitPlane.removeMovieClip();
        this.RenewScratchAttachList();
        CXSIAnimation.bmRenderPlane = CCity._this.bmRenderPlane;
        if(CCity.mRetry == true)
        {
            this.mLevel.RetryLastLevel();
        }
        else
        {
            this.mLevel.NextLevel();
        }
        CHud.StartTimer(300000);
        _root._quality = _loc9_;
    }
    function Process()
    {
        scidd.CProfiler.Timer_Start("PROCESS");
        if(this.mPausedToRetry)
        {
            return undefined;
        }
        if(CMain.mInput.Pressed(CMain.mInput.mKEY_PAUSE) && this._visible)
        {
            this.mPaused = this.mPaused != true ? true : false;
            CHud.Pause(this.mPaused);
        }
        if(this.mPaused)
        {
            return undefined;
        }
        this.mScreenRect.x = Math.round(CThing.mTrackThing.mPosition.mX - this.mScreenRect.width / 2);
        this.mScreenRect.y = Math.round(CThing.mTrackThing.mPosition.mY - this.mScreenRect.height / 2);
        this.mScreenRect.x = scidd.Math.CMath.Range(this.mScreenRect.x,CMapwho.mCellSize.x,this.mRectangle.width - (this.mScreenRect.width + CMapwho.mCellSize.x));
        this.mScreenRect.y = scidd.Math.CMath.Range(this.mScreenRect.y,CMapwho.mCellSize.y,this.mRectangle.height - (this.mScreenRect.height + CMapwho.mCellSize.y));
        this.mScreenSizeHalf = this.mScreenRect.size;
        this.mScreenSizeHalf.x /= 2;
        this.mScreenSizeHalf.y /= 2;
        this.mScreenCentre = this.mScreenRect.topLeft.add(this.mScreenSizeHalf);
        this.mcHUD.Process();
        scidd.CProfiler.Timer_Start("THING.PROCESS");
        CThing.ProcessAll();
        scidd.CProfiler.Timer_Stop("THING.PROCESS");
        this.ProcessAmbience();
        this.Process_Shake();
        this.mLevel.Process();
        scidd.CProfiler.Timer_Stop("PROCESS");
        if(++this.mCountInToDraw == 2)
        {
            CMain.ProcessFrames_Reset();
            this._visible = true;
        }
    }
    function Shake(tShake)
    {
        this.mShake = this.mShake.add(tShake);
    }
    function Process_Shake()
    {
        this.mShake.x = (0 - this.mShake.x) * 0.4;
        this.mShake.y = (0 - this.mShake.y) * 0.4;
        if(Math.abs(this.mShake.x) < 1)
        {
            this.mShake.x = 0;
        }
        if(Math.abs(this.mShake.y) < 1)
        {
            this.mShake.y = 0;
        }
    }
    static function _ProjectZ(z)
    {
        return z * CCity.XSI_Info.PFactor;
    }
    static function _DrawPosition(p_xyz)
    {
        return new flash.geom.Point(p_xyz.mX - CCity.mDrawPosition.x,CCity._ProjectZ(p_xyz.mZ) + p_xyz.mY - CCity.mDrawPosition.y);
    }
    function Draw()
    {
        scidd.CProfiler.Timer_Start("DRAW");
        if(this.mPaused || this.mPausedToRetry)
        {
            return undefined;
        }
        var _loc4_ = CCity.zPoint.subtract(this.mScreenRect.topLeft.add(this.mShake));
        _loc4_.x = Math.round(_loc4_.x);
        _loc4_.y = Math.round(_loc4_.y);
        this.cScreenRect.x = 0 - _loc4_.x;
        this.cScreenRect.y = 0 - _loc4_.y;
        this.bmRenderPlane.copyPixels(this.bmFloorPlane,this.cScreenRect,CCity.zPoint,undefined,undefined,false);
        CCity.mDrawPosition.x = this.mScreenRect.x + this.mShake.x;
        CCity.mDrawPosition.y = this.mScreenRect.y + this.mShake.y;
        CThing_Zombie.mDrawCount = 0;
        CThing_Zombie.mDrawAvgPosition = undefined;
        scidd.CProfiler.Timer_Start("THINGS.DRAW");
        var _loc5_ = this.mScreenRect.clone();
        _loc5_.inflate(CMapwho.mCellSize.x,CMapwho.mCellSize.y);
        this.mMapwho.DrawObjects(_loc5_);
        scidd.CProfiler.Timer_Stop("THINGS.DRAW");
        if(CCity._RenderScratch)
        {
            var _loc3_ = this.mcScratch.getBounds(this.mcScratch);
            var _loc6_ = new flash.geom.Rectangle(_loc3_.xMin,_loc3_.yMin,_loc3_.xMax - _loc3_.xMin,_loc3_.yMax - _loc3_.yMin);
            this.bmRenderPlane.draw(this.mcScratch,CCity.zMatrix,undefined,"normal",_loc6_,false);
            this.mcScratch.clear();
            CCity._RenderScratch = false;
        }
        if(CCity.mBrightness)
        {
            if(_root._quality != "LOW")
            {
                var _loc7_ = scidd.Draw.CColor.GetColorMatrixFilter(scidd.Draw.CColor.ColorMatrix_Brightness(CCity.mBrightness));
                this.bmRenderPlane.applyFilter(this.bmRenderPlane,this.bmRenderPlane.rectangle,CCity.zPoint,_loc7_);
            }
            CCity.mBrightness -= 0.2 * scidd.Math.CMath.Sign(CCity.mBrightness);
            if(Math.abs(CCity.mBrightness) < 0.2)
            {
                CCity.mBrightness = 0;
            }
        }
        scidd.CProfiler.Timer_Start("DRAW.COVER");
        this.bmRenderPlane.copyPixels(this.bmCoverPlane,this.cScreenRect,CCity.zPoint,undefined,undefined,true);
        scidd.CProfiler.Timer_Stop("DRAW.COVER");
        scidd.CProfiler.Timer_Stop("DRAW");
    }
    function DrawLine(p1xyz, p2xyz, tLineSize, tColor, tAlpha)
    {
        var _loc3_ = new flash.geom.Point(p1xyz.mX - CCity.mDrawPosition.x,p1xyz.mY + CCity._ProjectZ(p2xyz.mZ) - CCity.mDrawPosition.y);
        var _loc2_ = new flash.geom.Point(p2xyz.mX - CCity.mDrawPosition.x,p2xyz.mY + CCity._ProjectZ(p2xyz.mZ) - CCity.mDrawPosition.y);
        this.mcScratch.lineStyle(tLineSize,tColor,tAlpha);
        this.mcScratch.moveTo(_loc3_.x,_loc3_.y);
        this.mcScratch.lineTo(_loc2_.x,_loc2_.y);
        CCity._RenderScratch = true;
    }
    function DrawRectangle(pxyz, pSize, tColor, tAlpha)
    {
        var _loc2_ = new flash.geom.Point(pxyz.mX,pxyz.mY);
        var _loc3_ = new flash.geom.Point(_loc2_.x + pSize.mX,_loc2_.y + pSize.mY);
        this.mcScratch.beginFill(tColor,tAlpha != undefined ? tAlpha : 100);
        this.mcScratch.moveTo(_loc2_.x,_loc2_.y);
        this.mcScratch.lineTo(_loc3_.x,_loc2_.y);
        this.mcScratch.lineTo(_loc3_.x,_loc3_.y);
        this.mcScratch.lineTo(_loc2_.x,_loc3_.y);
        this.mcScratch.lineTo(_loc2_.x,_loc2_.y);
        this.mcScratch.endFill();
        CCity._RenderScratch = true;
    }
    function DrawPoint(p_xyz)
    {
        var _loc2_ = new flash.geom.Point(p_xyz.mX - CCity.mDrawPosition.x,CCity._ProjectZ(p_xyz.mZ) + p_xyz.mY - CCity.mDrawPosition.y);
        this.bmRenderPlane.setPixel(_loc2_.x - 1,_loc2_.y - 1,4294901760);
    }
    function DrawMovieClipTF(tThing, mc)
    {
        var _loc6_ = tThing.mPosition;
        var _loc12_ = new flash.geom.Point(_loc6_.mX - CCity.mDrawPosition.x,_loc6_.mY + CCity._ProjectZ(_loc6_.mZ) - CCity.mDrawPosition.y);
        var _loc11_ = tThing.mAngle;
        var _loc14_ = new flash.geom.Matrix();
        _loc14_.rotate(_loc11_);
        var _loc4_ = _loc14_.transformPoint(new flash.geom.Point(1,0));
        var _loc3_ = _loc14_.transformPoint(new flash.geom.Point(0,1));
        _loc4_.y /= 2;
        _loc3_.y /= 2;
        var _loc5_ = new flash.geom.Matrix();
        var _loc7_ = _loc4_.x;
        var _loc8_ = _loc3_.y;
        _loc5_.b = _loc4_.y / _loc7_;
        _loc5_.c = _loc3_.x / _loc8_;
        var _loc9_ = new flash.geom.Matrix();
        _loc9_.scale(_loc7_,_loc8_);
        _loc9_.concat(_loc5_);
        mc._Top.transform.matrix = _loc9_.clone();
        var _loc13_ = _loc11_ + 1.5707963267948966;
        _loc9_ = new flash.geom.Matrix(Math.cos(_loc13_),Math.sin(_loc13_),0,1,0,0);
        _loc9_.scale(1,0.5);
        mc._Front.transform.matrix = _loc9_;
        var _loc10_ = mc.mScale != undefined ? mc.mScale : 1;
        _loc14_ = new flash.geom.Matrix(_loc10_,0,0,_loc10_,_loc12_.x,_loc12_.y);
        this.bmRenderPlane.draw(mc,_loc14_,undefined,"normal",this.bmRenderPlane.rectangle,true);
    }
    function DrawMovieClip(tThing, mc)
    {
        var _loc2_ = tThing.mPosition;
        var _loc5_ = new flash.geom.Point(_loc2_.mX - CCity.mDrawPosition.x,_loc2_.mY + CCity._ProjectZ(_loc2_.mZ) - CCity.mDrawPosition.y);
        if(mc._Shadow != undefined)
        {
            mc._Shadow._y = _loc2_.mZ;
        }
        var _loc4_ = mc.mScale != undefined ? mc.mScale : 1;
        var _loc6_ = new flash.geom.Matrix(_loc4_,0,0,_loc4_,_loc5_.x,_loc5_.y);
        this.bmRenderPlane.draw(mc,_loc6_,undefined,"normal",this.bmRenderPlane.rectangle,true);
    }
    function DrawMovieClip2D(p, mc)
    {
        var _loc2_ = mc.mScale != undefined ? mc.mScale : 1;
        var _loc4_ = new flash.geom.Matrix(_loc2_,0,0,_loc2_,p.x,p.y);
        this.bmRenderPlane.draw(mc,_loc4_,undefined,"normal",this.bmRenderPlane.rectangle,true);
    }
    function DrawAnimation(tThing)
    {
        var _loc3_ = new flash.geom.Point(tThing.mPosition.mX - CCity.mDrawPosition.x,tThing.mPosition.mY + CCity._ProjectZ(tThing.mPosition.mZ) - CCity.mDrawPosition.y);
        CAnimation._this.Render(this.bmRenderPlane,tThing.mAnimationObject,_loc3_,tThing.mAlpha);
    }
    function RenewScratchAttachList()
    {
        for(var _loc2_ in this._ScratchAttachList)
        {
            this._ScratchAttachList[_loc2_].removeMovieClip();
        }
        this._ScratchAttachList = new Object();
    }
    function UpdateMCPosition(pxyz, mc)
    {
        var _loc1_ = new flash.geom.Point(pxyz.mX,pxyz.mY + CCity._ProjectZ(pxyz.mZ));
        mc._x = _loc1_.x;
        mc._y = _loc1_.y;
    }
    function AttachScratchMC(tThing, tLinkID)
    {
        var _loc4_ = new flash.geom.Point(tThing.mPosition.mX,tThing.mPosition.mY + CCity._ProjectZ(tThing.mPosition.mZ));
        var _loc2_ = this._ScratchAttachList[tLinkID];
        if(_loc2_ == undefined)
        {
            _loc2_ = this.mcScratch.attachMovie(tLinkID,"_" + tLinkID,CCity._this.mcScratch.getNextHighestDepth());
            this._ScratchAttachList[tLinkID] = _loc2_;
        }
        _loc2_._x = _loc4_.x;
        _loc2_._y = _loc4_.y;
        return _loc2_;
    }
    static function RenderToBitmap(mc, tScale)
    {
        var _loc6_ = _root._quality;
        _root._quality = "HIGH";
        var _loc3_ = {mFrames:new Array(),mFrameIndex:0,mFrameAmount:0};
        0;
        while(0 < mc._totalframes)
        {
            _loc3_.mFrames[_loc3_.mFrames.length] = CCity._RenderToBitmap(mc,tScale,0);
            1;
        }
        _loc3_.mFrameAmount = _loc3_.mFrames.length;
        _root._quality = _loc6_;
        return _loc3_;
    }
    static function _RenderToBitmap(mc, tScale, tFrameIndex)
    {
        mc.gotoAndPlay(tFrameIndex + 1);
        var _loc2_ = mc.getBounds(mc);
        var _loc1_ = new flash.geom.Rectangle(Math.floor(_loc2_.xMin),Math.floor(_loc2_.yMin),Math.ceil(_loc2_.xMax) - Math.floor(_loc2_.xMin),Math.ceil(_loc2_.yMax) - Math.floor(_loc2_.yMin));
        _loc1_.width *= tScale;
        _loc1_.height *= tScale;
        _loc1_.inflate(1,1);
        var _loc7_ = new flash.display.BitmapData(_loc1_.width,_loc1_.height,true,16711680);
        var _loc5_ = new flash.geom.Point(_loc1_.x * tScale,_loc1_.y * tScale);
        var _loc4_ = new flash.geom.Matrix();
        _loc4_.scale(tScale,tScale);
        _loc4_.translate(0 - _loc5_.x,0 - _loc5_.y);
        _loc7_.draw(mc,_loc4_,undefined,"normal",undefined,false);
        var _loc8_ = {sBMD:_loc7_,mDisp:_loc5_};
        return _loc8_;
    }
    function DrawBitmap(tThing, bitmapObject)
    {
        var _loc2_ = bitmapObject.mFrames[bitmapObject.mFrameIndex];
        var _loc3_ = new flash.geom.Point(tThing.mPosition.mX - CCity.mDrawPosition.x + _loc2_.mDisp.x,tThing.mPosition.mY + CCity._ProjectZ(tThing.mPosition.mZ) - CCity.mDrawPosition.y + _loc2_.mDisp.y);
        this.bmRenderPlane.copyPixels(_loc2_.sBMD,_loc2_.sBMD.rectangle,_loc3_,undefined,undefined,true);
    }
    function DrawBitmap_Alpha(tThing, bitmapObject, tAlpha)
    {
        var _loc2_ = bitmapObject.mFrames[bitmapObject.mFrameIndex];
        var _loc3_ = new flash.geom.Point(tThing.mPosition.mX - CCity.mDrawPosition.x + _loc2_.mDisp.x,tThing.mPosition.mY + CCity._ProjectZ(tThing.mPosition.mZ) - CCity.mDrawPosition.y + _loc2_.mDisp.y);
        var _loc5_ = new flash.geom.Matrix(1,0,0,1,_loc3_.x,_loc3_.y);
        this.bmRenderPlane.draw(_loc2_.sBMD,_loc5_,new flash.geom.ColorTransform(1,1,1,tAlpha / 100,0,0,0,0));
    }
    function CreateBloodSpill(p)
    {
        if(CCity.mBloodSpillList == undefined)
        {
            CCity.mBloodSpillList = new Array();
            1;
            while(true)
            {
                CCity.mBloodSpillList[1 - 1] = _root.attachMovie("Blood.Ground.1","_Blood1",_root.getNextHighestDepth(),{_visible:false});
                2;
            }
        }
        var _loc5_ = new flash.geom.Matrix();
        _loc5_.rotate(random(360) * 3.141592653589793 / 180);
        _loc5_.scale((random(20) + 20) / 100,(random(20) + 20) / 200);
        _loc5_.translate(p.mX,p.mY);
        var _loc7_ = CCity.mBloodSpillList[random(3)];
        var _loc6_ = new flash.geom.ColorTransform(1,1,1,0.5,0,0,0,0);
        this.bmFloorPlane.draw(_loc7_,_loc5_,_loc6_);
    }
    function ProcessAmbience()
    {
        this.mAmbienceTicker++;
        if(!CSound.mCityTraffic1.mPlaying)
        {
            CSound.mCityTraffic1.PlaySound();
        }
        if(CThing_Zombie.mDrawCount == 0)
        {
            for(var _loc2_ in this.mZombieSamples)
            {
                this.mZombieSamples[_loc2_].StopSound();
            }
            delete this.mZombieFrequency;
        }
        else if(CThing_Zombie.mDrawCount == 1)
        {
            this.mZombieChannels = 1;
            this.mZombieFrequency = 150;
            this.mZombieVolume = 30;
        }
        else if(CThing_Zombie.mDrawCount <= 2)
        {
            this.mZombieChannels = 1;
            this.mZombieFrequency = 150;
            this.mZombieVolume = 40;
        }
        else if(CThing_Zombie.mDrawCount <= 4)
        {
            this.mZombieChannels = 2;
            this.mZombieFrequency = 150;
            this.mZombieVolume = 60;
        }
        else if(CThing_Zombie.mDrawCount <= 8)
        {
            this.mZombieChannels = 3;
            this.mZombieFrequency = 60;
            this.mZombieVolume = 80;
        }
        else
        {
            this.mZombieChannels = 3;
            this.mZombieFrequency = 1;
            this.mZombieVolume = 100;
        }
        for(_loc2_ in this.mZombieSamples)
        {
            if(!this.mZombieSamples[_loc2_].mPlaying)
            {
                this.mZombieSamples.splice(Number(_loc2_),1);
            }
        }
        if(this.mAmbienceTicker % this.mZombieFrequency == 0)
        {
            this.mZombieSamples = this.mZombieSamples != undefined ? this.mZombieSamples : new Array();
            if(this.mZombieSamples.length < this.mZombieChannels)
            {
                this.mZombieSampleIndex = (this.mZombieSampleIndex + 1) % CSound.mZombieAmbience.length;
                this.mZombieSamples[this.mZombieSamples.length] = CSound.mZombieAmbience[this.mZombieSampleIndex];
                CThing.G_PlaySound(CSound.mZombieAmbience[this.mZombieSampleIndex],CThing_Zombie.mDrawAvgPosition);
            }
        }
    }
}
