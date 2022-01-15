class DrawPrimitive.CDrawPrimitive_Square extends DrawPrimitive.CDrawPrimitive
{
    var _CLASSID_ = "CDrawPrimitive_Square";
    var _BASECLASSID_ = "CDrawPrimitive_Square";
    function CDrawPrimitive_Square()
    {
        super();
    }
    static function Draw(mc, p, s, tColor, tAlpha, tSolid)
    {
        tSolid = tSolid != undefined ? tSolid : false;
        tColor = tColor != undefined ? tColor : 65280;
        tAlpha = tAlpha != undefined ? tAlpha : 100;
        var _loc3_ = p.x;
        var _loc2_ = p.y;
        if(tSolid)
        {
            mc.beginFill(tColor,tAlpha);
        }
        mc.lineStyle(1,tColor != undefined ? tColor : 65280,tAlpha);
        mc.moveTo(_loc3_,_loc2_);
        mc.lineTo(_loc3_ + s,_loc2_);
        mc.lineTo(_loc3_ + s,_loc2_ + s);
        mc.lineTo(_loc3_,_loc2_ + s);
        mc.lineTo(_loc3_,_loc2_);
        if(tSolid)
        {
            mc.endFill();
        }
    }
}
