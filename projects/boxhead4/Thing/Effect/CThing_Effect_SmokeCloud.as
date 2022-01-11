class Thing.Effect.CThing_Effect_SmokeCloud extends Thing.Effect.CThing_Effect
{
    var _CLASSID_ = "CThing_Effect_SmokeCloud";
    function CThing_Effect_SmokeCloud(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        if(!Thing.Effect.CThing_Effect_SmokeCloud.mcDrawObject_Cache)
        {
            Thing.Effect.CThing_Effect_SmokeCloud.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation("Effect.SmokeCloud");
        }
        this.mcDrawObject = Thing.Effect.CThing_Effect_SmokeCloud.mcDrawObject_Cache.Clone();
        this.Process = this.Process_Init;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process_Init()
    {
        this.mWorld.mMap.mMapwho.MoveThing(this);
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        if(this.mcDrawObject.Animate(1))
        {
            this.Delete();
        }
    }
    function Draw()
    {
        this.mcDrawObject.Render(this.mWorld.bmCurrentDraw,this.mWorld.GetScreenPosition(this.mPosition),1,100);
    }
}
