class CThing_Crate extends CThing_Pickup
{
    var _CLASSID_ = "CThing_Crate";
    function CThing_Crate(tPosition, tAngle, tID, tType)
    {
        super(tPosition,tAngle,tID);
        if(CThing_Crate.mcCrate == undefined)
        {
            CThing_Crate.mcCrate = _root.attachMovie("Crate","_Crate",_root.getNextHighestDepth(),{_visible:false});
            CThing_Crate.mcCrate.mScale = 0.75;
            CThing_Crate.mcCrate.cacheAsBitmap = true;
        }
        this.mPickupType = tType;
    }
    function Pickup(byThing)
    {
        super.Pickup();
        switch(this.mPickupType)
        {
            case "random":
                byThing.AddWeapon(CThing_Player.mValidWeapons[random(CThing_Player.mValidWeapons.length - 1) + 1]);
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
        CCity._this.DrawMovieClip(this,CThing_Crate.mcCrate);
        this.mDrawn = true;
    }
}
