class CThing_Civilian extends CThing_Animation
{
    var _CLASSID_ = "CThing_Civilian";
    var _BASECLASSID_ = "CThing_Civilian";
    static var mCloseToPlayer = 3 * CMapwho.mCellSize.x;
    function CThing_Civilian(tPosition, tAngle, tID)
    {
        super(CMapwho.CentrePosition(tPosition),tAngle,tID);
        this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
        this.SetState(CThing_Animation.mState_Wander_EnterWorld);
        this.mLife = 100;
        this.mMaxLife = 100;
        this.mDeathSound = CSound.mCivilianHit[random(CSound.mCivilianHit.length)];
        CThing_Civilian.mSpawnCount++;
        this.mMapColor = 1616589;
        this.mZombieEnemy = true;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
        CThing_Civilian.mSpawnCount--;
    }
    function fState_Wander_Goto()
    {
        this.mSpeed = this.mPosition.QDistance2D(CThing.mTrackThing.mPosition) >= CThing_Civilian.mCloseToPlayer ? 3 : 2;
        if(this.fState_Wander_Angle())
        {
            return undefined;
        }
        if(this.mPosition.QDistance2D(CCity._this.mCivilianDestinationPosition) < 12 * CMapwho.mCellSize.x)
        {
            if(this.mState_Base != CThing_Animation.mState_GotoFinalPosition)
            {
                this.mGotoPosition = CCity._this.mCivilianDestinationPosition;
                this.SetState(CThing_Animation.mState_GotoFinalPosition);
            }
            return undefined;
        }
        this.fState_Wander_Random(this.DirectionToPosition(this.mGotoPosition));
    }
    function Draw()
    {
        super.Draw();
    }
}
