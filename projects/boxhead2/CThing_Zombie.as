class CThing_Zombie extends CThing_Animation
{
    var _CLASSID_ = "CThing_Zombie";
    var _BASECLASSID_ = "CThing_Zombie";
    function CThing_Zombie(tPosition, tAngle, tSpeed)
    {
        super(CMapwho.CentrePosition(tPosition),tAngle,undefined);
        this.mAnim = CThing_Animation.mAnimationSets.Zombie.CreateAnimationObject();
        this.SetState(CThing_Animation.mState_Wander_EnterWorld);
        this.mLife = 100;
        this.mMaxLife = 100;
        this.mDamageSound = CSound.mZombieHit[random(CSound.mZombieHit.length)];
        this.mDeathSound = CSound.mZombieHit[random(CSound.mZombieHit.length)];
        this.mSpeed = tSpeed != undefined ? tSpeed : 0.5;
        CThing_Zombie.mSpawnCount++;
        this.mMapColor = 16777215;
        this.mPlayerCollide = true;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
        CThing_Zombie.mSpawnCount--;
    }
    function fState_Wander_Goto()
    {
        var _loc4_ = this.oMapwho.mMapwho;
        var _loc3_ = _loc4_.GetCellPosition(this.mPosition.mX,this.mPosition.mY);
        var _loc2_ = this.GetDirectionDelta(this.mDirection);
        if(_loc4_.GetCellObjectByField("mZombieEnemy",true,_loc3_.x + _loc2_.x,_loc3_.y + _loc2_.y) != undefined)
        {
            this.SetState(CThing_Animation.mState_ZombieAttack);
            return undefined;
        }
        this.fState_Wander_Random(this.DirectionToPosition(this.mGotoPosition));
    }
    function fState_Wander_Goto_Offscreen()
    {
        if(this.mOffScreenCount > 100)
        {
            this.SetState(CThing_Animation.mState_Wander_Offscreen);
            return undefined;
        }
        this.fState_Wander_OffScreen(this.DirectionToPosition(this.mGotoPosition));
    }
}
