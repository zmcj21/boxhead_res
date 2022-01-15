class DrawPrimitive.CDrawPrimitive_Circle extends DrawPrimitive.CDrawPrimitive
{
    var _CLASSID_ = "CDrawPrimitive_Circle";
    var _BASECLASSID_ = "CDrawPrimitive_Circle";
    function CDrawPrimitive_Circle()
    {
        super();
    }
    static function Draw(mc, p, r, tColor, tAlpha, tSolid)
    {
        tSolid = tSolid != undefined ? tSolid : false;
        tColor = tColor != undefined ? tColor : 65280;
        tAlpha = tAlpha != undefined ? tAlpha : 100;
        var _loc2_ = p.x;
        var _loc1_ = p.y;
        var _loc6_ = 0.7071067811865475 * r;
        var _loc5_ = 0.41421356237309503 * r;
        if(tSolid)
        {
            mc.beginFill(tColor,tAlpha);
        }
        mc.lineStyle(1,tColor != undefined ? tColor : 65280,tAlpha);
        mc.moveTo(_loc2_ + r,_loc1_);
        mc.curveTo(r + _loc2_,_loc5_ + _loc1_,_loc6_ + _loc2_,_loc6_ + _loc1_);
        mc.curveTo(_loc5_ + _loc2_,r + _loc1_,_loc2_,r + _loc1_);
        mc.curveTo(0 - _loc5_ + _loc2_,r + _loc1_,0 - _loc6_ + _loc2_,_loc6_ + _loc1_);
        mc.curveTo(0 - r + _loc2_,_loc5_ + _loc1_,0 - r + _loc2_,_loc1_);
        mc.curveTo(0 - r + _loc2_,0 - _loc5_ + _loc1_,0 - _loc6_ + _loc2_,0 - _loc6_ + _loc1_);
        mc.curveTo(0 - _loc5_ + _loc2_,0 - r + _loc1_,_loc2_,0 - r + _loc1_);
        mc.curveTo(_loc5_ + _loc2_,0 - r + _loc1_,_loc6_ + _loc2_,0 - _loc6_ + _loc1_);
        mc.curveTo(r + _loc2_,0 - _loc5_ + _loc1_,r + _loc2_,_loc1_);
        if(tSolid)
        {
            mc.endFill();
        }
    }
}
