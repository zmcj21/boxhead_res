package Thing
{
    import World.eWMCCollideType;
    
    public class CWTurret_MG extends CThingWeapon
    {
        
        public static var _Upgrades:Array = [{
            "mName":"",
            "mAmmo":2,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":6,
            "mTurretFireRate":6,
            "mTurretAmmo":50
        },{
            "mName":"Double ammo",
            "mAmmo":4,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":6,
            "mTurretFireRate":6,
            "mTurretAmmo":100
        },{
            "mName":"Fast fire",
            "mAmmo":4,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":6,
            "mTurretFireRate":4,
            "mTurretAmmo":100
        },{
            "mName":"Rapid fire",
            "mAmmo":4,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":6,
            "mTurretFireRate":2,
            "mTurretAmmo":100
        },{
            "mName":"Triple ammo",
            "mAmmo":8,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":6,
            "mTurretFireRate":2,
            "mTurretAmmo":150
        },{
            "mName":"Longer range",
            "mAmmo":8,
            "mAutoFire":false,
            "mFireRate":0,
            "mRange":9,
            "mTurretFireRate":2,
            "mTurretAmmo":150
        }];
         
        
        private var mShotPIndex:int = 0;
        
        public var mTurretAmmo:int;
        
        public var mTurretFireRate:int;
        
        public function CWTurret_MG(param1:*)
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
            mWorld.AddThing(new CTurret_MG({"mInitCell":mOwner.mCellCurrent},mOwner,this));
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
            return "Turret Gun";
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
            return LOWPROBABILITY * (1 - (mAmmo + CountChildren("CTurret_MG")) / (mTotalAmmo * 2));
        }
        
        override public function get mUpgrades() : Array
        {
            return _Upgrades;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CWTurret_MG";
        }
        
        override public function set mUpgrade(param1:int) : void
        {
            super.mUpgrade = param1;
        }
    }
}
