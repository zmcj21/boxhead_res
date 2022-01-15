class Thing.Effect.CThing_Effect_MuzzleFlash extends Thing.Effect.CThing_Effect
{
    var _CLASSID_ = "CThing_Effect_MuzzleFlash";
    function CThing_Effect_MuzzleFlash(tPosition, tAngle, tDrawObject)
    {
        super(tPosition,tAngle);
        this.mcDrawObject = tDrawObject;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process_Normal()
    {
        this.mWorld.mMap.mMapwho.MoveThing(this);
        this.Delete();
    }
    function Draw()
    {
        this.mcDrawObject.Render(this.mWorld.bmDraw,this.mWorld.GetScreenPosition(this.mPosition),this.mAngle,100);
    }
}
