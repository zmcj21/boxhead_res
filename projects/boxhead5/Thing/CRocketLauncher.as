package Thing
{
    public class CRocketLauncher extends CThingWeapon
    {
        
        public static var _Upgrades:Array = [{
            "mName":"",
            "mAmmo":20,
            "mBiggerBang":0,
            "mClusterShells":0,
            "mAutoFire":false,
            "mFireRate":12
        },{
            "mName":"Double ammo",
            "mAmmo":40,
            "mBiggerBang":0,
            "mClusterShells":0,
            "mAutoFire":false,
            "mFireRate":12
        },{
            "mName":"Fast fire",
            "mAmmo":40,
            "mBiggerBang":0,
            "mClusterShells":0,
            "mAutoFire":false,
            "mFireRate":6
        },{
            "mName":"Big bang",
            "mAmmo":40,
            "mBiggerBang":4,
            "mClusterShells":0,
            "mAutoFire":false,
            "mFireRate":6
        },{
            "mName":"Quad ammo",
            "mAmmo":80,
            "mBiggerBang":4,
            "mClusterShells":0,
            "mAutoFire":false,
            "mFireRate":6
        },{
            "mName":"Bigger bang",
            "mAmmo":80,
            "mBiggerBang":4,
            "mClusterShells":4,
            "mAutoFire":false,
            "mFireRate":6
        },{
            "mName":"Rapid fire",
            "mAmmo":80,
            "mBiggerBang":4,
            "mClusterShells":4,
            "mAutoFire":true,
            "mFireRate":3
        }];
         
        
        private var mShotPIndex:int = 0;
        
        public function CRocketLauncher(param1:*)
        {
            mShotPIndex = 0;
            super(param1);
            mUpgrade = 0;
            Process = Process_Normal;
            AddSound("Shot",Rocket_Shot1);
        }
        
        override public function Fire() : void
        {
            var _loc1_:* = null;
            super.Fire();
            mPosition = mOwner.mPosition;
            mAngle = mOwner.mAngle;
            ++mShotPIndex;
            _loc1_ = mParent.SpriteSheet_GetModelOffset("RSHOT");
            AddThing(new CMuzzleFlash_Large(mOwner,_loc1_));
            AddThing(new CMissile(mOwner,CAffect.BULLET(mOwner,this,50),_loc1_));
            PlaySound("Shot");
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
            return "Rockets";
        }
        
        override public function Fire_Start() : void
        {
            super.Fire_Start();
        }
        
        override public function get mAnimExt() : String
        {
            return "_rocket";
        }
        
        override public function get mPickupProbability() : Number
        {
            return MIDPROBABILITY * (1 - mAmmo / mTotalAmmo) + MIDPROBABILITY;
        }
        
        override public function get mUpgrades() : Array
        {
            return _Upgrades;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CRocketLauncher";
        }
    }
}
