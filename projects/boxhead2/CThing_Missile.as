class CThing_Missile extends CThing_Shot
{
    var _CLASSID_ = "CThing_Missile";
    var mSpeed = 18;
    var mMaxAngleSpeed = 0.10471975511965977;
    function CThing_Missile(tPosition, tAngle, tID, tOwner)
    {
        super(tPosition,tAngle,tID,tOwner,500);
        if(CThing_Missile.mcDraw == undefined)
        {
            CThing_Missile.mcDraw = _root.attachMovie("Missile","_Missile",_root.getNextHighestDepth(),{_visible:false});
            CThing_Missile.mcDraw.mScale = 0.5;
        }
        this.mDelta = new scidd.Math.CPointXYZ(this.mSpeed,0,0).RotateZ(this.mAngle);
        this.mTotalLifeDistance = 1000;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process()
    {
        CThing.AddThing(new CThing_Smoke1(this.mPosition,this.mAngle,this.mID));
        this.Move(this.mPosition.Add(this.mDelta.ScaleN(1.1)));
        var _loc2_ = this.oMapwho.mMapwho.QCollide(this.mPosition,CMapwho.mCollide_CollideAll & (CMapwho.mCollide_Player ^ -1));
        if((this.mTotalLifeDistance -= this.mDelta.mLength) < 0 || _loc2_)
        {
            CThing.AddThing(new CThing_Explosion2(this.mPosition,0,this.mID,this.mOwner,this.mDamage));
            this.__set__mDelete(true);
        }
    }
    function Draw()
    {
        CCity._this.DrawMovieClip(this,CThing_Missile.mcDraw);
        this.mDrawn = true;
    }
}
