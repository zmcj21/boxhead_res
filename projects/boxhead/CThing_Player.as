class CThing_Player extends CThing_Animation
{
    var _CLASSID_ = "CThing_Player";
    var _BASECLASSID_ = "CThing_Player";
    static var mActualValidWeapons = ["pistol","uzi","shotgun","grenade","flamethrower","rocketlauncher"];
    function CThing_Player(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
        this.mDelta = new scidd.Math.CPointXYZ(0,0,0);
        this.mThrustSpeed = 0;
        this.mAngleSpeed = 0;
        this.mStraffSpeed = 0;
        CThing.mTrackThing = this;
        this.mWeapon_List = new Array();
        CThing_Player.mAnimationSets = CThing_Player.mAnimationSets != undefined ? CThing_Player.mAnimationSets : new Array();
        this.AddWeapon("pistol");
        this.SetState(CThing_Animation.mState_PlayerControl);
        this.mLife = 100;
        this.mMaxLife = 100;
        this.mZombieEnemy = true;
        this.mDeathSound = CSound.mCivilianHit[random(CSound.mCivilianHit.length)];
    }
    function NewWeapon(tWeaponName)
    {
        if(this.GetWeaponIndex(tWeaponName) == undefined)
        {
            CThing_Player.mValidWeapons[CThing_Player.mValidWeapons.length] = tWeaponName;
        }
        this.AddAndSelectWeapon(tWeaponName);
    }
    function AddWeapon(tWeaponName)
    {
        var _loc2_ = this.GetWeaponIndex(tWeaponName);
        this.mWeapon_List[_loc2_];
        switch(tWeaponName)
        {
            case "pistol":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_Pistol(this.mPosition,0,this.mID,this);
                break;
            case "uzi":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_UZI(this.mPosition,0,this.mID,this);
                break;
            case "shotgun":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_ShotGun(this.mPosition,0,this.mID,this);
                break;
            case "rocketlauncher":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_RocketLauncher(this.mPosition,0,this.mID,this);
                break;
            case "grenade":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_Grenade(this.mPosition,0,this.mID,this);
                break;
            case "flamethrower":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_FlameThrower(this.mPosition,0,this.mID,this);
        }
        this.SelectWeapon(tWeaponName);
    }
    function AddAndSelectWeapon(tWeaponName)
    {
        this.AddWeapon(tWeaponName);
    }
    function SelectWeapon(tWeaponName)
    {
        if(tWeaponName == undefined)
        {
            return undefined;
        }
        for(var _loc8_ in CThing_Player.mValidWeapons)
        {
            if(tWeaponName == CThing_Player.mValidWeapons[_loc8_])
            {
                if(CThing_Player.mAnimationSets[_loc8_] == undefined && this.mWeapon_List[_loc8_].mAmmo > 0)
                {
                    var _loc2_ = new Array();
                    _loc2_[_loc2_.length] = {mID:"dying",mAnimation:"dying",mDirections:2};
                    _loc2_[_loc2_.length] = {mID:"dead",mAnimation:"dead",mDirections:2};
                    var _loc3_ = CAnimation.CreateDefaultDescriptors("Player");
                    switch(tWeaponName)
                    {
                        case "pistol":
                            _loc3_[CAnimation.mDescriptor_Left_Hand].mModelName = "Pistol";
                            _loc2_[_loc2_.length] = {mID:"stand",mAnimation:"stand_handgun"};
                            _loc2_[_loc2_.length] = {mID:"walk",mAnimation:"walk_handgun"};
                            break;
                        case "uzi":
                            _loc3_[CAnimation.mDescriptor_Left_Hand].mModelName = "UZI";
                            _loc2_[_loc2_.length] = {mID:"stand",mAnimation:"stand_handgun"};
                            _loc2_[_loc2_.length] = {mID:"walk",mAnimation:"walk_handgun"};
                            break;
                        case "shotgun":
                            _loc3_[CAnimation.mDescriptor_Left_Hand].mModelName = "ShotGun";
                            _loc2_[_loc2_.length] = {mID:"stand",mAnimation:"stand_handgun"};
                            _loc2_[_loc2_.length] = {mID:"walk",mAnimation:"walk_handgun"};
                            break;
                        case "rocketlauncher":
                            _loc3_[CAnimation.mDescriptor_Left_Hand].mModelName = "RocketLauncher";
                            _loc2_[_loc2_.length] = {mID:"stand",mAnimation:"stand_rocket"};
                            _loc2_[_loc2_.length] = {mID:"walk",mAnimation:"walk_rocket"};
                            break;
                        case "grenade":
                            _loc2_[_loc2_.length] = {mID:"stand",mAnimation:"stand"};
                            _loc2_[_loc2_.length] = {mID:"walk",mAnimation:"walk"};
                            _loc2_[_loc2_.length] = {mID:"throw",mAnimation:"throw"};
                            break;
                        case "flamethrower":
                            _loc3_[CAnimation.mDescriptor_Left_Hand].mModelName = "FlameThrower";
                            _loc2_[_loc2_.length] = {mID:"stand",mAnimation:"stand_handgun"};
                            _loc2_[_loc2_.length] = {mID:"walk",mAnimation:"walk_handgun"};
                    }
                    CThing_Player.mAnimationSets[_loc8_] = CMain._this.mAnimation.CreateAnimation("PLAYER_" + tWeaponName,_loc3_,8,_loc2_);
                }
                this.mAnimationObject = CThing_Player.mAnimationSets[_loc8_];
                this.mWeapon_Current = this.mWeapon_List[_loc8_];
                this.RenewState();
                CHud.SelectWeapon(tWeaponName,this.mWeapon_Current.mAmmo,this.mWeapon_Current.mTotalAmmo);
                break;
            }
        }
    }
    function GetWeaponIndex(tWeaponName)
    {
        for(var _loc2_ in CThing_Player.mValidWeapons)
        {
            if(tWeaponName == CThing_Player.mValidWeapons[_loc2_])
            {
                return _loc2_;
            }
        }
        return undefined;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process()
    {
        super.Process();
        this.mWeapon_Current.Process();
    }
    function PlayerControl()
    {
        var _loc2_ = new scidd.Math.CPointXYZ(0,0,0);
        if(CMain.mInput.Released(CMain.mInput.mKEY_SELECT1))
        {
            this.SelectWeapon(CThing_Player.mValidWeapons[0]);
        }
        if(CMain.mInput.Released(CMain.mInput.mKEY_SELECT2))
        {
            this.SelectWeapon(CThing_Player.mValidWeapons[1]);
        }
        if(CMain.mInput.Released(CMain.mInput.mKEY_SELECT3))
        {
            this.SelectWeapon(CThing_Player.mValidWeapons[2]);
        }
        if(CMain.mInput.Released(CMain.mInput.mKEY_SELECT4))
        {
            this.SelectWeapon(CThing_Player.mValidWeapons[3]);
        }
        if(CMain.mInput.Released(CMain.mInput.mKEY_SELECT5))
        {
            this.SelectWeapon(CThing_Player.mValidWeapons[4]);
        }
        if(CMain.mInput.Released(CMain.mInput.mKEY_SELECT6))
        {
            this.SelectWeapon(CThing_Player.mValidWeapons[5]);
        }
        if(Key.isDown(37))
        {
            _loc2_.mX -= 1;
        }
        if(Key.isDown(39))
        {
            _loc2_.mX += 1;
        }
        if(Key.isDown(38))
        {
            _loc2_.mY -= 1;
        }
        if(Key.isDown(40))
        {
            _loc2_.mY += 1;
        }
        var _loc9_ = this.mAnim;
        this.mAnim = !(_loc2_.mX || _loc2_.mY) ? "stand" : "walk";
        if(this.mAnim != _loc9_ || _loc9_ == undefined)
        {
            this.SetAnimation(this.mAnim);
        }
        if((Key.isDown(32) && this.mWeapon_Current.mAuto || CMain.mInput.Pressed(CMain.mInput.mKEY_FIRE) && this.mWeapon_Current.mAuto == false) && this.mWeapon_Current.CanFire())
        {
            var _loc5_ = this.mAnimationObject.mCurrent.mShotInfo[this.mWeapon_Current.mShotPosIndex];
            if(_loc5_ == undefined)
            {
                this.mWeapon_Current.Fire(this.mPosition,new scidd.Math.CPointXYZ(0,0,this.mAngle));
                this.mFearAmount = 4;
            }
            else
            {
                var _loc3_ = _loc5_.mPosition;
                this.mWeapon_Current.Fire(this.mPosition.Add(new scidd.Math.CPointXYZ(_loc3_.mX,_loc3_.mY / 2,_loc3_.mZ)),_loc5_.mDirection);
                CThing.AddThing(new CThing_MuzzleFlash(this.mPosition.Add(new scidd.Math.CPointXYZ(_loc3_.mX,_loc3_.mY / 2,_loc3_.mZ)),this.mAnimationObject.mCurrent.mShotInfo[0].mDirection.mZ,this.mID));
                this.mFearAmount = 4;
            }
        }
        if(this.mWeapon_Current.mAmmo == 0)
        {
            this.SelectWeapon("pistol");
        }
        if(!_loc2_.Equals0())
        {
            this.mAngle = this.GetDirectionAngle(this.GetDirectionFromDelta(_loc2_));
        }
        var _loc6_ = this.mPosition.Clone();
        this.Collide(this.mPosition,_loc2_.Normalize(4),CMapwho.mCollide_Solid);
        if(!_loc2_.Equals0())
        {
            if(this.Move(this.mPosition.Add(_loc2_)))
            {
                var _loc4_ = this.oMapwho.mMapwho;
                var _loc7_ = _loc4_.GetCellPosition(_loc6_.mX,_loc6_.mY);
                var _loc8_ = _loc4_.GetCellPosition(this.mPosition.mX,this.mPosition.mY);
                _loc4_.SetCollideFlags(_loc8_.x,_loc8_.y,CMapwho.mCollide_Player);
                _loc4_.ClearCollideFlags(_loc7_.x,_loc7_.y,CMapwho.mCollide_Player);
                CThing_Pickup.CheckForPickup(this);
            }
        }
    }
}
