class DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Static extends DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip
{
    var _CLASSID_ = "CDrawPrimitive_MovieClip_Static";
    static var dPoint = new flash.geom.Point(0,0);
    function CDrawPrimitive_MovieClip_Static(mcLink)
    {
        super();
        this.Buffer(_root.attachMovie(mcLink,"_TEMP" + _root.getNextHighestDepth(),_root.getNextHighestDepth()));
    }
    function Render(bmDraw, pos, tAlpha)
    {
        var _loc3_ = this.bmObject;
        var _loc2_ = _loc3_.mDisp;
        if(tAlpha >= 100)
        {
            var _loc5_ = _loc3_.sBMD;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Static.dPoint.x = pos.x + _loc2_.x;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Static.dPoint.y = pos.y + _loc2_.y;
            bmDraw.copyPixels(_loc5_,_loc5_.rectangle,DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Static.dPoint,undefined,undefined,true);
        }
        else
        {
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.tx = pos.x + _loc2_.x;
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.ty = pos.y + _loc2_.y;
            DrawPrimitive.CDrawPrimitive.mDrawColorTransform.alphaMultiplier = tAlpha / 100;
            bmDraw.draw(_loc3_.sBMD,DrawPrimitive.CDrawPrimitive.mDrawMatrix,DrawPrimitive.CDrawPrimitive.mDrawColorTransform);
        }
        return true;
    }
    function Buffer(mc)
    {
        this.StartRender();
        this.bmObject = DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.RenderMovieClipAsBitmapObject(mc);
        mc.removeMovieClip();
        this.EndRender();
    }
}
