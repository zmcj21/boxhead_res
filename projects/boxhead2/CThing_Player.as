class CThing_Player extends CThing_Animation
{
    var _CLASSID_ = "CThing_Player";
    var _BASECLASSID_ = "CThing_Player";
    static var mActualValidWeapons = ["pistol","uzi","shotgun","grenade","barrel","rocketlauncher","claymore","railgun"];
    function CThing_Player(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
        this.mDelta = new scidd.Math.CPointXYZ(0,0,0);
        this.mThrustSpeed = 0;
        this.mAngleSpeed = 0;
        this.mStraffSpeed = 0;
        CThing.mTrackThing = this;
        this.mWeapon_List = new Array();
        this.NewWeapon(CThing_Player.mActualValidWeapons[0]);
        this.SelectWeapon(CThing_Player.mActualValidWeapons[0]);
        this.SetState(CThing_Animation.mState_PlayerControl);
        this.mLife = 100;
        this.mMaxLife = 100;
        this.mZombieEnemy = true;
        this.mDeathSound = CSound.mCivilianHit[random(CSound.mCivilianHit.length)];
        if(CThing_Player.mcAmmo == undefined)
        {
            CThing_Player.mcAmmo = _root.attachMovie("Effect.Ammo","_EffectAmmo",_root.getNextHighestDepth(),{_visible:false});
            CThing_Player.mcAmmo.mScale = 1;
        }
    }
    function NewWeapon(tWeaponName)
    {
        if(this.GetWeaponIndex(tWeaponName) == undefined)
        {
            CThing_Player.mValidWeapons[CThing_Player.mValidWeapons.length] = tWeaponName;
        }
        this.AddWeapon(tWeaponName);
    }
    function AddRandomWeapon()
    {
        var _loc2_ = new Array();
        1;
        while(1 < CThing_Player.mValidWeapons.length)
        {
            var _loc3_ = this.mWeapon_List[1];
            if(_loc3_ == undefined || _loc3_.mAmmo <= 0)
            {
                _loc2_[_loc2_.length] = {nameID:_loc3_.nameID,mChance:1};
            }
            else if(_loc3_.mAmmo < _loc3_.mTotalAmmo)
            {
                _loc2_[_loc2_.length] = {nameID:_loc3_.nameID,mChance:1 - _loc3_.mAmmo / _loc3_.mTotalAmmo};
            }
            else if(_loc3_.mAmmo == _loc3_.mTotalAmmo)
            {
                _loc2_[_loc2_.length] = {nameID:_loc3_.nameID,mChance:0.0001};
            }
            2;
        }
        if(_loc2_.length == 0)
        {
            return false;
        }
        0;
        0;
        while(0 < _loc2_.length)
        {
            _loc6_ = 0 + _loc2_[0].mChance;
            _loc2_[0].mChanceIndex = _loc6_;
            1;
        }
        var _loc9_ = Math.random() * _loc6_;
        0;
        while(0 < _loc2_.length)
        {
            if(_loc9_ < _loc2_[0].mChanceIndex)
            {
                var _loc5_ = this.AddWeapon(_loc2_[0].nameID);
                CHud._this.AddMessage("Picked up " + _loc5_.mName,"info");
                return true;
            }
            1;
        }
        return false;
    }
    function AddWeapon(tWeaponName)
    {
        var _loc2_ = this.GetWeaponIndex(tWeaponName);
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
                break;
            case "lightning":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_Lightning(this.mPosition,0,this.mID,this);
                break;
            case "claymore":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_Claymore(this.mPosition,0,this.mID,this);
                break;
            case "barrel":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_Barrel(this.mPosition,0,this.mID,this);
                break;
            case "railgun":
                this.mWeapon_List[_loc2_].Dispose();
                this.mWeapon_List[_loc2_] = new CThing_Railgun(this.mPosition,0,this.mID,this);
        }
        if(_loc2_ >= 0 && _loc2_ <= 9)
        {
        }
        this.mWeapon_List[_loc2_].nameID = tWeaponName;
        if(this.mWeapon_List[_loc2_].nameID == this.mWeapon_Current.nameID)
        {
            this.mWeapon_Current = this.mWeapon_List[_loc2_];
        }
        return this.mWeapon_List[_loc2_];
    }
    function AddAndSelectWeapon(tWeaponName)
    {
        this.AddWeapon(tWeaponName);
        this.SelectWeapon(tWeaponName);
    }
    function NextWeapon()
    {
        var _loc4_ = this.GetWeaponIndex(this.mWeapon_Current.nameID) + 1;
        0;
        while(0 < CThing_Player.mActualValidWeapons.length - 1)
        {
            var _loc2_ = this.mWeapon_List[_loc4_ % CThing_Player.mActualValidWeapons.length];
            if(_loc2_ != undefined && _loc2_.mAmmo > 0)
            {
                this.SelectWeapon(_loc2_.nameID);
                break;
            }
            1;
        }
    }
    function SelectWeapon(tWeaponName)
    {
        if(tWeaponName == undefined)
        {
            return undefined;
        }
        var _loc3_ = this.mWeapon_Current.nameID;
        for(var _loc4_ in CThing_Player.mValidWeapons)
        {
            if(tWeaponName == CThing_Player.mValidWeapons[_loc4_])
            {
                if(this.mWeapon_List[_loc4_].mAmmo > 0)
                {
                    switch(tWeaponName)
                    {
                        case "pistol":
                        default:
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                            break;
                        case "uzi":
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                            break;
                        case "shotgun":
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                            break;
                        case "rocketlauncher":
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                            break;
                        case "grenade":
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                            break;
                        case "flamethrower":
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                            break;
                        case "lightning":
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                            break;
                        case "railgun":
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                            break;
                        case "claymore":
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                            break;
                        case "barrel":
                            this.mAnim = CThing_Animation.mAnimationSets.Player.CreateAnimationObject();
                    }
                    this.mWeapon_Current = this.mWeapon_List[_loc4_];
                    if(_loc3_ != this.mWeapon_Current.nameID)
                    {
                        CHud._this.AddMessage(this.mWeapon_Current.mName + " selected!","info");
                    }
                    this.RenewState();
                    CHud.SelectWeapon(tWeaponName,this.mWeapon_Current.mAmmo,this.mWeapon_Current.mTotalAmmo);
                    break;
                }
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
        if(CMain.mInput.Released(CMain.mInput.mKEY_SELECT7))
        {
            this.SelectWeapon(CThing_Player.mValidWeapons[6]);
        }
        if(CMain.mInput.Released(CMain.mInput.mKEY_SELECT8))
        {
            this.SelectWeapon(CThing_Player.mValidWeapons[7]);
        }
        if(CMain.mInput.Released(CMain.mInput.mKEY_NEXT))
        {
            this.NextWeapon();
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
        var _loc8_ = this.mAnimName;
        this.mAnimName = this.mWeapon_Current.nameID + (!(_loc2_.mX || _loc2_.mY) ? "stand" : "walk");
        if(this.mAnimName != _loc8_ || _loc8_ == undefined)
        {
            this.SetAnimation(this.mAnimName);
        }
        if(Key.isDown(32) && this.mWeapon_Current.mAuto || CMain.mInput.Pressed(CMain.mInput.mKEY_FIRE) && this.mWeapon_Current.mAuto == false)
        {
            var _loc7_ = this.GetWeaponPosition();
            if(this.mWeapon_Current.CanFire(_loc7_))
            {
                this.mWeapon_Current.Fire(_loc7_,new scidd.Math.CPointXYZ(0,0,this.mAngle));
            }
        }
        if(CMain.mInput.Released(CMain.mInput.mKEY_FIRE))
        {
            this.mWeapon_Current.StopFire();
        }
        if(this.mWeapon_Current.mAmmo == 0)
        {
            this.mWeapon_Current.StopFire();
            CHud._this.AddMessage(this.mWeapon_Current.mName + " is out of ammo!","vital");
            this.SelectWeapon("pistol");
        }
        if(!_loc2_.Equals0())
        {
            this.mAngle = this.GetDirectionAngle(this.GetDirectionFromDelta(_loc2_));
        }
        var _loc4_ = this.mPosition.Clone();
        this.Collide(this.mPosition,_loc2_.Normalize(4),CMapwho.mCollide_Solid);
        if(!_loc2_.Equals0())
        {
            if(this.Move(this.mPosition.Add(_loc2_)))
            {
                var _loc3_ = this.oMapwho.mMapwho;
                var _loc5_ = _loc3_.GetCellPosition(_loc4_.mX,_loc4_.mY);
                var _loc6_ = _loc3_.GetCellPosition(this.mPosition.mX,this.mPosition.mY);
                _loc3_.SetCollideFlags(_loc6_.x,_loc6_.y,CMapwho.mCollide_Player);
                _loc3_.ClearCollideFlags(_loc5_.x,_loc5_.y,CMapwho.mCollide_Player);
                CThing_Pickup.CheckForPickup(this);
            }
        }
    }
    function GetWeaponPosition()
    {
        var _loc3_ = this.mAnim.XSI_Info();
        var _loc2_ = _loc3_.XSI_Model_GunPosition_Right.nPosition;
        return _loc2_ != undefined ? this.mPosition.Add(_loc2_) : this.mPosition.Clone();
    }
    function Draw()
    {
        super.Draw();
        CHud._this.DrawAmmo(this.mWeapon_Current.mAmmo,this.mDrawPosition.add(new flash.geom.Point(0,-50)));
    }
    function SetState(nState)
    {
        super.SetState(nState);
        this.mAnimName = "";
    }
    function SMove(rd)
    {
        var _loc9_ = this.mPosition.Add(rd);
        var _loc14_ = this.oMapwho.mMapwho;
        5;
        while(true)
        {
            var _loc11_ = this.GetCellPosition_MIN(_loc9_.Subtract(new scidd.Math.CPointXYZ(this.mRadius,this.mRadius,0)));
            var _loc12_ = this.GetCellPosition_MAX(_loc9_.Add(new scidd.Math.CPointXYZ(this.mRadius,this.mRadius,0)));
            var _loc8_ = _loc11_.y;
            while(_loc8_ <= _loc12_.y)
            {
                var _loc7_ = _loc11_.x;
                while(_loc7_ <= _loc12_.x)
                {
                    var _loc10_ = _loc14_.GetCell(_loc7_,_loc8_);
                    var _loc6_ = _loc10_.mChild;
                    while(_loc6_ != undefined)
                    {
                        var _loc4_ = _loc6_.mObject;
                        if(_loc4_.mPlayerCollide)
                        {
                            var _loc3_ = this.mRadius + _loc4_.mRadius;
                            var _loc2_ = this.mPosition.Subtract(_loc4_.mPosition);
                            var _loc5_ = Math.sqrt(_loc2_.mX * _loc2_.mX + _loc2_.mY * _loc2_.mY);
                            if(_loc5_ < _loc3_)
                            {
                                _loc2_.Normalize(_loc3_ - _loc5_);
                                _loc9_.mX += _loc2_.mX;
                                _loc9_.mY += _loc2_.mY;
                            }
                        }
                        _loc6_ = _loc6_.mChild;
                    }
                    _loc7_ = _loc7_ + 1;
                }
                _loc8_ = _loc8_ + 1;
            }
            4;
        }
        return _loc9_;
    }
    function GetCellPosition_MIN(pxyz)
    {
        return new flash.geom.Point(Math.round(pxyz.mX / CMapwho.mCellSize.x) - 1,Math.round(pxyz.mY / CMapwho.mCellSize.y) - 1);
    }
    function GetCellPosition_MAX(pxyz)
    {
        return new flash.geom.Point(Math.round(pxyz.mX / CMapwho.mCellSize.x),Math.round(pxyz.mY / CMapwho.mCellSize.y));
    }
}
