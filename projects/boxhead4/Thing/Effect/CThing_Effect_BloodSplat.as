class Thing.Effect.CThing_Effect_BloodSplat extends Thing.Effect.CThing_Effect
{
    var _CLASSID_ = "CThing_Effect_BloodSplat";
    function CThing_Effect_BloodSplat(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.Process = this.Process_Normal;
        if(!Thing.Effect.CThing_Effect_BloodSplat.mcDrawObject_Cache)
        {
            Thing.Effect.CThing_Effect_BloodSplat.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Directional("Effect.Explosion");
        }
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
}
