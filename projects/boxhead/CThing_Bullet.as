class CThing_Bullet extends CThing_Shot
{
    var _CLASSID_ = "CThing_Bullet";
    var _BASECLASSID_ = "CThing_Bullet";
    function CThing_Bullet(tPosition, tAngle, tID, tOwner, tDamage)
    {
        super(tPosition,tAngle,tID,tOwner,tDamage);
        var _loc4_ = new scidd.Math.CPointXYZ(1,0,0);
        _loc4_.RotateZ(this.mAngle);
        _loc4_.Normalize(CMapwho.mCellSize.x * 10);
        this.mDestination = this.mPosition.Add(_loc4_);
        this.mLife = 5;
        this.mMaxLife = 5;
        this.mDelta = new scidd.Math.CPointXYZ(0,random(4) + 2,random(4) + 2).RotateZ(this.mAngle);
        this.Move(this.mPosition);
        var _loc3_ = this.oMapwho.mMapwho.LineCollide(this.mPosition,this.mDestination,this.mID);
        if(_loc3_ != undefined)
        {
            if(_loc3_.mThing != undefined)
            {
                this.mDestination.mX = _loc3_.mThing.mPosition.mX;
                this.mDestination.mY = _loc3_.mThing.mPosition.mY;
                _loc3_.mThing.AddAffect(CThing_Affect.Bullet(this.mOwner,this,this.mDamage));
            }
            else if(_loc3_.mWallPoint != undefined)
            {
                this.mDestination.mX = _loc3_.mWallPoint.x;
                this.mDestination.mY = _loc3_.mWallPoint.y;
                CThing.AddThing(new CThing_ShotHit(this.mDestination.Add(new scidd.Math.CPointXYZ(random(6) - 3,random(6) - 3,0)),0,this.mID));
            }
        }
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        this.mDestination = this.mDestination.Add(this.mDelta.Clone().ScaleN(0.5));
        this.mPosition = this.mPosition.Add(this.mDelta.ScaleN(0.75));
        if(--this.mLife == 0)
        {
            this.__set__mDelete(true);
        }
    }
    function Draw()
    {
        CCity._this.DrawLine(this.mPosition,this.mDestination,1,16777215,25 * this.mLife / this.mMaxLife);
    }
}
