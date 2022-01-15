class CThing_Object_Barrel extends CThing_Object
{
    var _CLASSID_ = "CThing_Object_Barrel";
    function CThing_Object_Barrel(tPosition, tAngle, tID, tBigBang)
    {
        super(tPosition,tAngle,tID);
        this.mAffectable = true;
        this.mRadius = 16;
        this.mLife = 1;
        if(CThing_Object_Barrel.bmObject == undefined)
        {
            var _loc4_ = _root.attachMovie("Barrel","_Barrel",_root.getNextHighestDepth());
            CThing_Object_Barrel.bmObject = CCity.RenderToBitmap(_loc4_,1);
            _loc4_.removeMovieClip();
        }
        this.Move(CMapwho.CentrePosition(this.mPosition));
        var _loc5_ = this.oMapwho.mMapwho.GetCellPosition(this.mPosition.mX,this.mPosition.mY);
        this.oMapwho.mMapwho.SetCollideFlags(_loc5_.x,_loc5_.y,CMapwho.mCollide_Object);
        this.mBigBang = tBigBang != undefined ? tBigBang : false;
        this.mPlayerCollide = true;
    }
    function Dispose()
    {
        super.Dispose();
        var _loc3_ = this.oMapwho.mMapwho.GetCellPosition(this.mPosition.mX,this.mPosition.mY);
        this.oMapwho.mMapwho.ClearCollideFlags(_loc3_.x,_loc3_.y,CMapwho.mCollide_Object);
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        if(this.mLife <= 0)
        {
            CThing.AddThing(new CThing_Explosion2(this.mPosition,0,this.mID,this,500));
            0;
            while(true)
            {
                var _loc3_ = this.mPosition.Add(new scidd.Math.CPointXYZ(random(96) - 48,random(96) - 48,0));
                CThing.AddThing(new CThing_Explosion2(_loc3_,0,this.mID,this,250 + random(250),this.mBigBang));
                1;
            }
            this.__set__mDelete(true);
        }
        if(this.mAffectors.length != 0)
        {
            this.ProcessAffects();
        }
    }
    function ProcessAffects()
    {
        for(var _loc6_ in this.mAffectors)
        {
            var _loc2_ = this.mAffectors[_loc6_];
            switch(_loc2_.mType)
            {
                case CThing_Affect.mType_Bullet:
                    this.mLife -= _loc2_.mDamage;
                    break;
                case CThing_Affect.mType_Explosion:
                    var _loc5_ = Math.min(_loc2_.mRange,this.mPosition.Sub(_loc2_.mAffector.mPosition).__get__mLength());
                    var _loc3_ = 1 - _loc5_ / _loc2_.mRange;
                    if(_loc3_ < 0.1)
                    {
                        break;
                    }
                    var _loc4_ = _loc2_.mDamage * _loc3_;
                    this.mLife -= _loc4_;
                    break;
            }
        }
        this.mAffectors = new Array();
    }
    function Draw()
    {
        CCity._this.DrawBitmap(this,CThing_Object_Barrel.bmObject);
        this.mDrawn = true;
    }
}
