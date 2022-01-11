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
if(!_global.DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation)
{
    var _loc1_ = null;
    DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation = function(mcLink)
    {
        super();
        if(mcLink)
        {
            this.Buffer(_root.attachMovie(mcLink,"_TEMP" + _root.getNextHighestDepth(),_root.getNextHighestDepth()));
        }
    };
    DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation extends DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip;
    var _loc2_ = DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation = function(mcLink)
    {
        super();
        if(mcLink)
        {
            this.Buffer(_root.attachMovie(mcLink,"_TEMP" + _root.getNextHighestDepth(),_root.getNextHighestDepth()));
        }
    }.prototype;
    _loc2_.Clone = function Clone()
    {
        var _loc2_ = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation();
        _loc2_.bmList = this.bmList;
        _loc2_.bmObject = this.bmList[0];
        _loc2_.mAnimationPosition = 0;
        return _loc2_;
    };
    _loc2_.Animate = function Animate(tSpeed)
    {
        this.mAnimationPosition += tSpeed;
        if(this.mAnimationPosition >= this.bmList.length)
        {
            this.bmObject = this.bmList[this.bmList.length - 1];
            this.mAnimationPosition = this.bmList.length;
            return true;
        }
        this.bmObject = this.bmList[Math.floor(this.mAnimationPosition)];
        return false;
    };
    _loc2_.Animate_Cycle = function Animate_Cycle(tSpeed)
    {
        this.mAnimationPosition = (this.mAnimationPosition + tSpeed) % this.bmList.length;
        this.bmObject = this.bmList[Math.floor(this.mAnimationPosition)];
    };
    _loc2_.Animate_Random = function Animate_Random()
    {
        this.mAnimationPosition = random(this.bmList.length);
        this.bmObject = this.bmList[Math.floor(this.mAnimationPosition)];
    };
    _loc2_.GotoToFrame = function GotoToFrame(tFrameNumber)
    {
        this.mAnimationPosition = (tFrameNumber + this.__get__mFrameAmount() * 10) % this.__get__mFrameAmount();
        this.bmObject = this.bmList[Math.floor(this.mAnimationPosition)];
    };
    _loc2_.__get__mFrameAmount = function get mFrameAmount()
    {
        return this.bmList.length;
    };
    _loc2_.Render = function Render(bmDraw, pos, tScale, tAlpha)
    {
        var _loc4_ = this.bmObject;
        var _loc2_ = _loc4_.mDisp;
        if(tAlpha == 100 && tScale == 1)
        {
            var _loc6_ = _loc4_.sBMD;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation.dPoint.x = pos.x + _loc2_.x;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation.dPoint.y = pos.y + _loc2_.y;
            bmDraw.copyPixels(_loc6_,_loc6_.rectangle,DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation.dPoint,undefined,undefined,true);
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
    _loc2_.Buffer = function Buffer(mc)
    {
        this.StartRender();
        this.bmList = new Array();
        if(mc._Contents)
        {
            1;
            while(1 <= mc._Contents._totalframes)
            {
                mc._Contents.gotoAndStop(1);
                this.bmList[1 - 1] = DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.RenderMovieClipAsBitmapObject(mc,1);
                2;
            }
        }
        else
        {
            1;
            while(1 <= mc._totalframes)
            {
                this.bmList[1 - 1] = DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.RenderMovieClipAsBitmapObject(mc,1);
                2;
            }
        }
        mc.removeMovieClip();
        this.EndRender();
    };
    _loc2_._CLASSID_ = "CDrawPrimitive_MovieClip_Animation";
    DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation = function(mcLink)
    {
        super();
        if(mcLink)
        {
            this.Buffer(_root.attachMovie(mcLink,"_TEMP" + _root.getNextHighestDepth(),_root.getNextHighestDepth()));
        }
    }.dPoint = new flash.geom.Point(0,0);
    §§push(_loc2_.addProperty("mFrameAmount",_loc2_.__get__mFrameAmount,0));
    §§push(ASSetPropFlags(DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation.prototype,null,1));
}
§§pop();
