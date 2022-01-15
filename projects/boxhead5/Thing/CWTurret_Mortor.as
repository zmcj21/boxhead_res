package Thing
{
    import World.eWMCCollideType;
    
    public class CWTurret_Mortor extends CThingWeapon
    {
        
        public static var _Upgrades:Array = [{
            "mName":"",
            "mAmmo":2,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":9,
            "mTurretFireRate":SECONDS * 2,
            "mTurretAmmo":25
        },{
            "mName":"Double ammo",
            "mAmmo":4,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":9,
            "mTurretFireRate":SECONDS * 2,
            "mTurretAmmo":50
        },{
            "mName":"Faster fire",
            "mAmmo":6,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":9,
            "mTurretFireRate":SECONDS * 1,
            "mTurretAmmo":75
        },{
            "mName":"Triple ammo",
            "mAmmo":6,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":9,
            "mTurretFireRate":SECONDS * 1,
            "mTurretAmmo":75
        },{
            "mName":"Long range",
            "mAmmo":6,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":15,
            "mTurretFireRate":SECONDS * 1,
            "mTurretAmmo":75
        }];
         
        
        private var mShotPIndex:int = 0;
        
        public var mTurretAmmo:int;
        
        public var mTurretFireRate:int;
        
        public var mTurretDamage:int;
        
        public function CWTurret_Mortor(param1:*)
        {
            mShotPIndex = 0;
            super(param1);
            mUpgrade = 0;
            Process = Process_Normal;
            AddSound("Place",Turret_Place);
            mFireAction = "placed";
        }
        
        override public function Fire() : void
        {
            if(mOwner.mCellCurrent.mCollide & 0)
            {
                return;
            }
            super.Fire();
            mPosition = mOwner.mPosition;
            mWorld.AddThing(new CTurret_Mortor({"mInitCell":mOwner.mCellCurrent},mOwner,this));
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
            return "Turret Mortor";
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
            return LOWPROBABILITY * (1 - (mAmmo + CountChildren("CTurret_Mortor")) / (mTotalAmmo * 2));
        }
        
        override public function get mUpgrades() : Array
        {
            return _Upgrades;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CWTurret_Mortor";
        }
    }
}
