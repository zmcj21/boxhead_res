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
        this.mWorld.mMap.mMapwho.DeleteThing(this);
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
        tSound.PlaySound(new flash.geom.Point(0,0));
    }
    static function DummyThings()
    {
        Thing.CThing.Renew();
        return undefined;
    }
}
