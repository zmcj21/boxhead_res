class CThing
{
    var _CLASSID_ = "CThing";
    var _BASECLASSID_ = "CThing";
    static var mAllocateID = 0;
    var mVisible = true;
    function CThing(tPosition, tAngle, tID)
    {
        this.mID = tID != undefined ? tID : ++CThing.mAllocateID;
        this.mPosition = tPosition.Clone();
        this.mAngle = tAngle;
        CThing.mcCity = CCity._this;
        this.oMapwho = CThing.mcCity.mMapwho.Create(this);
        this.mAffectors = new Array();
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        this.oMapwho.mMapwho.Remove(this.oMapwho);
    }
    function set mDelete(a)
    {
        this._Delete = a;
    }
    function get mDelete()
    {
        return this._Delete;
    }
    function PlaySound(tSound, tPosition)
    {
        CThing.G_PlaySound(tSound,tPosition != undefined ? tPosition : this.mPosition);
    }
    static function G_PlaySound(tSound, tPosition)
    {
        var _loc1_ = new flash.geom.Point((tPosition.mX - CCity._this.mScreenCentre.x) / CCity._this.mScreenSizeHalf.x / 3,(tPosition.mY - CCity._this.mScreenCentre.y) / CCity._this.mScreenSizeHalf.y / 1.5);
        tSound.PlaySound(_loc1_);
    }
    function Collide_PointToPoint(p1, p2)
    {
        return undefined;
    }
    function AddAffect(tAffect)
    {
        this.mAffectors[this.mAffectors.length] = tAffect;
    }
    static function Renew()
    {
        CThing.mThingList = new Array();
        CThing_Animation.Renew();
    }
    static function AddThing(tThing)
    {
        CThing.mThingList[CThing.mThingList.length] = tThing;
        return tThing;
    }
    static function ProcessAll()
    {
        CThing.DeleteAllUnused();
        0;
        while(0 < CThing.mThingList.length)
        {
            CThing.mThingList[0].Process();
            1;
        }
    }
    static function DeleteAllUnused()
    {
        var _loc1_ = CThing.mThingList.length - 1;
        while(_loc1_ >= 0)
        {
            if(CThing.mThingList[_loc1_].mDelete)
            {
                CThing.mThingList[_loc1_].Dispose();
                CThing.mThingList.splice(_loc1_,1);
            }
            _loc1_ = _loc1_ - 1;
        }
    }
}
