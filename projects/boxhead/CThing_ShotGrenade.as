class CThing_ShotGrenade extends CThing_Shot
{
    var _CLASSID_ = "CThing_ShotGrenade";
    var _BASECLASSID_ = "CThing_ShotGrenade";
    static var mBounceDecay = 0.4;
    function CThing_ShotGrenade(tPosition, tAngle, tID, tOwner, tStrength)
    {
        super(tPosition,tAngle,tID,tOwner,100);
        tStrength = scidd.Math.CMath.Range(tStrength != undefined ? tStrength : 1,0.3,1);
        this.mLife = 60;
        this.mMaxLife = 60;
        this.mPosition.mZ = 40;
        var _loc5_ = 11 * tStrength;
        this.mDelta = new scidd.Math.CPointXYZ(_loc5_,0,_loc5_ * (0.3 + Math.random() / 10)).RotateZ(this.mAngle);
        if(CThing_ShotGrenade.mcGrenade == undefined)
        {
            CThing_ShotGrenade.mcGrenade = _root.attachMovie("Grenade","_Grenade",_root.getNextHighestDepth(),{_visible:false});
            CThing_ShotGrenade.mcGrenade.mScale = 1;
        }
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        this.mDelta.mZ -= 1;
        var _loc2_ = this.oMapwho.mMapwho.Collide(this.mPosition,this.mDelta,CMapwho.mCollide_Solid);
        var _loc3_ = !_loc2_.zCollide ? 1 : CThing_ShotGrenade.mBounceDecay;
        this.mDelta.mX = !(_loc2_.xCollide == true || _loc2_.xyCollide == true) ? this.mDelta.mX * _loc3_ : (0 - this.mDelta.mX) * CThing_ShotGrenade.mBounceDecay;
        this.mDelta.mY = !(_loc2_.yCollide == true || _loc2_.xyCollide == true) ? this.mDelta.mY * _loc3_ : (0 - this.mDelta.mY) * CThing_ShotGrenade.mBounceDecay;
        this.mDelta.mZ = _loc2_.zCollide != true ? this.mDelta.mZ : (0 - this.mDelta.mZ) * CThing_ShotGrenade.mBounceDecay;
        if((_loc2_.xCollide == true || _loc2_.xyCollide == true || _loc2_.yCollide == true || _loc2_.zCollide == true) && this.mDelta.mZ > 2)
        {
            this.PlaySound(CSound.mGrenadeBounce);
        }
        this.Move(this.mPosition.Add(this.mDelta));
        if(--this.mLife == 0)
        {
            CThing.AddThing(new CThing_Explosion2(this.mPosition,0,this.mID,this.mOwner,500));
            this.__set__mDelete(true);
        }
    }
    function Draw()
    {
        CCity._this.DrawMovieClip(this,CThing_ShotGrenade.mcGrenade);
        this.mDrawn = true;
    }
}
