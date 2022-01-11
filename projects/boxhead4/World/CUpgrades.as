if(!_global.World)
{
    _global.World = new Object();
}
§§pop();
if(!_global.World.CUpgrades)
{
    var _loc1_ = null;
    World.CUpgrades = function(tWorld)
    {
        super();
        this.mWorld = tWorld;
        this.mIDCount = 0;
        this.mTick = 0;
        this.__set__mTotalPlayerCount(0);
        this.InitLists();
    };
    World.CUpgrades extends MovieClip;
    var _loc2_ = World.CUpgrades = function(tWorld)
    {
        super();
        this.mWorld = tWorld;
        this.mIDCount = 0;
        this.mTick = 0;
        this.__set__mTotalPlayerCount(0);
        this.InitLists();
    }.prototype;
    _loc2_.toString = function toString()
    {
        return this._CLASSID_;
    };
    _loc2_.Dispose = 0;
    _loc2_.Process = function Process()
    {
        if(World.CWorld.mGameMode == "DeathMatch")
        {
            return undefined;
        }
        this.mTick++;
        var _loc4_ = this.mWorld.mThing_Collection.mThingCounters;
        _loc4_ = !_loc4_.CThing_Creature_Devil && !_loc4_.CThing_Creature_Zombie;
        var _loc5_ = !this.Level.Devil_Count ? 0 : this.Level.Devil_Count;
        var _loc6_ = this.Level.Zombie_Count;
        if(_loc6_ <= 0 && _loc5_ <= 0 && _loc4_)
        {
            this.__set__mLevel(this.__get__mLevel() + 1);
            CSound.mSamples.Click.PlaySound();
        }
        else
        {
            if(this.Level.mZombieCount < Math.min(this.Level.Zombie_Count,_root._quality != "LOW" ? 60 : 40))
            {
                if(this.Level.mSpawnCount_Zombie-- <= 0)
                {
                    if(this.mWorld.Spawn_Zombie())
                    {
                        this.Level.mSpawnCount_Zombie = this.Level.Zombie_SpawnRate;
                    }
                }
            }
            if(this.Level.mDevilCount < this.Level.Devil_Count)
            {
                if((this.Level.mSpawnCount_Devil -= this.Level.Zombie_Count != 0 ? 1 : 10) <= 0)
                {
                    if(this.mWorld.Spawn_Devil())
                    {
                        this.Level.mSpawnCount_Devil = this.Level.Devil_SpawnRate;
                    }
                }
            }
        }
        if(_global.mCheatsActive || _global.mDebug)
        {
        }
        if(this.mMultipleKillsTick-- < 0)
        {
            this.__set__mMultipleKill(0);
        }
        if(this.mMultiplierTick-- < 0)
        {
            this.__set__mMultiplier(this.__get__mMultiplier() - 1);
        }
    };
    _loc2_.SetDifficulty = function SetDifficulty(tDifficulty)
    {
        1;
        1;
        if(World.CWorld.mGameMode == "DeathMatch")
        {
            200;
        }
        else
        {
            switch(tDifficulty)
            {
                case 0:
                    1;
                    1;
                    break;
                case 1:
                    10;
                    10;
                    break;
                case 2:
                    20;
                    30;
                    break;
                case 3:
                    35;
                    50;
            }
        }
        this.mWorld.mHud.mSilentMessages = true;
        34;
        while(true)
        {
            this.__set__mLevel(this.__get__mLevel() + 1);
            33;
        }
        49;
        while(true)
        {
            this.__set__mMultiplier(this.__get__mMultiplier() + 1);
            48;
        }
        this.mWorld.mHud.mSilentMessages = false;
    };
    _loc2_.AddUpgrade = function AddUpgrade(tName, tClassID, tProp, tValue)
    {
        var _loc0_ = null;
        var _loc5_ = this[tClassID] = !this[tClassID] ? new Object() : this[tClassID];
        _loc5_[tProp] = tValue;
        _loc5_.IDCount = this.mIDCount++;
        if(tValue != true)
        {
            var _loc2_ = this.mWorld.mThing_Collection.mPlayerThings;
            for(var _loc4_ in _loc2_)
            {
                _loc2_[_loc4_].NewWeapon(tValue);
            }
        }
        if(tName != undefined)
        {
            this.mWorld.mHud.AddMessage_Upgrade(tName);
        }
    };
    _loc2_.ApplyUpgrade_Creature_Player = 0;
    _loc2_.ApplyUpgrade_Creature_Devil = function ApplyUpgrade_Creature_Devil(tThing)
    {
        var _loc2_ = this[tThing._CLASSID_];
        if(_loc2_.IDCount == tThing.mUpgradeObject.mIDCount)
        {
            return undefined;
        }
        tThing.mUpgradeObject.mIDCount = _loc2_.IDCount;
        var _loc4_ = _loc2_.mOriginalStats;
        tThing.mSpeed = _loc4_.mSpeed * ((this.v = _loc2_.SpeedUp) != undefined ? this.v : 1);
        tThing.mFireRate = _loc4_.mFireRate * ((this.v = _loc2_.FireRateUp) != undefined ? this.v : 1);
        tThing.mAttackSpeed = _loc4_.mAttackSpeed * ((this.v = _loc2_.AttackSpeedUp) != undefined ? this.v : 1);
    };
    _loc2_.ApplyUpgrade_Creature_Zombie = function ApplyUpgrade_Creature_Zombie(tThing)
    {
        var _loc2_ = this[tThing._CLASSID_];
        if(_loc2_.IDCount == tThing.mUpgradeObject.mIDCount)
        {
            return undefined;
        }
        tThing.mUpgradeObject.mIDCount = _loc2_.IDCount;
        var _loc4_ = _loc2_.mOriginalStats;
        tThing.mSpeed = _loc4_.mSpeed * ((this.v = _loc2_.SpeedUp) != undefined ? this.v : 1);
    };
    _loc2_.ApplyUpgrade_Object = function ApplyUpgrade_Object(tThing)
    {
        var _loc2_ = this[tThing._CLASSID_];
        if(_loc2_.IDCount == tThing.mUpgradeObject.mIDCount)
        {
            return undefined;
        }
        tThing.mUpgradeObject.mIDCount = _loc2_.IDCount;
        var _loc4_ = _loc2_.mOriginalStats;
        if(_loc2_.BiggerBang)
        {
            tThing.mBiggerBang = 2;
        }
        else if(_loc2_.BigBang)
        {
            tThing.mBiggerBang = 1;
        }
        if(_loc2_.ClusterExplode)
        {
            tThing.mClusterExplode = 1;
        }
    };
    _loc2_.ApplyUpgrade_Weapon = function ApplyUpgrade_Weapon(tThing)
    {
        var _loc3_ = this[tThing._CLASSID_];
        if(_loc3_.IDCount == tThing.mUpgradeObject.mIDCount)
        {
            return undefined;
        }
        tThing.mUpgradeObject.mIDCount = _loc3_.IDCount;
        var _loc4_ = _loc3_.mOriginalStats;
        if(_loc3_.FatalDamage)
        {
            tThing.mDamage = _loc4_.mDamage * 10;
        }
        else if(_loc3_.QuadDamage)
        {
            tThing.mDamage = _loc4_.mDamage * 4;
        }
        else if(_loc3_.DoubleDamage)
        {
            tThing.mDamage = _loc4_.mDamage * 2;
        }
        if(_loc3_.RapidFire)
        {
            tThing.mFireRate = Math.round(Math.max(_loc4_.mFireRate / 4,2));
            tThing.mFireRateCount = 0;
            tThing.mAuto = true;
        }
        else if(_loc3_.FastFire)
        {
            tThing.mAuto = true;
        }
        if(_loc3_.BiggerBang)
        {
            tThing.mBiggerBang = 2;
        }
        else if(_loc3_.BigBang)
        {
            tThing.mBiggerBang = 1;
        }
        if(_loc3_.ClusterExplode)
        {
            tThing.mClusterExplode = 1;
        }
        if(_loc3_.WiderShot)
        {
            tThing.mWideShot = 2;
        }
        else if(_loc3_.WideShot)
        {
            tThing.mWideShot = 1;
        }
        if(_loc3_.InfinateAmmo)
        {
            tThing.mTotalAmmo = Thing.Weapon.CThing_Weapon.mInfinateAmmo;
            tThing.mAmmo = Thing.Weapon.CThing_Weapon.mInfinateAmmo;
        }
        else if(_loc3_.QuadAmmo)
        {
            tThing.mTotalAmmo = _loc4_.mTotalAmmo * 4;
            tThing.mAmmo = _loc4_.mAmmo * 4;
        }
        else if(_loc3_.DoubleAmmo)
        {
            tThing.mTotalAmmo = _loc4_.mTotalAmmo * 2;
            tThing.mAmmo = _loc4_.mAmmo * 2;
        }
        if(_loc3_.HomingMissiles)
        {
            tThing.mHomingMissiles = true;
        }
        if(_loc3_.InfinateRange)
        {
            tThing.mRange = 100;
        }
        else if(_loc3_.LongShot)
        {
            tThing.mRange = _loc4_.mRange * 1.5;
        }
    };
    _loc2_.CreateUpgradeClass = function CreateUpgradeClass(tClassID)
    {
        return this[tClassID] = !this[tClassID] ? new Object() : this[tClassID];
    };
    _loc2_._RegisterOK = function _RegisterOK(tClassID)
    {
        return !(this[tClassID] == undefined || this[tClassID].mOriginalStats == undefined) ? false : true;
    };
    _loc2_.Register_Creature_Player = function Register_Creature_Player(tThing)
    {
        if(this._RegisterOK(tThing._CLASSID_))
        {
            var _loc4_ = this.CreateUpgradeClass(tThing._CLASSID_);
            var _loc0_ = null;
            var _loc3_ = _loc4_.mOriginalStats = new Object();
            _loc3_.mSpeed = tThing.mSpeed;
            _loc3_.mMaxLife = tThing.mMaxLife;
            _loc3_.mLife = tThing.mLife;
        }
        tThing.mUpgradeObject = new Object();
        this.ApplyUpgrade_Creature_Player(tThing);
    };
    _loc2_.Register_Creature_Zombie = function Register_Creature_Zombie(tThing)
    {
        if(this._RegisterOK(tThing._CLASSID_))
        {
            var _loc4_ = this.CreateUpgradeClass(tThing._CLASSID_);
            var _loc0_ = null;
            var _loc3_ = _loc4_.mOriginalStats = new Object();
            _loc3_.mSpeed = tThing.mSpeed;
            _loc3_.mDamage = tThing.mDamage;
            _loc3_.mMaxLife = tThing.mMaxLife;
            _loc3_.mLife = tThing.mLife;
        }
        tThing.mUpgradeObject = new Object();
        this.ApplyUpgrade_Creature_Zombie(tThing);
    };
    _loc2_.Register_Creature_Devil = function Register_Creature_Devil(tThing)
    {
        if(this._RegisterOK(tThing._CLASSID_))
        {
            var _loc4_ = this.CreateUpgradeClass(tThing._CLASSID_);
            var _loc0_ = null;
            var _loc3_ = _loc4_.mOriginalStats = new Object();
            _loc3_.mSpeed = tThing.mSpeed;
            _loc3_.mFireRate = tThing.mFireRate;
            _loc3_.mAttackSpeed = tThing.mAttackSpeed;
            _loc3_.mDamage = tThing.mDamage;
            _loc3_.mMaxLife = tThing.mMaxLife;
            _loc3_.mLife = tThing.mLife;
        }
        tThing.mUpgradeObject = new Object();
        this.ApplyUpgrade_Creature_Devil(tThing);
    };
    _loc2_.Register_Object = function Register_Object(tThing)
    {
        if(this._RegisterOK(tThing._CLASSID_))
        {
            var _loc4_ = this.CreateUpgradeClass(tThing._CLASSID_);
            var _loc0_ = null;
            var _loc3_ = _loc4_.mOriginalStats = new Object();
            _loc3_.mBiggerBang = tThing.mBiggerBang;
            _loc3_.mClusterExplode = tThing.mClusterExplode;
        }
        tThing.mUpgradeObject = new Object();
        this.ApplyUpgrade_Object(tThing);
    };
    _loc2_.Register_Weapon = function Register_Weapon(tThing)
    {
        if(this._RegisterOK(tThing._CLASSID_))
        {
            var _loc4_ = this.CreateUpgradeClass(tThing._CLASSID_);
            var _loc0_ = null;
            var _loc3_ = _loc4_.mOriginalStats = new Object();
            _loc3_.mAuto = tThing.mAuto;
            _loc3_.mFireRate = tThing.mFireRate;
            _loc3_.mAmmo = tThing.mAmmo;
            _loc3_.mTotalAmmo = tThing.mTotalAmmo;
            _loc3_.mDamage = tThing.mDamage;
            _loc3_.mWideShot = tThing.mWideShot;
            _loc3_.mBiggerBang = tThing.mBiggerBang;
            _loc3_.mRange = tThing.mRange;
        }
        tThing.mUpgradeObject = new Object();
        this.ApplyUpgrade_Weapon(tThing);
    };
    _loc2_.InitLists = function InitLists()
    {
        this.mMultipleKills = new Array();
        this.mMultipliers = new Array();
        this.mLevels = new Array();
        var _loc8_ = 1 * CMain.mFPS;
        var _loc4_ = !_global.mCheat_OneZombie ? 10 : 1;
        10;
        var _loc6_ = 10 * CMain.mFPS;
        0;
        0;
        0;
        1;
        while(true)
        {
            this.AddToLevel(1,{mClassID:"Level",mProp:"Zombie_SpawnRate",mValue:Math.floor(_loc8_)});
            this.AddToLevel(1,{mClassID:"Level",mProp:"Zombie_Count",mValue:Math.floor(_loc4_)});
            this.AddToLevel(1,{mClassID:"Level",mProp:"Zombie_TotalCount",mValue:Math.floor(10)});
            this.AddToLevel(1,{mClassID:"CThing_Creature_Zombie",mProp:"SpeedUp",mValue:Math.min(1.1,5)});
            _loc8_ = Math.max(_loc8_ - 1,1);
            _loc4_ = Math.min(_loc4_ + 5,60);
            15;
            if(CMain.mSaveData.mDevilsActive)
            {
                this.AddToLevel(1,{mClassID:"Level",mProp:"Devil_SpawnRate",mValue:Math.floor(_loc6_)});
                this.AddToLevel(1,{mClassID:"Level",mProp:"Devil_Count",mValue:Math.floor(0)});
                this.AddToLevel(1,{mClassID:"Level",mProp:"Devil_TotalCount",mValue:Math.floor(0)});
                this.AddToLevel(1,{mClassID:"CThing_Creature_Devil",mProp:"SpeedUp",mValue:Math.min(1.1,5)});
                _loc7_ = Math.min(false ? 0.3 : 1,5);
                _loc9_ = false ? 0.25 : 1;
                _loc6_ = Math.max(_loc6_ - 1,CMain.mFPS);
            }
            2;
        }
        this.CreateUpgradeClass("Level");
        this.__set__mLevel(1);
        this.__set__mMultiplier(0);
        this.__set__mMultipleKill(0);
        this.AddToMultipliers(3,{mClassID:"CThing_Weapon_Pistol",mProp:"FastFire",mValue:true,mName:"Pistol+: Fast Fire"});
        this.AddToMultipliers(5,{mClassID:"CThing_Creature_Player",mProp:"NW_uzi",mValue:"uzi",mName:"New Weapon: UZI (Key 2)"});
        this.AddToMultipliers(8,{mClassID:"CThing_Weapon_Pistol",mProp:"DoubleDamage",mValue:true,mName:"Pistol+: Double Damage"});
        this.AddToMultipliers(10,{mClassID:"CThing_Creature_Player",mProp:"NW_shotgun",mValue:"shotgun",mName:"New Weapon: Shotgun (Key 3)"});
        this.AddToMultipliers(13,{mClassID:"CThing_Weapon_UZI",mProp:"RapidFire",mValue:true,mName:"UZI+: Rapid Fire"});
        this.AddToMultipliers(15,{mClassID:"CThing_Creature_Player",mProp:"NW_barrel",mValue:"barrel",mName:"New Weapon: Barrel (Key 4)"});
        this.AddToMultipliers(17,{mClassID:"CThing_Weapon_UZI",mProp:"DoubleAmmo",mValue:true,mName:"UZI+: Double Ammo"});
        this.AddToMultipliers(18,{mClassID:"CThing_Weapon_Shotgun",mProp:"FastFire",mValue:true,mName:"Shotgun+: Fast Fire"});
        this.AddToMultipliers(20,{mClassID:"CThing_Creature_Player",mProp:"NW_grenade",mValue:"grenade",mName:"New Weapon: Grenade (Key 5)"});
        this.AddToMultipliers(21,{mClassID:"CThing_Weapon_Shotgun",mProp:"DoubleAmmo",mValue:true,mName:"Shotgun+: Double Ammo"});
        this.AddToMultipliers(23,{mClassID:"CThing_Weapon_UZI",mProp:"LongShot",mValue:true,mName:"UZI+: Long Shot"});
        this.AddToMultipliers(26,{mClassID:"CThing_Weapon_Barrel",mProp:"DoubleAmmo",mValue:true,mName:"Barrel+: Double Ammo"});
        this.AddToMultipliers(30,{mClassID:"CThing_Creature_Player",mProp:"NW_fakewall",mValue:"fakewall",mName:"New Weapon: Fake walls (Key 6)"});
        this.AddToMultipliers(31,{mClassID:"CThing_Weapon_Shotgun",mProp:"WideShot",mValue:true,mName:"Shotgun+: Wide Shot"});
        this.AddToMultipliers(32,{mClassID:"CThing_Object_Barrel",mProp:"BigBang",mValue:true,mName:"Barrel+: Big Bang"});
        this.AddToMultipliers(33,{mClassID:"CThing_Weapon_Grenade",mProp:"ClusterExplode",mValue:true,mName:"Grenade+: Cluster Explode"});
        this.AddToMultipliers(35,{mClassID:"CThing_Weapon_Shotgun",mProp:"LongShot",mValue:true,mName:"Shotgun+: Long Shot"});
        this.AddToMultipliers(36,{mClassID:"CThing_Weapon_Barrel",mProp:"QuadAmmo",mValue:true,mName:"Barrel+: Quad Ammo"});
        this.AddToMultipliers(37,{mClassID:"CThing_Weapon_FakeWall",mProp:"DoubleAmmo",mValue:true,mName:"Fake Wall+: Double Ammo"});
        this.AddToMultipliers(39,{mClassID:"CThing_Weapon_UZI",mProp:"QuadAmmo",mValue:true,mName:"UZI+: Quad Ammo"});
        this.AddToMultipliers(40,{mClassID:"CThing_Creature_Player",mProp:"NW_mine",mValue:"mine",mName:"New Weapon: Claymore (Key 7)"});
        this.AddToMultipliers(41,{mClassID:"CThing_Weapon_Shotgun",mProp:"QuadAmmo",mValue:true,mName:"Shotgun+: Quad Ammo"});
        this.AddToMultipliers(42,{mClassID:"CThing_Weapon_Grenade",mProp:"DoubleAmmo",mValue:true,mName:"Grenade+: Double Ammo"});
        this.AddToMultipliers(43,{mClassID:"CThing_Weapon_Shotgun",mProp:"RapidFire",mValue:true,mName:"Shotgun+: Rapid Fire"});
        this.AddToMultipliers(44,{mClassID:"CThing_Object_Barrel",mProp:"BiggerBang",mValue:true,mName:"Barrel+: Bigger Bang"});
        this.AddToMultipliers(45,{mClassID:"CThing_Weapon_Grenade",mProp:"BigBang",mValue:true,mName:"Grenade+: Big Bang"});
        this.AddToMultipliers(47,{mClassID:"CThing_Object_Mine",mProp:"ClusterExplode",mValue:true,mName:"Claymore+: Cluster Explode"});
        this.AddToMultipliers(48,{mClassID:"CThing_Weapon_UZI",mProp:"DoubleDamage",mValue:true,mName:"UZI+: Double Damage"});
        this.AddToMultipliers(50,{mClassID:"CThing_Creature_Player",mProp:"NW_rocket",mValue:"rocket",mName:"New Weapon: Rocket (Key 8)"});
        this.AddToMultipliers(51,{mClassID:"CThing_Weapon_Shotgun",mProp:"WiderShot",mValue:true,mName:"Shotgun+: Wider Shot"});
        this.AddToMultipliers(52,{mClassID:"CThing_Weapon_Grenade",mProp:"QuadAmmo",mValue:true,mName:"Grenade+: Quad Ammo"});
        this.AddToMultipliers(53,{mClassID:"CThing_Weapon_FakeWall",mProp:"QuadAmmo",mValue:true,mName:"Fake Wall+: Quad Ammo"});
        this.AddToMultipliers(54,{mClassID:"CThing_Weapon_Mine",mProp:"DoubleAmmo",mValue:true,mName:"Claymore+: Double Ammo"});
        this.AddToMultipliers(55,{mClassID:"CThing_Creature_Player",mProp:"NW_chargepack",mValue:"chargepack",mName:"New Weapon: Chargepack (Key 9)"});
        this.AddToMultipliers(56,{mClassID:"CThing_Weapon_Shotgun",mProp:"DoubleDamage",mValue:true,mName:"Shotgun+: Double Damage"});
        this.AddToMultipliers(57,{mClassID:"CThing_Weapon_Grenade",mProp:"BiggerBang",mValue:true,mName:"Grenade+: Bigger Bang"});
        this.AddToMultipliers(58,{mClassID:"CThing_Object_Mine",mProp:"BigBang",mValue:true,mName:"Claymore+: Big Bang"});
        this.AddToMultipliers(59,{mClassID:"CThing_Weapon_Rocket",mProp:"FastFire",mValue:true,mName:"Rocket+: Fast Fire"});
        this.AddToMultipliers(61,{mClassID:"CThing_Weapon_UZI",mProp:"InfinateRange",mValue:true,mName:"UZI+: Infinate Range"});
        this.AddToMultipliers(62,{mClassID:"CThing_Object_Mine",mProp:"BiggerBang",mValue:true,mName:"Claymore+: Bigger Bang"});
        this.AddToMultipliers(63,{mClassID:"CThing_Object_ChargePack",mProp:"ClusterExplode",mValue:true,mName:"Charge Pack+: Cluster Explode"});
        this.AddToMultipliers(64,{mClassID:"CThing_Weapon_Mine",mProp:"QuadAmmo",mValue:true,mName:"Claymore+: Quad Ammo"});
        this.AddToMultipliers(66,{mClassID:"CThing_Weapon_Rocket",mProp:"DoubleAmmo",mValue:true,mName:"Rocket+: Double Ammo"});
        this.AddToMultipliers(68,{mClassID:"CThing_Weapon_ChargePack",mProp:"DoubleAmmo",mValue:true,mName:"Charge Pack+: Double Ammo"});
        this.AddToMultipliers(70,{mClassID:"CThing_Creature_Player",mProp:"NW_railgun",mValue:"railgun",mName:"New Weapon: Railgun (Key 0)"});
        this.AddToMultipliers(72,{mClassID:"CThing_Weapon_Rocket",mProp:"BigBang",mValue:true,mName:"Rocket+: Big Bang"});
        this.AddToMultipliers(74,{mClassID:"CThing_Object_ChargePack",mProp:"BigBang",mValue:true,mName:"Charge Pack+: Big Bang"});
        this.AddToMultipliers(76,{mClassID:"CThing_Weapon_ChargePack",mProp:"QuadAmmo",mValue:true,mName:"Charge Pack+: Quad Ammo"});
        this.AddToMultipliers(78,{mClassID:"CThing_Weapon_Railgun",mProp:"FastFire",mValue:true,mName:"Railgun+: Fast Fire"});
        this.AddToMultipliers(80,{mClassID:"CThing_Weapon_Railgun",mProp:"DoubleAmmo",mValue:true,mName:"Railgun+: Double Ammo"});
        this.AddToMultipliers(85,{mClassID:"CThing_Weapon_Rocket",mProp:"QuadAmmo",mValue:true,mName:"Rocket+: Quad Ammo"});
        this.AddToMultipliers(90,{mClassID:"CThing_Weapon_UZI",mProp:"QuadDamage",mValue:true,mName:"UZI+: Quad Damage"});
        this.AddToMultipliers(95,{mClassID:"CThing_Object_ChargePack",mProp:"BiggerBang",mValue:true,mName:"Charge Pack+: Bigger Bang"});
        this.AddToMultipliers(100,{mClassID:"CThing_Weapon_Railgun",mProp:"RapidFire",mValue:true,mName:"Railgun+: Rapid Fire"});
        this.AddToMultipliers(105,{mClassID:"CThing_Weapon_Rocket",mProp:"BiggerBang",mValue:true,mName:"Rocket+: Bigger Bang"});
        this.AddToMultipliers(110,{mClassID:"CThing_Weapon_Railgun",mProp:"QuadAmmo",mValue:true,mName:"Railgun+: Quad Ammo"});
        this.AddToMultipliers(120,{mClassID:"CThing_Weapon_Rocket",mProp:"RapidFire",mValue:true,mName:"Rocket+: Rapid Fire"});
        this.AddToMultipliers(125,{mClassID:"CThing_Weapon_Railgun",mProp:"LongShot",mValue:true,mName:"Railgun+: Long Shot"});
    };
    _loc2_.AddToMultipliers = function AddToMultipliers(tIndex, tObject)
    {
        this.mMultipliers[tIndex] = this.mMultipliers[tIndex] != undefined ? this.mMultipliers[tIndex] : new Array();
        tObject.mIndex = tIndex;
        this.mMultipliers[tIndex].push(tObject);
    };
    _loc2_.__get__mMultiplierList = function __get__mMultiplierList()
    {
        var _loc4_ = new Array();
        0;
        while(0 < this.mMultipliers.length)
        {
            if(this.mMultipliers[0])
            {
                0;
                while(0 < this.mMultipliers[0].length)
                {
                    _loc4_.push(this.mMultipliers[0][0]);
                    1;
                }
            }
            1;
        }
        return _loc4_;
    };
    _loc2_.AddToMultipleKills = function AddToMultipleKills(tIndex, tObject)
    {
        this.mMultipleKills[tIndex] = this.mMultipleKills[tIndex] != undefined ? this.mMultipleKills[tIndex] : new Array();
        tObject.mIndex = tIndex;
        this.mMultipleKills[tIndex].push(tObject);
    };
    _loc2_.AddToLevel = function AddToLevel(tIndex, tObject)
    {
        this.mLevels[tIndex] = this.mLevels[tIndex] != undefined ? this.mLevels[tIndex] : new Array();
        tObject.mIndex = tIndex;
        this.mLevels[tIndex].push(tObject);
    };
    _loc2_.LogKills = function LogKills(a)
    {
        while(a)
        {
            this.__set__mMultipleKill(this.__get__mMultipleKill() + 1);
            this.__set__mMultiplier(this.__get__mMultiplier() + 1);
            a = a - 1;
        }
    };
    _loc2_.__set__mLevel = function set mLevel(a)
    {
        this.mLevelIndex = a;
        var _loc2_ = this.mLevels[this.mLevelIndex <= 100 ? this.mLevelIndex : 100];
        for(var _loc3_ in _loc2_)
        {
            this.AddUpgrade(_loc2_[_loc3_].mName,_loc2_[_loc3_].mClassID,_loc2_[_loc3_].mProp,_loc2_[_loc3_].mValue);
        }
        this.Level.mZombieCount = 0;
        this.Level.mDevilCount = 0;
        this.Level.mSpawnCount_Zombie = this.Level.Zombie_SpawnRate;
        this.Level.mSpawnCount_Devil = this.Level.Devil_SpawnRate;
        this.mWorld.mHud.AddMessage_Level("-+-+-+- LEVEL " + (this.mLevelIndex <= 100 ? this.mLevelIndex : this.mLevelIndex + " (FOREVER)") + " -+-+-+-");
    };
    _loc2_.__get__mLevel = function get mLevel()
    {
        return this.mLevelIndex;
    };
    _loc2_.__set__mMultipleKill = function set mMultipleKill(a)
    {
        this.mMultipleKillsIndex = a >= 0 ? a : 0;
        if(this.mMultipleKillsIndex)
        {
            this.mMultipleKillsTickTotal = this.mMultipleKillsTick = this.GetTicks(this.mMultipleKillsIndex) / 6;
            var _loc2_ = this.mMultipleKills[this.mMultipleKillsIndex];
            delete this.mMultipleKills[this.mMultipleKillsIndex];
            for(var _loc3_ in _loc2_)
            {
                this.AddUpgrade(_loc2_[_loc3_].mName,_loc2_[_loc3_].mClassID,_loc2_[_loc3_].mProp,_loc2_[_loc3_].mValue);
            }
        }
        else
        {
            this.mMultipleKillsTick = 100000;
            this.mMultipleKillsTickTotal = 100000;
        }
    };
    _loc2_.__get__mMultipleKill = function get mMultipleKill()
    {
        return this.mMultipleKillsIndex;
    };
    _loc2_.__get__mMultipleKillRatio = function get mMultipleKillRatio()
    {
        return this.__get__mMultipleKill() != 0 ? this.mMultipleKillsTick / this.mMultipleKillsTickTotal : 0;
    };
    _loc2_.__set__mMultiplier = function __set__mMultiplier(a)
    {
        this.mMultiplierIndex = a >= 1 ? (a <= 999 ? a : 999) : 1;
        this.mMultiplierTickTotal = this.mMultiplierTick = this.GetTicks(this.mMultiplierIndex);
        if(a > 1)
        {
            var _loc3_ = this.mMultipliers[this.mMultiplierIndex];
            for(var _loc4_ in _loc3_)
            {
                var _loc2_ = _loc3_[_loc4_];
                if(_loc2_.mActive != true)
                {
                    this.AddUpgrade(_loc2_.mName,_loc2_.mClassID,_loc2_.mProp,_loc2_.mValue);
                    _loc2_.mActive = true;
                }
            }
        }
        return this.__get__mMultiplier();
    };
    _loc2_.__get__mMultiplier = function __get__mMultiplier()
    {
        return this.mMultiplierIndex;
    };
    _loc2_.__get__mMultiplierTickRatio = function __get__mMultiplierTickRatio()
    {
        return this.__get__mMultiplier() != 1 ? this.mMultiplierTick / this.mMultiplierTickTotal : 0;
    };
    _loc2_.GetTicks = function GetTicks(index)
    {
        index = 100 - ((index <= 100 ? index : 100) - 1);
        var _loc1_ = Math.pow(index,2.5) / 100000.00000000003 * (CMain.mFPS * 3 - 3) + 3;
        return _loc1_;
    };
    _loc2_.__set__mZombieCount = function __set__mZombieCount(a)
    {
        var _loc2_ = a - this.Level.mZombieCount;
        if(_loc2_ < 0)
        {
            this.Level.Zombie_TotalCount += _loc2_;
            if(this.Level.Zombie_TotalCount < this.Level.Zombie_Count)
            {
                this.Level.Zombie_Count = this.Level.Zombie_TotalCount;
            }
            this.LogKills(1);
        }
        this.Level.mZombieCount = a;
        return this.__get__mZombieCount();
    };
    _loc2_.__get__mZombieCount = function __get__mZombieCount()
    {
        return this.Level.mZombieCount;
    };
    _loc2_.__set__mDevilCount = function set mDevilCount(a)
    {
        var _loc2_ = a - this.Level.mDevilCount;
        if(_loc2_ < 0)
        {
            this.Level.Devil_TotalCount += _loc2_;
            if(this.Level.Devil_TotalCount < this.Level.Devil_Count)
            {
                this.Level.Devil_Count = this.Level.Devil_TotalCount;
            }
            this.LogKills(1);
        }
        this.Level.mDevilCount = a;
    };
    _loc2_.__get__mDevilCount = function get mDevilCount()
    {
        return this.Level.mDevilCount;
    };
    _loc2_.__set__mPlayerCount = function __set__mPlayerCount(a)
    {
        this.Level.mPlayerCount = a;
        return this.__get__mPlayerCount();
    };
    _loc2_.__get__mPlayerCount = function __get__mPlayerCount()
    {
        return this.Level.mPlayerCount != undefined ? this.Level.mPlayerCount : 0;
    };
    _loc2_.__set__mTotalPlayerCount = function __set__mTotalPlayerCount(a)
    {
        this._TotalPlayerCount = a;
        return this.__get__mTotalPlayerCount();
    };
    _loc2_.__get__mTotalPlayerCount = function __get__mTotalPlayerCount()
    {
        return this._TotalPlayerCount;
    };
    _loc2_._CLASSID_ = "CUpgrades";
    _loc2_._BASECLASSID_ = "CUpgrades";
    §§push(_loc2_.addProperty("mDevilCount",_loc2_.__get__mDevilCount,_loc2_.__set__mDevilCount));
    §§push(_loc2_.addProperty("mLevel",_loc2_.__get__mLevel,_loc2_.__set__mLevel));
    §§push(_loc2_.addProperty("mMultipleKill",_loc2_.__get__mMultipleKill,_loc2_.__set__mMultipleKill));
    §§push(_loc2_.addProperty("mMultipleKillRatio",_loc2_.__get__mMultipleKillRatio,0));
    §§push(_loc2_.addProperty("mMultiplier",_loc2_.__get__mMultiplier,_loc2_.__set__mMultiplier));
    §§push(_loc2_.addProperty("mMultiplierList",_loc2_.__get__mMultiplierList,0));
    §§push(_loc2_.addProperty("mMultiplierTickRatio",_loc2_.__get__mMultiplierTickRatio,0));
    §§push(_loc2_.addProperty("mPlayerCount",_loc2_.__get__mPlayerCount,_loc2_.__set__mPlayerCount));
    §§push(_loc2_.addProperty("mTotalPlayerCount",_loc2_.__get__mTotalPlayerCount,_loc2_.__set__mTotalPlayerCount));
    §§push(_loc2_.addProperty("mZombieCount",_loc2_.__get__mZombieCount,_loc2_.__set__mZombieCount));
    §§push(ASSetPropFlags(World.CUpgrades.prototype,null,1));
}
§§pop();
