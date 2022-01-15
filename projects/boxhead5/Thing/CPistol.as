package Thing
{
    public class CPistol extends CThingWeapon
    {
        
        public static var _Upgrades:Array = [{
            "mName":"",
            "mAmmo":INFINATEAMMO,
            "mAutoFire":false,
            "mFireRate":8,
            "mDamage":50,
            "mRange":8
        },{
            "mName":"Crack shot",
            "mAmmo":INFINATEAMMO,
            "mAutoFire":false,
            "mFireRate":8,
            "mDamage":100,
            "mRange":8
        },{
            "mName":"Auto fire",
            "mAmmo":INFINATEAMMO,
            "mAutoFire":true,
            "mFireRate":8,
            "mDamage":100,
            "mRange":8
        },{
            "mName":"Long range",
            "mAmmo":INFINATEAMMO,
            "mAutoFire":true,
            "mFireRate":8,
            "mDamage":100,
            "mRange":16
        }];
         
        
        private var mShotPIndex:int = 0;
        
        public function CPistol(param1:*)
        {
            mShotPIndex = 0;
            super(param1);
            mUpgrade = 0;
            Process = Process_Normal;
            AddSound("Shot",Pistol_Shot1);
        }
        
        override public function Fire() : void
        {
            var _loc1_:* = null;
            super.Fire();
            mPosition = mOwner.mPosition;
            mAngle = mOwner.mAngle;
            _loc1_ = mParent.SpriteSheet_GetModelOffset("RSHOT");
            AddThing(new CMuzzleFlash(mOwner,_loc1_,Medium_MuzzleFlash));
            AddThing(new CBullet(mOwner,CAffect.BULLET(mOwner,this,mDamage),_loc1_,1,mRange));
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
            return "Pistol";
        }
        
        override public function Fire_Start() : void
        {
            super.Fire_Start();
        }
        
        override public function get mAnimExt() : String
        {
            return "_pistol";
        }
        
        override public function get mPickupProbability() : Number
        {
            return 0;
        }
        
        override public function get mUpgrades() : Array
        {
            return _Upgrades;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CPistol";
        }
    }
}
