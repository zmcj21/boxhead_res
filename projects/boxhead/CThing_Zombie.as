class CThing_Zombie extends CThing_Animation
{
    var _CLASSID_ = "CThing_Zombie";
    var _BASECLASSID_ = "CThing_Zombie";
    function CThing_Zombie(tPosition, tAngle, tSpeed)
    {
        super(CMapwho.CentrePosition(tPosition),tAngle,undefined);
        var _loc3_ = new Array();
        _loc3_[_loc3_.length] = {mID:"stand",mAnimation:"zombie_stand"};
        _loc3_[_loc3_.length] = {mID:"shothit_1",mAnimation:"shothit_1"};
        _loc3_[_loc3_.length] = {mID:"shothit_2",mAnimation:"shothit_2"};
        _loc3_[_loc3_.length] = {mID:"attack",mAnimation:"zombie_attack"};
        _loc3_[_loc3_.length] = {mID:"dying",mAnimation:"dying",mDirections:2};
        _loc3_[_loc3_.length] = {mID:"dead",mAnimation:"dead",mDirections:2};
        _loc3_[_loc3_.length] = {mID:"walk",mAnimation:"zombie_walk"};
        this.mAnimationObject = CMain._this.mAnimation.CreateAnimation("ZOMBIE",CAnimation.CreateDefaultDescriptors("Zombie"),8,_loc3_);
        this.SetState(CThing_Animation.mState_Wander_EnterWorld);
        this.mLife = 100;
        this.mMaxLife = 100;
        this.mDamageSound = CSound.mZombieHit[random(CSound.mZombieHit.length)];
        this.mDeathSound = CSound.mZombieHit[random(CSound.mZombieHit.length)];
        this.mSpeed = tSpeed != undefined ? tSpeed : 0.5;
        CThing_Zombie.mSpawnCount++;
        this.mMapColor = 16777215;
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
    function Draw()
    {
        super.Draw();
        if(this.mLife > 0)
        {
            CThing_Zombie.mDrawCount++;
            this.oMapwho.mMapwho.AddFearArea(this.mPosition,5);
        }
        CThing_Zombie.mDrawAvgPosition = CThing_Zombie.mDrawAvgPosition != undefined ? CThing_Zombie.mDrawAvgPosition.Add(this.mPosition).ScaleN(0.5) : this.mPosition;
    }
    function fState_Wander_Goto()
    {
        var _loc2_ = this.oMapwho.mMapwho;
        var _loc4_ = _loc2_.GetCellPosition(this.mPosition.mX,this.mPosition.mY);
        var _loc3_ = this.GetDirectionDelta(this.mDirection);
        var _loc5_ = _loc2_.GetCellPosition(CThing.mTrackThing.mPosition.mX,CThing.mTrackThing.mPosition.mY);
        if(_loc2_.GetCellObjectByField("mZombieEnemy",true,_loc4_.x + _loc3_.x,_loc4_.y + _loc3_.y) != undefined)
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
