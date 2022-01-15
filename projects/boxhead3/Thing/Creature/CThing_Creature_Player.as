class Thing.Creature.CThing_Creature_Player extends Thing.Creature.CThing_Creature
{
    var NextWeapon = 0;
    var PrevWeapon = 0;
    var _CLASSID_ = "CThing_Creature_Player";
    function CThing_Creature_Player(tPosition, tPlayerIndex, tAngle, tParent)
    {
        super(tPosition,tAngle,tParent);
        this.mPlayerIndex = tPlayerIndex != undefined ? tPlayerIndex : 0;
        this.mControls = new Object();
        this.mControl_PostFix = this.mPlayerIndex != 0 ? "2" : "";
        this.mControls.LEFT = CMain.mInput["KEY_LEFT" + this.mControl_PostFix];
        this.mControls.RIGHT = CMain.mInput["KEY_RIGHT" + this.mControl_PostFix];
        this.mControls.UP = CMain.mInput["KEY_UP" + this.mControl_PostFix];
        this.mControls.DOWN = CMain.mInput["KEY_DOWN" + this.mControl_PostFix];
        this.mControls.FIRE = CMain.mInput["KEY_FIRE" + this.mControl_PostFix];
        0;
        while(true)
        {
            this.mControls["SELECT0"] = CMain.mInput["KEY_SELECT0" + this.mControl_PostFix];
            1;
        }
        this.mControls.FIRE.Renew();
        if(Thing.Creature.CThing_Creature_Player.mXSI_Collection == undefined)
        {
            Thing.Creature.CThing_Creature_Player.mXSI_Collection = new DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection();
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.StartRender();
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Idle1","idle"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Stand","stand"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Walk","walk"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_HitRear","shothit_1"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_HitFront","shothit_2"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Dying","dying"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Dead","dead"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Handgun_WalkAim","pistolwalk"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Handgun_StandAim","pistolstand"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Shotgun_WalkAim","shotgunwalk"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Shotgun_StandAim","shotgunstand"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_UZI_WalkAim","uziwalk"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_UZI_StandAim","uzistand"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Rocket_WalkAim","rocketwalk"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Rocket_StandAim","rocketstand"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Railgun_WalkAim","railgunwalk"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.AddItem(DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.Load("Player_Railgun_StandAim","railgunstand"));
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("grenadewalk","walk");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("grenadestand","stand");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("barrelwalk","walk");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("barrelstand","stand");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("minewalk","walk");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("minestand","stand");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("claymorewalk","walk");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("claymorestand","stand");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("chargepackwalk","walk");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("chargepackstand","stand");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("fakewallwalk","walk");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.MimicItem("fakewallstand","stand");
            Thing.Creature.CThing_Creature_Player.mXSI_Collection.EndRender();
        }
        this.mXSI_Animation = DrawPrimitive.XSI.CDrawPrimitive_XSI_Animation.CreateAnimationObject(Thing.Creature.CThing_Creature_Player.mXSI_Collection);
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
        super.Process_Init();
        if(_global.mInfinateLife)
        {
            this.Affect_Setup(Thing.Affect.CThing_Affect.mAffect_PlayerLineOfSight);
        }
        else
        {
            this.Affect_Setup(Thing.Affect.CThing_Affect.mAffect_Bullet | Thing.Affect.CThing_Affect.mAffect_Explosion | Thing.Affect.CThing_Affect.mAffect_ZombieAttack | Thing.Affect.CThing_Affect.mAffect_PlayerLineOfSight);
        }
        this.mColor = 1044480;
        this.mSpeed = 0.16;
        this.mMass = 2;
        this.mHeight = 1.5;
        this.mLife = 200;
        this.mMaxLife = 200;
        this.InitWeapons();
        this.SelectWeapon("pistol");
        World.Map.CMap_Cell.Nav_Reset();
        this.mSound = new Object();
        this.mSound.Death = CSound.mSamples.Creature_Player_Scream_1_wav;
        this.mWorld.mUpgrades.Register_Creature_Player(this);
        this.mWorld.mUpgrades.SetDifficulty(CMain.mSaveData.__get__mDifficulty());
        this.SetState("State_PlayerControl");
    }
    function Process_Normal()
    {
        super.Process_Normal();
        this.SetCollideDirection(this.mPosition,World.Map.CMap_Cell.mCollide_Player);
        this.mWorld.TrackThing(this);
    }
    function State_PlayerControl_Init()
    {
        this.mBaseStateID = this.mStateID;
        delete this.mCurrentAnim;
        this.State_PlayerControl();
    }
    function State_PlayerControl()
    {
        if(this.mLife > 0 && this.mLife < this.mMaxLife)
        {
            this.mLife = Math.min(this.mLife + this.mMaxLife / (CMain.mFPS * 30),this.mMaxLife);
        }
        this.mDelta = new Thing.Math.CThing_Position(!this.mControls.LEFT.IsDown() ? (!this.mControls.RIGHT.IsDown() ? 0 : 1) : -1,!this.mControls.UP.IsDown() ? (!this.mControls.DOWN.IsDown() ? 0 : 1) : -1,0).ScaleN(this.mSpeed);
        if(!this.mDelta.Equals0())
        {
            this.mAngle.__set__mDelta(this.mDelta);
        }
        var _loc3_ = undefined;
        switch(this.MoveAndReturn(this.mWorld.mMap.mCollide.PlayerCollide(this)))
        {
            case "cellmoved":
                Thing.CThing.mFlag_CellMoved |= Thing.CThing.mFlag_CellMoved;
            case "moved":
                _loc3_ = this.mWeapon_Current.mNameID + "walk";
                break;
            case "":
                _loc3_ = this.mWeapon_Current.mNameID + "stand";
        }
        World.Map.CMap_Cell.Nav_Restart();
        World.Map.CMap_Cell.Nav_Update(this.mMap.mCells[this.mPosition.mY & 16777215][this.mPosition.mX & 16777215]);
        for(var _loc2_ in this.mWeapons)
        {
            if(this.mControls["SELECT" + this.mWeapons[_loc2_].mKeyID].IsReleased())
            {
                this.mControls.FIRE.Renew();
                this.SelectWeapon(this.mWeapons[_loc2_].mNameID);
                break;
            }
        }
        this.mWeapon_Current.Update(this.mControls.FIRE);
        if(_loc3_ != this.mCurrentAnim)
        {
            this.mXSI_Animation.SetAnimation(this.mCurrentAnim = _loc3_,0);
        }
        else
        {
            this.mXSI_Animation.Animate(this.mSpeed * 2);
        }
    }
    function State_Dead()
    {
        if(this.mStateCount < CMain.mFPS)
        {
            this.mAlpha = this.mStateCount / CMain.mFPS * 100;
            this.mWorld.PlayerDead(this);
        }
        if(--this.mStateCount < 0)
        {
            this.Delete();
        }
    }
    function InitWeapons()
    {
        var _loc2_ = ["pistol","uzi","shotgun","barrel","grenade","fakewall","mine","rocket","chargepack","railgun"];
        var _loc3_ = ["CThing_Weapon_Pistol","CThing_Weapon_UZI","CThing_Weapon_Shotgun","CThing_Weapon_Barrel","CThing_Weapon_Grenade","CThing_Weapon_FakeWall","CThing_Weapon_Mine","CThing_Weapon_Rocket","CThing_Weapon_ChargePack","CThing_Weapon_Railgun"];
        this.mWeapons = new Object();
        for(var _loc9_ in _loc3_)
        {
            this.mWeapons[_loc2_[_loc9_]] = {mNameID:_loc2_[_loc9_],mClassID:_loc3_[_loc9_],mThing:undefined,mActive:false,mKeyID:(Number(_loc9_) + 1) % 10};
        }
        this.NewWeapon(_loc2_[0]);
    }
    function NewWeapon(tWeaponName)
    {
        this.mWeapons[tWeaponName].mActive = true;
        this.AddWeapon(tWeaponName);
    }
    function SelectWeapon(tWeaponName)
    {
        var _loc2_ = this.mWeapons[tWeaponName].mThing;
        if(!_loc2_.WeaponEmpty() && this.mWeapons[tWeaponName].mActive)
        {
            var _loc3_ = this.mWeapon_Current.mNameID;
            this.mWeapon_Current = _loc2_;
            if(_loc3_ != this.mWeapon_Current.mNameID)
            {
                this.mWorld.mHud.AddMessage_Info(this.mWeapon_Current.mName + " selected!");
            }
            this.mWeapon_Current.Reset();
        }
    }
    function RandomPickup()
    {
        var _loc3_ = new Array();
        0;
        for(var _loc7_ in this.mWeapons)
        {
            if(this.mWeapons[_loc7_].mActive && this.mWeapons[_loc7_].mNameID != "pistol")
            {
                var _loc4_ = this.mWeapons[_loc7_];
                var _loc8_ = (1 - _loc4_.mThing.mAmmo / _loc4_.mThing.mTotalAmmo) * 0.75 + 0.25;
                _loc5_ = 0 + _loc8_;
                _loc3_.push({mNameID:_loc4_.mNameID,mChance:_loc8_,mChanceIndex:_loc5_});
            }
        }
        if(this.mLife < this.mMaxLife)
        {
            _loc8_ = (1 - this.mLife / this.mMaxLife) * _loc5_;
            _loc5_ += _loc8_;
            _loc3_.push({mNameID:"life",mChance:_loc8_,mChanceIndex:_loc5_});
        }
        var _loc6_ = Math.random() * _loc5_;
        0;
        while(0 < _loc3_.length)
        {
            if(_loc6_ < _loc3_[0].mChanceIndex)
            {
                if(_loc3_[0].mNameID == "life")
                {
                    this.mWorld.mHud.AddMessage_Info("Life up!");
                    this.mLife = this.mMaxLife;
                }
                else
                {
                    this.mWorld.mHud.AddMessage_Info("Picked up " + this.AddWeapon(_loc3_[0].mNameID).mThing.mName);
                }
                return true;
            }
            1;
        }
        return false;
    }
    function AddWeapon(tWeaponName)
    {
        this.mWeapons[tWeaponName].mThing.Dispose();
        this.mWeapons[tWeaponName].mThing = this.mThing_Collection.Register_Thing(Thing.Weapon.CThing_Weapon.byCLASSID(this.mWeapons[tWeaponName].mClassID,this.mPosition,new Thing.Math.CThing_Angle(0),this));
        if(this.mWeapons[tWeaponName].mThing.mNameID == this.mWeapon_Current.mNameID)
        {
            this.mWeapon_Current = this.mWeapons[tWeaponName].mThing;
        }
        return this.mWeapons[tWeaponName];
    }
    function GetWeaponPosition()
    {
        this.mXSI_Animation.Update_CurrentFrame(this.mAngle);
        var _loc2_ = this.mXSI_Animation.__get__XSI_Info().XSI_Model_GunPosition_Right.nPosition;
        return _loc2_ != undefined ? this.mPosition.Add(new Thing.Math.CThing_Position(_loc2_.mX,_loc2_.mY,_loc2_.mZ)) : this.mPosition.Clone();
    }
    function Draw()
    {
        Thing.CThing.pDraw.x = this.mPosition.mX * World.Map.CMap_Cell.mSize.x - this.mWorld.mDrawPosition.x;
        Thing.CThing.pDraw.y = (this.mPosition.mY + this.mPosition.mZ * Thing.Math.CThing_Position.mPFactor) * World.Map.CMap_Cell.mSize.y - this.mWorld.mDrawPosition.y;
        this.mXSI_Animation.Render(Thing.CThing.pDraw,this.mAngle,this.mAlpha);
        this.mWorld.mHud.DrawPlayer(this,Thing.CThing.pDraw);
    }
}
