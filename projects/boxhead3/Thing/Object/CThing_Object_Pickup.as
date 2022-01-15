class Thing.Object.CThing_Object_Pickup extends Thing.Object.CThing_Object
{
    var _CLASSID_ = "CThing_Object_Pickup";
    function CThing_Object_Pickup(tPosition, tAngle, tParent)
    {
        super(tPosition.__get__mCellCentre(),tAngle,tParent);
        if(!Thing.Object.CThing_Object_Pickup.mcDrawObject_Cache)
        {
            Thing.Object.CThing_Object_Pickup.mcDrawObject_Cache = new DrawPrimitive.MovieClip.CDrawPrimitive_MovieClip_Animation("Object.Pickup");
        }
        this.mcDrawObject = Thing.Object.CThing_Object_Pickup.mcDrawObject_Cache.Clone();
        this.Process = this.Process_Init;
        this.mAlpha = 100;
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
        this.mCurrentCell = this.mWorld.mMap.GetCell(this.mPosition.mX,this.mPosition.mY);
        this.Process = this.Process_Normal;
        this.Process();
    }
    function Process_Normal()
    {
        if(this.mCurrentCell.mCollide & World.Map.CMap_Cell.mCollide_Player)
        {
            this.PickedUp();
        }
    }
    function Process_Count()
    {
        if(--this.mReappearCount < 0)
        {
            this.mWorld.mMap.mMapwho.MoveThing(this);
        }
    }
    function Process_DeleteCounter_Init()
    {
        this.mWorld.mMap.mMapwho.MoveThing(this);
        this.mCurrentCell = this.mWorld.mMap.GetCell(this.mPosition.mX,this.mPosition.mY);
        this.Process = this.Process_DeleteCounter;
    }
    function Process_DeleteCounter()
    {
        if(--this.mDeleteCounter < 0)
        {
            this.Delete();
            return undefined;
        }
        if(this.mDeleteCounter < CMain.mFPS)
        {
            this.mAlpha = this.mDeleteCounter / CMain.mFPS * 100;
        }
        if(this.mCurrentCell.mCollide & World.Map.CMap_Cell.mCollide_Player)
        {
            this.PickedUp();
        }
    }
    function PickedUp()
    {
        this.PlaySound(CSound.mSamples.Object_Pickup_wav);
        var _loc2_ = undefined;
        if(_loc2_ = this.mCurrentCell.ContainsClassID("CThing_Creature_Player"))
        {
            _loc2_.RandomPickup();
        }
        if(this.mDeleteOnPickup)
        {
            this.Delete();
            return undefined;
        }
        this.mWorld.mMap.mMapwho.DeleteThing(this);
        this.mReappearCount = CMain.mFPS * 30;
        this.Process = this.Process_Count;
    }
    function SetDeleteCounter(tCount)
    {
        this.mDeleteCounter = tCount;
        this.Process = this.Process_DeleteCounter_Init;
    }
    function Draw()
    {
        Thing.CThing.pDraw.x = this.mPosition.mX * World.Map.CMap_Cell.mSize.x - this.mWorld.mDrawPosition.x;
        Thing.CThing.pDraw.y = (this.mPosition.mY + this.mPosition.mZ * Thing.Math.CThing_Position.mPFactor) * World.Map.CMap_Cell.mSize.y - this.mWorld.mDrawPosition.y;
        this.mcDrawObject.Render(this.mWorld.bmDraw,Thing.CThing.pDraw,1,this.mAlpha);
    }
}
