class CThing_Object_Mine extends CThing_Object
{
    var _CLASSID_ = "CThing_Object_Mine";
    function CThing_Object_Mine(tPosition, tAngle, tID, tBigBang)
    {
        super(tPosition,tAngle,tID);
        this.mAffectable = false;
        this.mRadius = 16;
        this.mLife = 1;
        this.mFrameIndex = Math.random();
        if(CThing_Object_Mine.bmObject == undefined)
        {
            var _loc4_ = _root.attachMovie("Mine","_Mine",_root.getNextHighestDepth());
            CThing_Object_Mine.bmObject = CCity.RenderToBitmap(_loc4_,1);
            _loc4_.removeMovieClip();
        }
        this.Move(CMapwho.CentrePosition(this.mPosition));
        this.mActive = false;
        this.mMapwhoCell = this.oMapwho.mMapwho.GetCellXYZ(this.mPosition);
        this.mMWCount = 0;
        this.mBigBang = tBigBang != undefined ? tBigBang : false;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Process()
    {
        if(this.mCountDown != undefined)
        {
            this.mCountDown--;
            this.mFrameIndex = (this.mFrameIndex + 0.25) % CThing_Object_Mine.bmObject.mFrameAmount;
            if(this.mCountDown < 0)
            {
                this.mLife = -1;
            }
        }
        else if(this.mMapwhoCell.mCollide & CMapwho.mCollide_Dude)
        {
            this.mCountDown = 30;
        }
        else
        {
            this.mFrameIndex = (this.mFrameIndex + 0.03333333333333333) % CThing_Object_Mine.bmObject.mFrameAmount;
        }
        if(this.mLife <= 0)
        {
            CThing.AddThing(new CThing_Explosion2(this.mPosition,0,this.mID,this,500,this.mBigBang));
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
        CThing_Object_Mine.bmObject.mFrameIndex = Math.floor(this.mFrameIndex);
        CCity._this.DrawBitmap(this,CThing_Object_Mine.bmObject);
        this.mDrawn = true;
    }
}
