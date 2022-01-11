class Thing.Effect.CThing_Effect_SmartBomb extends Thing.Effect.CThing_Effect
{
    var Draw = 0;
    var _CLASSID_ = "CThing_Effect_SmartBomb";
    function CThing_Effect_SmartBomb(tPosition, tAngle, tParent, tLife)
    {
        super(tPosition,tAngle,tParent);
        this.mLife = tLife != undefined ? tLife : 10;
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
        this.Delete();
    }
}
