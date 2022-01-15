class Thing.CThing
{
    var _CLASSID_ = "CThing";
    var _BASECLASSID_ = "CThing";
    static var mAllocate_ID = 0;
    static var mAllocate_ProcessID_Count = 3;
    static var mFlag_Collidable = 1;
    static var mFlag_WaitForMove = 2;
    static var mFlag_CellMoved = 4;
    static var mFlag_Drawn = 8;
    static var mFlag_SortFloor = 16;
    static var mFlag_DEAD = 32;
    static var pDraw = new flash.geom.Point(0,0);
    function CThing(tPosition, tAngle, tParent)
    {
        this.mP = this.mPosition = tPosition;
        this.mAngle = tAngle != undefined ? tAngle : new Thing.Math.CThing_Angle(0);
        this.mParent = tParent;
        this.mUniqueID = ++Thing.CThing.mAllocate_ID;
        this.sUniqueID = "t" + this.mUniqueID;
        this.mID = this.mParent != undefined ? tParent.mID : this.mUniqueID;
        this.mFlags = 0;
        scidd.CProfiler.SetVariable("ThingID",this.mUniqueID);
    }
    function MakeIDUnique()
    {
        this.mID = this.mUniqueID;
    }
    static function Renew()
    {
        Thing.CThing.mAllocate_ID = 0;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        if(this.mCellID != undefined)
        {
            this.mWorld.mMap.mMapwho.DeleteThing(this);
        }
    }
    function SetRadius(tRadius)
    {
        this.mRadius = tRadius;
        this.mRadius_SQR = this.mRadius * this.mRadius;
    }
    function GrowRadius(tRadius)
    {
        if(this.mRadius == undefined)
        {
            this.mRadius = 0;
        }
        if(this.mRadius < tRadius)
        {
            this.SetRadius(this.mRadius + 0.05);
            return true;
        }
        return false;
    }
    function Delete()
    {
        delete this.Process;
        this.mThing_Collection.DeleteThing(this);
    }
    function Move(nPosition)
    {
        if(nPosition != this.mPosition)
        {
            this.mPosition.mX = nPosition.mX;
            this.mPosition.mY = nPosition.mY;
            this.mPosition.mZ = nPosition.mZ;
        }
        this.mWorld.mMap.mMapwho.MoveThing(this);
    }
    function Affect_Setup(tFlags)
    {
        this.mAffectors = new Array();
        this.mAffectFlags = tFlags;
    }
    function Affect(tAffect)
    {
        this.mAffectors.push(tAffect);
    }
    function ClearAffects()
    {
        this.mAffectFlags = 0;
    }
    function PlaySound(tSound, tPosition)
    {
        var _loc5_ = tPosition != undefined ? tPosition : this.mPosition;
        var _loc4_ = _loc5_.ConvertCellToScreen();
        var _loc2_ = this.mWorld.mScreenCentre;
        var _loc3_ = this.mWorld.mScreenSizeHalf;
        _loc4_ = new flash.geom.Point((_loc4_.x - _loc2_.x) / _loc3_.x / 3,(_loc4_.y - _loc2_.y) / _loc3_.y / 1.5);
        tSound.PlaySound(_loc4_);
    }
    static function DummyThings()
    {
        var _loc1_ = undefined;
        _loc1_ = new Thing.Creature.CThing_Creature_Devil();
        _loc1_ = new Thing.Creature.CThing_Creature_Zombie();
        _loc1_ = new Thing.Effect.CThing_Effect_BloodPool();
        _loc1_ = new Thing.Effect.CThing_Effect_BloodSplat();
        _loc1_ = new Thing.Effect.CThing_Effect_BulletHit();
        _loc1_ = new Thing.Effect.CThing_Effect_Explosion();
        _loc1_ = new Thing.Effect.CThing_Effect_FireBall_Held();
        _loc1_ = new Thing.Effect.CThing_Effect_MuzzleFlash();
        _loc1_ = new Thing.Effect.CThing_Effect_RocketSmoke();
        _loc1_ = new Thing.Effect.CThing_Effect_SmartBomb();
        _loc1_ = new Thing.Effect.CThing_Effect_SmokeCloud();
        _loc1_ = new Thing.Object.CThing_Object_Barrel();
        _loc1_ = new Thing.Object.CThing_Object_ChargePack();
        _loc1_ = new Thing.Object.CThing_Object_LaserNode();
        _loc1_ = new Thing.Object.CThing_Object_Mine();
        _loc1_ = new Thing.Object.CThing_Object_Pickup();
        _loc1_ = new Thing.Object.CThing_Object_Wall();
        _loc1_ = new Thing.Object.CThing_Object_WallMovable();
        _loc1_ = new Thing.Shot.CThing_Shot_Bullet();
        _loc1_ = new Thing.Shot.CThing_Shot_ClusterShell();
        _loc1_ = new Thing.Shot.CThing_Shot_Devastator();
        _loc1_ = new Thing.Shot.CThing_Shot_DLaser();
        _loc1_ = new Thing.Shot.CThing_Shot_FireBall();
        _loc1_ = new Thing.Shot.CThing_Shot_Grenade();
        _loc1_ = new Thing.Shot.CThing_Shot_HomingMissile();
        _loc1_ = new Thing.Shot.CThing_Shot_Laser();
        _loc1_ = new Thing.Shot.CThing_Shot_Railgun();
        _loc1_ = new Thing.Shot.CThing_Shot_Rocket();
        _loc1_ = new Thing.Weapon.CThing_Weapon_Barrel();
        _loc1_ = new Thing.Weapon.CThing_Weapon_ChargePack();
        _loc1_ = new Thing.Weapon.CThing_Weapon_Devastator();
        _loc1_ = new Thing.Weapon.CThing_Weapon_FakeWall();
        _loc1_ = new Thing.Weapon.CThing_Weapon_Grenade();
        _loc1_ = new Thing.Weapon.CThing_Weapon_Mine();
        _loc1_ = new Thing.Weapon.CThing_Weapon_Pistol();
        _loc1_ = new Thing.Weapon.CThing_Weapon_Railgun();
        _loc1_ = new Thing.Weapon.CThing_Weapon_Rocket();
        _loc1_ = new Thing.Weapon.CThing_Weapon_Shotgun();
        _loc1_ = new Thing.Weapon.CThing_Weapon_SmartBomb();
        _loc1_ = new Thing.Weapon.CThing_Weapon_UZI();
        Thing.CThing.Renew();
    }
}
