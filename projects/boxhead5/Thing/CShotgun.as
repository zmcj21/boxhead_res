package Thing
{
    public class CShotgun extends CThingWeapon
    {
        
        public static var _Upgrades:Array = [{
            "mName":"",
            "mAmmo":20,
            "mAutoFire":false,
            "mFireRate":12,
            "mDamage":50,
            "mRange":7,
            "mWideShot":0
        },{
            "mName":"Auto fire",
            "mAmmo":20,
            "mAutoFire":true,
            "mFireRate":12,
            "mDamage":50,
            "mRange":7,
            "mWideShot":0
        },{
            "mName":"Double ammo",
            "mAmmo":40,
            "mAutoFire":true,
            "mFireRate":12,
            "mDamage":50,
            "mRange":7,
            "mWideShot":0
        },{
            "mName":"Wide shot",
            "mAmmo":40,
            "mAutoFire":true,
            "mFireRate":12,
            "mDamage":50,
            "mRange":7,
            "mWideShot":1
        },{
            "mName":"Rapid fire",
            "mAmmo":40,
            "mAutoFire":true,
            "mFireRate":5,
            "mDamage":50,
            "mRange":7,
            "mWideShot":1
        },{
            "mName":"Long range",
            "mAmmo":40,
            "mAutoFire":true,
            "mFireRate":5,
            "mDamage":50,
            "mRange":11,
            "mWideShot":1
        },{
            "mName":"Quad ammo",
            "mAmmo":80,
            "mAutoFire":true,
            "mFireRate":5,
            "mDamage":50,
            "mRange":11,
            "mWideShot":1
        },{
            "mName":"Wider shot",
            "mAmmo":80,
            "mAutoFire":true,
            "mFireRate":5,
            "mDamage":50,
            "mRange":11,
            "mWideShot":2
        },{
            "mName":"Double damage",
            "mAmmo":80,
            "mAutoFire":true,
            "mFireRate":5,
            "mDamage":100,
            "mRange":11,
            "mWideShot":2
        }];
         
        
        private var mShotPIndex:int = 0;
        
        public function CShotgun(param1:*)
        {
            mShotPIndex = 0;
            super(param1);
            mUpgrade = 0;
            Process = Process_Normal;
            AddSound("Shot",Shotgun_Shot1);
        }
        
        override public function Fire() : void
        {
            var _loc1_:* = null;
            super.Fire();
            mPosition = mOwner.mPosition;
            mAngle = mOwner.mAngle;
            _loc1_ = mParent.SpriteSheet_GetModelOffset("RSHOT");
            AddThing(new CMuzzleFlash(mOwner,_loc1_,Large_MuzzleFlash));
            AddThing(new CShotgunBullet(mOwner,CAffect.BULLET(mOwner,this,mDamage),_loc1_,mRange,mWideShot));
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
            return "Shotgun";
        }
        
        override public function Fire_Start() : void
        {
            super.Fire_Start();
        }
        
        override public function get mAnimExt() : String
        {
            return "_shotgun";
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
            return "CShotgun";
        }
    }
}
