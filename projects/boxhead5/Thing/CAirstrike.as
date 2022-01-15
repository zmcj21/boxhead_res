package Thing
{
    public class CAirstrike extends CThingWeapon
    {
        
        public static var _Upgrades:Array = [{
            "mName":"Carpet bombs",
            "mAmmo":2,
            "mUpgradeID":"carpet"
        },{
            "mName":"Small nuke",
            "mAmmo":2,
            "mUpgradeID":"snuke"
        },{
            "mName":"Double ammo",
            "mAmmo":4,
            "mUpgradeID":"nuke"
        },{
            "mName":"Nuke",
            "mAmmo":2,
            "mUpgradeID":"nuke"
        }];
         
        
        private var mShotPIndex:int = 0;
        
        public function CAirstrike(param1:*)
        {
            mShotPIndex = 0;
            super(param1);
            mUpgrade = 0;
            mFireRate = 200;
            mAutoFire = false;
            Process = Process_Normal;
            mFireAction = "called";
        }
        
        override public function Fire() : void
        {
            super.Fire();
            mAngle = mOwner.mAngle.Clone();
            mPosition = mOwner.mPosition;
            AddThing(new CSAirstrike({"mPosition":mOwner.mPosition},mOwner,mUpgradeID));
        }
        
        override public function Fire_Stop() : void
        {
            super.Fire_Stop();
        }
        
        public function Process_Normal() : *
        {
            WeaponUpdate();
            ProcessChildren();
        }
        
        override public function get mWeaponName() : String
        {
            return "Airstrikes";
        }
        
        override public function Fire_Start() : void
        {
            super.Fire_Start();
        }
        
        override public function get mAnimExt() : String
        {
            return "";
        }
        
        override public function get mPickupProbability() : Number
        {
            return LOWPROBABILITY * (1 - mAmmo / mTotalAmmo);
        }
        
        override public function get mUpgrades() : Array
        {
            return _Upgrades;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CAirstrike";
        }
    }
}
