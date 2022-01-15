package Thing
{
    public class CGrenades extends CThingWeapon
    {
        
        public static var _Upgrades:Array = [{
            "mName":"",
            "mAmmo":20,
            "mBiggerBang":0,
            "mClusterShells":0
        },{
            "mName":"Double ammo",
            "mAmmo":40,
            "mBiggerBang":0,
            "mClusterShells":0
        },{
            "mName":"Big bang",
            "mAmmo":40,
            "mBiggerBang":4,
            "mClusterShells":0
        },{
            "mName":"Quad ammo",
            "mAmmo":80,
            "mBiggerBang":4,
            "mClusterShells":0
        },{
            "mName":"Bigger bang",
            "mAmmo":80,
            "mBiggerBang":4,
            "mClusterShells":4
        }];
         
        
        public function CGrenades(param1:*)
        {
            mFireRate = 10;
            mAutoFire = false;
            mOnRelease = true;
            Process = Process_Normal;
            mUpgrade = 0;
            mFireAction = "thrown";
            super(param1);
        }
        
        override public function Fire() : void
        {
            var _loc1_:* = null;
            super.Fire();
            mPosition = mOwner.mPosition;
            mAngle = mOwner.mAngle;
            _loc1_ = new CThingV3(0,0,mOwner.mCollideHeight);
            AddThing(new CSGrenade(mOwner,_loc1_,mChargeTime / 1000,{
                "mBiggerBang":mBiggerBang,
                "mClusterShells":mClusterShells
            }));
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
            return "Grenades";
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
            return "CGrenades";
        }
    }
}
