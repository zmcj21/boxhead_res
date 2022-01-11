class World.Map.CMap_Decal
{
    var Dispose = 0;
    var _CLASSID_ = "CMap_Decal";
    var _BASECLASSID_ = "CMap_Decal";
    static var dPoint = new flash.geom.Point();
    function CMap_Decal(tMap)
    {
        this.mMap = tMap;
        this.mWorld = this.mMap.mWorld;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Draw_BloodSplat(p, tAmount)
    {
        if(!World.Map.CMap_Decal.bmBloodSplat)
        {
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.x = 1;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.y = 0.6;
            World.Map.CMap_Decal.bmBloodSplat = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional("Effect.BloodSplat",3);
        }
        var _loc2_ = tAmount != undefined ? tAmount : 1;
        while(_loc2_)
        {
            _loc2_ = _loc2_ - 1;
        }
        World.Map.CMap_Decal.bmBloodSplat.Animate_Random();
        World.Map.CMap_Decal.dPoint.x = (p.mX + (Math.random() * 0.5 - 0.25)) * World.Map.CMap_Cell.mSize.x;
        World.Map.CMap_Decal.dPoint.y = (p.mY + (Math.random() * 0.5 - 0.25)) * World.Map.CMap_Cell.mSize.y;
        World.Map.CMap_Decal.bmBloodSplat.QRender_Mask(this.mWorld.bmFloor,World.Map.CMap_Decal.dPoint,random(3),this.mWorld.bmDecalMask);
    }
    function Draw_ScorchMark(p)
    {
        if(!World.Map.CMap_Decal.bmScorchMark)
        {
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.x = 1;
            DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip.pGlobalScale.y = 0.6;
            World.Map.CMap_Decal.bmScorchMark = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional("Effect.ScorchMark",3);
        }
        World.Map.CMap_Decal.bmScorchMark.Animate_Random();
        World.Map.CMap_Decal.dPoint.x = p.mX * World.Map.CMap_Cell.mSize.x;
        World.Map.CMap_Decal.dPoint.y = p.mY * World.Map.CMap_Cell.mSize.y;
        World.Map.CMap_Decal.bmScorchMark.QRender_Mask(this.mWorld.bmFloor,World.Map.CMap_Decal.dPoint,random(3),this.mWorld.bmDecalMask);
    }
}
