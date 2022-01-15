class DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip extends DrawPrimitive.CDrawPrimitive
{
    var _CLASSID_ = "CDrawPrimitive_MovieClip";
    var _BASECLASSID_ = "CDrawPrimitive_MovieClip";
    static var mInflateBMD = 8;
    static var pGlobalScale = new flash.geom.Point(1,1);
    function CDrawPrimitive_MovieClip()
    {
        super();
    }
    static function RenderMovieClipAsBitmapObject(mc, frameIndex, tFilters)
    {
        if(frameIndex)
        {
            mc.gotoAndStop(frameIndex);
        }
        if(tFilters != undefined)
        {
            mc.filters = tFilters;
        }
        var _loc2_ = mc.getBounds(mc);
        var _loc1_ = new flash.geom.Rectangle(Math.floor(_loc2_.xMin),Math.floor(_loc2_.yMin),Math.ceil(_loc2_.xMax) - Math.floor(_loc2_.xMin),Math.ceil(_loc2_.yMax) - Math.floor(_loc2_.yMin));
        _loc1_.width *= DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.x;
        _loc1_.height *= DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.y;
        _loc1_.inflate(DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.mInflateBMD,DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.mInflateBMD);
        var _loc6_ = new flash.display.BitmapData(Math.ceil(_loc1_.width),Math.ceil(_loc1_.height),true,16711680);
        var _loc5_ = new flash.geom.Point(Math.floor(_loc1_.x * DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.x),Math.floor(_loc1_.y * DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.y));
        var _loc4_ = new flash.geom.Matrix();
        _loc4_.scale(DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.x,DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.y);
        _loc4_.translate(0 - _loc5_.x,0 - _loc5_.y);
        _loc6_.draw(mc,_loc4_,undefined,"normal",undefined,false);
        var _loc7_ = {sBMD:_loc6_,mDisp:_loc5_,XSI_Info:undefined};
        return _loc7_;
    }
}
