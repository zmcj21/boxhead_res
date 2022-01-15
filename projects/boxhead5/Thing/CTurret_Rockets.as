package Thing
{
    import World.eWMCCollideType;
    
    public class CTurret_Rockets extends CThingTurret
    {
         
        
        private var mShotIndex:int;
        
        public function CTurret_Rockets(param1:Object, param2:* = null, param3:* = null)
        {
            super(param1,param2,param3);
            if(isNaN(mAmmo) || mAmmo == 0)
            {
                mFireRate = CWTurret_Rockets._Upgrades[0].mTurretFireRate;
                mAutoFire = false;
                mTotalAmmo = mAmmo = CWTurret_Rockets._Upgrades[0].mTurretAmmo;
                mRange = CWTurret_Rockets._Upgrades[0].mRange;
            }
            mCollideRadius = 0.4;
            mCollideHeight = mCollideRadius * 2;
            SetCollide(mCellCurrent,eWMCCollideType.TURRET);
            mMaxLife = mLife = 80;
            if(!SpriteSheetExists(_CLASSID_))
            {
                AddSpriteSheet(_CLASSID_,new SheetTurret_Rockets(0,0),true);
            }
            AddSound("Shot",Rocket_Shot1);
            SetState("State_GROWRADIUS","State_SEARCH");
            mShotIndex = 0;
            SetupRange(3,mRange);
            mTurnSpeed = CThingAngle.AsAngle256(3);
        }
        
        override public function Fire() : void
        {
            var _loc1_:* = null;
            super.Fire();
            mShotIndex = (mShotIndex + 1) % 8;
            _loc1_ = SpriteSheet_GetModelOffset("SHOT" + (mShotIndex + 1));
            AddThing(new CMissile(this,CAffect.BULLET(this,this,50),_loc1_,100));
            AddThing(new CMuzzleFlash(this,_loc1_,Large_MuzzleFlash));
            PlaySound("Shot");
        }
        
        override public function get mWeaponName() : String
        {
            return "Turret Rockets";
        }
        
        override public function get _CLASSID_() : String
        {
            return "CTurret_Rockets";
        }
    }
}
