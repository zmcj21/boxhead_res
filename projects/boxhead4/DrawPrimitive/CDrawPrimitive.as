if(!_global.DrawPrimitive)
{
    _global.DrawPrimitive = new Object();
}
§§pop();
if(!_global.DrawPrimitive.CDrawPrimitive)
{
    DrawPrimitive.CDrawPrimitive = 0;
    var _loc2_ = 0.prototype;
    0.InvertAlpha = function(bm)
    {
        var _loc2_ = new Array();
        0;
        while(true)
        {
            _loc2_[0] = -16777216;
            1;
        }
        bm.paletteMap(bm,bm.rectangle,DrawPrimitive.CDrawPrimitive.zPoint,null,null,null,_loc2_);
    };
    _loc2_.toString = function()
    {
        return this._CLASSID_;
    };
    _loc2_.Dispose = 0;
    _loc2_.StartRender = function(tScale)
    {
        DrawPrimitive.CDrawPrimitive.mGlobalScale = tScale != undefined ? tScale : 1;
        this.mBackQuality = this.mBackQuality != undefined ? this.mBackQuality : _root._quality;
        _root._quality = "BEST";
    };
    _loc2_.EndRender = function()
    {
        _root._quality = this.mBackQuality;
        delete this.mBackQuality;
    };
    0.RenderMovieClipAsBitmapObject = function(mc, frameIndex, tFilters)
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
        _loc1_.width *= DrawPrimitive.CDrawPrimitive.mGlobalScale;
        _loc1_.height *= DrawPrimitive.CDrawPrimitive.mGlobalScale;
        _loc1_.inflate(1,1);
        var _loc6_ = new flash.display.BitmapData(Math.ceil(_loc1_.width),Math.ceil(_loc1_.height),true,16711680);
        var _loc5_ = new flash.geom.Point(Math.floor(_loc1_.x * DrawPrimitive.CDrawPrimitive.mGlobalScale),Math.floor(_loc1_.y * DrawPrimitive.CDrawPrimitive.mGlobalScale));
        var _loc4_ = new flash.geom.Matrix();
        _loc4_.scale(DrawPrimitive.CDrawPrimitive.mGlobalScale,DrawPrimitive.CDrawPrimitive.mGlobalScale);
        _loc4_.translate(0 - _loc5_.x,0 - _loc5_.y);
        _loc6_.draw(mc,_loc4_,undefined,"normal",undefined,false);
        var _loc7_ = {sBMD:_loc6_,mDisp:_loc5_,XSI_Info:undefined};
        return _loc7_;
    };
    _loc2_._CLASSID_ = "CDrawPrimitive";
    _loc2_._BASECLASSID_ = "CDrawPrimitive";
    0.mGlobalScale = 1;
    0.mDrawMatrix = new flash.geom.Matrix();
    0.mDrawColorTransform = new flash.geom.ColorTransform(1,1,1,1,0,0,0,0);
    0.dPoint = new flash.geom.Point(0,0);
    0.zPoint = new flash.geom.Point(0,0);
    0.PI360 = 6.283185307179586;
    0.mRadsTo256 = 256 / DrawPrimitive.CDrawPrimitive.PI360;
    0.PI360x100 = 628.3185307179587;
    §§push(ASSetPropFlags(DrawPrimitive.CDrawPrimitive.prototype,null,1));
}
§§pop();
