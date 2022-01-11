if(!_global.DrawPrimitive)
{
    _global.DrawPrimitive = new Object();
}
§§pop();
if(!_global.DrawPrimitive.MovieClip)
{
    _global.DrawPrimitive.MovieClip = new Object();
}
§§pop();
if(!_global.DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional)
{
    var _loc1_ = null;
    DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional = function(mcLink, tDirections)
    {
        super();
        if(mcLink)
        {
            var _loc4_ = _root.attachMovie(mcLink,"_TEMP" + _root.getNextHighestDepth(),_root.getNextHighestDepth());
            this.Buffer(_loc4_,tDirections);
        }
    };
    DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional extends DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip;
    var _loc2_ = DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional = function(mcLink, tDirections)
    {
        super();
        if(mcLink)
        {
            var _loc4_ = _root.attachMovie(mcLink,"_TEMP" + _root.getNextHighestDepth(),_root.getNextHighestDepth());
            this.Buffer(_loc4_,tDirections);
        }
    }.prototype;
    _loc2_.Clone = function Clone()
    {
        var _loc2_ = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional();
        _loc2_.bmList = this.bmList;
        _loc2_.mAnimationPosition = 0;
        return _loc2_;
    };
    _loc2_.Animate = function Animate(tSpeed)
    {
        this.mAnimationPosition += tSpeed;
        if(this.mAnimationPosition >= this.__get__mFrameAmount())
        {
            this.mAnimationPosition = this.__get__mFrameAmount() - 1;
            return true;
        }
        return false;
    };
    _loc2_.Animate_Cycle = function Animate_Cycle(tSpeed)
    {
        this.mAnimationPosition = (this.mAnimationPosition + tSpeed) % this.__get__mFrameAmount();
    };
    _loc2_.Animate_Random = function Animate_Random()
    {
        this.mAnimationPosition = random(this.__get__mFrameAmount());
    };
    _loc2_.GotoToFrame = function GotoToFrame(tFrameNumber)
    {
        this.mAnimationPosition = (tFrameNumber + this.__get__mFrameAmount() * 10) % this.__get__mFrameAmount();
    };
    _loc2_.__get__mFrameAmount = function get mFrameAmount()
    {
        return this.bmList[0].length;
    };
    _loc2_.Render = function Render(bmDraw, pos, tAngle, tScale, tAlpha)
    {
        var _loc4_ = this.bmList[tAngle.ToDirectionN(this.__get__mFrameAmount())][Math.floor(this.mAnimationPosition)];
        var _loc2_ = _loc4_.mDisp;
        if(tAlpha == 100 && tScale == 1)
        {
            var _loc6_ = _loc4_.sBMD;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint.x = pos.x + _loc2_.x;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint.y = pos.y + _loc2_.y;
            bmDraw.copyPixels(_loc6_,_loc6_.rectangle,DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint,undefined,undefined,true);
        }
        else
        {
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.identity();
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.a = tScale;
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.d = tScale;
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.tx = pos.x + _loc2_.x * tScale;
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.ty = pos.y + _loc2_.y * tScale;
            DrawPrimitive.CDrawPrimitive.mDrawColorTransform.alphaMultiplier = tAlpha / 100;
            bmDraw.draw(_loc4_.sBMD,DrawPrimitive.CDrawPrimitive.mDrawMatrix,DrawPrimitive.CDrawPrimitive.mDrawColorTransform);
        }
        return true;
    };
    _loc2_.QRender = function QRender(bmDraw, pos, dir)
    {
        var _loc3_ = this.bmList[dir][Math.floor(this.mAnimationPosition)];
        var _loc2_ = _loc3_.mDisp;
        var _loc4_ = _loc3_.sBMD;
        DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint.x = pos.x + _loc2_.x;
        DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint.y = pos.y + _loc2_.y;
        bmDraw.copyPixels(_loc4_,_loc4_.rectangle,DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint,undefined,undefined,true);
    };
    _loc2_.QRender_Mask = function QRender_Mask(bmDraw, pos, dir, tMask)
    {
        var _loc3_ = this.bmList[dir][Math.floor(this.mAnimationPosition)];
        var _loc2_ = _loc3_.mDisp;
        var _loc4_ = _loc3_.sBMD;
        DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint.x = pos.x + _loc2_.x;
        DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint.y = pos.y + _loc2_.y;
        bmDraw.copyPixels(_loc4_,_loc4_.rectangle,DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint,tMask,DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.dPoint,true);
    };
    _loc2_.Buffer = function Buffer(mc, tDirections)
    {
        this.bmList = new Array();
        if(tDirections != undefined)
        {
            this.StartRender();
            0;
            while(0 < tDirections)
            {
                this.bmList[0] = new Array();
                if(mc._Contents)
                {
                    mc._Contents._rotation = 0 / tDirections;
                    1;
                    while(1 <= mc._Contents._totalframes)
                    {
                        mc._Contents.gotoAndStop(1);
                        this.bmList[0][1 - 1] = DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.RenderMovieClipAsBitmapObject(mc);
                        2;
                    }
                }
                else
                {
                    mc._rotation = 0 / tDirections;
                    1;
                    while(1 <= mc._totalframes)
                    {
                        this.bmList[0][1 - 1] = DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.RenderMovieClipAsBitmapObject(mc,1);
                        2;
                    }
                }
                1;
            }
            this.EndRender();
        }
        mc.removeMovieClip();
        DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.x = 1;
        DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.y = 1;
    };
    _loc2_._CLASSID_ = "CDrawPrimitive_MovieClip_Directional";
    DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional = function(mcLink, tDirections)
    {
        super();
        if(mcLink)
        {
            var _loc4_ = _root.attachMovie(mcLink,"_TEMP" + _root.getNextHighestDepth(),_root.getNextHighestDepth());
            this.Buffer(_loc4_,tDirections);
        }
    }.dPoint = new flash.geom.Point(0,0);
    §§push(_loc2_.addProperty("mFrameAmount",_loc2_.__get__mFrameAmount,0));
    §§push(ASSetPropFlags(DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional.prototype,null,1));
}
§§pop();
