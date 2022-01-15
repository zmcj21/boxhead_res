class CThing_Crate extends CThing_Pickup
{
    var _CLASSID_ = "CThing_Crate";
    function CThing_Crate(tPosition, tAngle, tID, tType)
    {
        super(tPosition,tAngle,tID);
        if(CThing_Crate.bmObject == undefined)
        {
            var _loc4_ = _root.attachMovie("Crate","_Crate",_root.getNextHighestDepth());
            CThing_Crate.bmObject = CCity.RenderToBitmap(_loc4_,0.75);
            _loc4_.removeMovieClip();
        }
        this.mPickupType = tType;
    }
    function Pickup(byThing)
    {
        super.Pickup();
        switch(this.mPickupType)
        {
            case "randomanddelete":
                this.__set__mDelete(true);
            case "random":
                byThing.AddRandomWeapon();
                this.PlaySound(CSound.mPickupWeapon);
                break;
            case "pistol":
            case "uzi":
            case "shotgun":
            case "rocketlauncher":
            case "grenade":
            case "flamethrower":
                byThing.AddWeapon(this.mPickupType);
                this.PlaySound(CSound.mPickupWeapon);
        }
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Draw()
    {
        CThing_Crate.bmObject.mFrameIndex = (CThing_Crate.bmObject.mFrameIndex + 1) % CThing_Crate.bmObject.mFrameAmount;
        CCity._this.DrawBitmap(this,CThing_Crate.bmObject);
        this.mDrawn = true;
    }
}
