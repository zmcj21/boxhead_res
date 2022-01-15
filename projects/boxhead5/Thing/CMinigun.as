package Thing
{
    public class CMinigun extends CThingWeapon
    {
        
        public static var _Upgrades:Array = [{
            "mName":"",
            "mAmmo":150,
            "mAutoFire":true,
            "mFireRate":0,
            "mDamage":25,
            "mThingsAffected":2,
            "mRange":12
        },{
            "mName":"Double ammo",
            "mAmmo":300,
            "mAutoFire":true,
            "mFireRate":0,
            "mDamage":50,
            "mThingsAffected":2,
            "mRange":12
        },{
            "mName":"Double damage",
            "mAmmo":300,
            "mAutoFire":true,
            "mFireRate":0,
            "mDamage":50,
            "mThingsAffected":3,
            "mRange":12
        },{
            "mName":"Quad ammo",
            "mAmmo":450,
            "mAutoFire":true,
            "mFireRate":0,
            "mDamage":100,
            "mThingsAffected":3,
            "mRange":12
        },{
            "mName":"Long range",
            "mAmmo":450,
            "mAutoFire":true,
            "mFireRate":0,
            "mDamage":100,
            "mThingsAffected":3,
            "mRange":20
        },{
            "mName":"Quad damage",
            "mAmmo":450,
            "mAutoFire":true,
            "mFireRate":0,
            "mDamage":100,
            "mThingsAffected":5,
            "mRange":20
        }];
         
        
        private var mShotPIndex:int = 0;
        
        public function CMinigun(param1:*)
        {
            mShotPIndex = 0;
            super(param1);
            Process = Process_Normal;
            mUpgrade = 0;
            AddSound("Minigun_Start",Minigun_Start,0);
            AddSound("Minigun_Stop",Minigun_Stop);
        }
        
        override public function Fire() : void
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            super.Fire();
            mPosition = mOwner.mPosition;
            mAngle = mOwner.mAngle;
            UpdateSound("Minigun_Start");
            ++mShotPIndex;
            _loc1_ = mParent.SpriteSheet_GetModelOffset("RSHOT");
            _loc2_ = new CThingV3(0,0,0.1).RotateX(89 * mShotPIndex * 0 / 180).RotateZ(mAngle.mAngleRAD).Add(_loc1_);
            AddThing(new CMuzzleFlash(mOwner,_loc2_,Large_MuzzleFlash));
            AddThing(new CBullet(mOwner,CAffect.BULLET(mOwner,this,mDamage),_loc2_,mThingsAffected,mRange,0.5));
        }
        
        override public function Fire_Stop() : void
        {
            super.Fire_Stop();
            StopSound("Minigun_Start");
            mPosition = mOwner.mPosition;
            PlaySound("Minigun_Stop");
        }
        
        public function Process_Normal() : *
        {
            WeaponUpdate();
            ProcessChildren();
        }
        
        override public function get mWeaponName() : String
        {
            return "Minigun";
        }
        
        override public function Fire_Start() : void
        {
            super.Fire_Start();
            mPosition = mOwner.mPosition;
            PlaySound("Minigun_Start",0,100000);
        }
        
        override public function get mAnimExt() : String
        {
            return "_minigun";
        }
        
        override public function get mPickupProbability() : Number
        {
            return MIDPROBABILITY * (1 - mAmmo / mTotalAmmo);
        }
        
        override public function get mUpgrades() : Array
        {
            return _Upgrades;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CMinigun";
        }
    }
}
