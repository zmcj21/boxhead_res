class DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_OmniDirectional extends DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip
{
    var _CLASSID_ = "CDrawPrimitive_MovieClip_OmniDirectional";
    static var mGlobalScale = 1;
    static var dPoint = new flash.geom.Point(0,0);
    function CDrawPrimitive_MovieClip_OmniDirectional(mcLink, tDirections)
    {
        super();
        this.Buffer(_root.attachMovie(mcLink,"_TEMP" + _root.getNextHighestDepth(),_root.getNextHighestDepth()),tDirections);
    }
    function Render(bmDraw, pos, tAngle, tAlpha)
    {
        var _loc3_ = this.bmList[Thing.Math.CThing_Angle.mLookup256[this.bmList.length][tAngle.__get__mAngle() * DrawPrimitive.CDrawPrimitive.mRadsTo256 & 255]];
        var _loc2_ = _loc3_.mDisp;
        if(tAlpha >= 100)
        {
            var _loc5_ = _loc3_.sBMD;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_OmniDirectional.dPoint.x = pos.x + _loc2_.x;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_OmniDirectional.dPoint.y = pos.y + _loc2_.y;
            bmDraw.copyPixels(_loc5_,_loc5_.rectangle,DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_OmniDirectional.dPoint,undefined,undefined,true);
        }
        else
        {
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.identity();
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.tx = pos.x + _loc2_.x;
            DrawPrimitive.CDrawPrimitive.mDrawMatrix.ty = pos.y + _loc2_.y;
            DrawPrimitive.CDrawPrimitive.mDrawColorTransform.alphaMultiplier = tAlpha / 100;
            bmDraw.draw(_loc3_.sBMD,DrawPrimitive.CDrawPrimitive.mDrawMatrix,DrawPrimitive.CDrawPrimitive.mDrawColorTransform);
        }
        return true;
    }
    function Buffer(mc, tDirections)
    {
        this.StartRender();
        this.bmList = new Array();
        0;
        while(true)
        {
            this.bmList.push(this._Buffer(mc,0));
            _loc2_ = 0 + 6.283185307179586 / tDirections;
        }
        mc.removeMovieClip();
        this.EndRender();
    }
    function _Buffer(mc, tAngle)
    {
        var _loc3_ = new flash.geom.Matrix();
        _loc3_.rotate(tAngle);
        var _loc2_ = _loc3_.transformPoint(new flash.geom.Point(1,0));
        var _loc1_ = _loc3_.transformPoint(new flash.geom.Point(0,1));
        _loc2_.y /= 2;
        _loc1_.y /= 2;
        var _loc4_ = new flash.geom.Matrix();
        var _loc5_ = _loc2_.x;
        var _loc6_ = _loc1_.y;
        _loc4_.b = _loc2_.y / _loc5_;
        _loc4_.c = _loc1_.x / _loc6_;
        var _loc7_ = new flash.geom.Matrix();
        _loc7_.scale(_loc5_,_loc6_);
        _loc7_.concat(_loc4_);
        mc._Top.transform.matrix = _loc7_.clone();
        var _loc8_ = tAngle + 1.5707963267948966;
        _loc7_ = new flash.geom.Matrix(Math.cos(_loc8_),Math.sin(_loc8_),0,1,0,0);
        _loc7_.scale(1,0.5);
        mc._Front.transform.matrix = _loc7_;
        return DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.RenderMovieClipAsBitmapObject(mc);
    }
}
