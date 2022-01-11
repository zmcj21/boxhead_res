class DrawPrimitive.CDrawPrimitive_Line extends DrawPrimitive.CDrawPrimitive
{
    var _CLASSID_ = "CDrawPrimitive_Line";
    var _BASECLASSID_ = "CDrawPrimitive_Line";
    function CDrawPrimitive_Line()
    {
        super();
    }
    static function Draw(mc, p1, p2, tThickness, tColor, tAlpha)
    {
        var _loc5_ = p1.x;
        var _loc3_ = p1.y;
        var _loc4_ = p2.x;
        var _loc1_ = p2.y;
        mc.lineStyle(tThickness,tColor,tAlpha);
        mc.moveTo(_loc5_,_loc3_);
        mc.lineTo(_loc4_,_loc1_);
    }
}
