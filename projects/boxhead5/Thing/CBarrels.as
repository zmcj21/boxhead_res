package Thing
{
    import World.eWMCCollideType;
    
    public class CBarrels extends CThingWeapon
    {
        
        public static var _Upgrades:Array = [{
            "mName":"",
            "mAmmo":10,
            "mBiggerBang":0,
            "mClusterShells":0
        },{
            "mName":"Double ammo",
            "mAmmo":20,
            "mBiggerBang":0,
            "mClusterShells":0
        },{
            "mName":"Big bang",
            "mAmmo":20,
            "mBiggerBang":4,
            "mClusterShells":0
        },{
            "mName":"Quad ammo",
            "mAmmo":40,
            "mBiggerBang":4,
            "mClusterShells":0
        },{
            "mName":"Bigger bang",
            "mAmmo":40,
            "mBiggerBang":4,
            "mClusterShells":4
        }];
         
        
        private var mShotPIndex:int = 0;
        
        public function CBarrels(param1:*)
        {
            mShotPIndex = 0;
            super(param1);
            mUpgrade = 0;
            mFireRate = 0;
            mAutoFire = false;
            Process = Process_Normal;
            mFireAction = "placed";
            AddSound("Place",Barrel_Place);
        }
        
        override public function Fire() : void
        {
            if(mOwner.mCellCurrent.mCollide & 0)
            {
                return;
            }
            super.Fire();
            mPosition = mOwner.mPosition;
            mWorld.AddThing(new CBarrel({
                "mInitCell":mOwner.mCellCurrent,
                "mBiggerBang":mBiggerBang,
                "mClusterShells":mClusterShells
            },mOwner));
            PlaySound("Place");
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
            return "Barrels";
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
            return (HIGHPROBABILITY - LOWPROBABILITY) * (1 - mAmmo / mTotalAmmo) + LOWPROBABILITY;
        }
        
        override public function get mUpgrades() : Array
        {
            return _Upgrades;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CBarrels";
        }
    }
}
