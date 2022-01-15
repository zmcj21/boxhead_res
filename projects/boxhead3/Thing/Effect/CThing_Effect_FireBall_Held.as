class Thing.Effect.CThing_Effect_FireBall_Held extends Thing.Effect.CThing_Effect
{
    var _CLASSID_ = "CThing_Effect_FireBall_Held";
    function CThing_Effect_FireBall_Held(tPosition, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        if(!Thing.Effect.CThing_Effect_FireBall_Held.mcDrawObject_Cache)
        {
            Thing.Effect.CThing_Effect_FireBall_Held.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation("Effect.FireBall");
        }
        this.mcDrawObject = Thing.Effect.CThing_Effect_FireBall_Held.mcDrawObject_Cache.Clone();
        this.mcDrawObject.Animate_Random();
        this.mDelta = this.mAngle.__get__mDelta().ScaleN(0.5).Invert();
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
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        this.mcDrawObject.Animate_Cycle(1);
    }
    function Draw()
    {
        this.mcDrawObject.Render(this.mWorld.bmDraw,this.mWorld.GetScreenPosition(this.mPosition),1,100);
    }
}
