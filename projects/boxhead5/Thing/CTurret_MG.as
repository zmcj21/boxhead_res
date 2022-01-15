package Thing
{
    import World.eWMCCollideType;
    
    public class CTurret_MG extends CThingTurret
    {
         
        
        public function CTurret_MG(param1:Object, param2:* = null, param3:* = null)
        {
            super(param1,param2,param3);
            if(isNaN(mAmmo) || mAmmo == 0)
            {
                mFireRate = CWTurret_MG._Upgrades[0].mTurretFireRate;
                mAutoFire = false;
                mTotalAmmo = mAmmo = CWTurret_MG._Upgrades[0].mTurretAmmo;
                mRange = CWTurret_MG._Upgrades[0].mRange;
            }
            mCollideRadius = 0.4;
            mCollideHeight = mCollideRadius * 2;
            SetCollide(mCellCurrent,eWMCCollideType.TURRET);
            mMaxLife = mLife = 250;
            if(!SpriteSheetExists(_CLASSID_))
            {
                AddSpriteSheet(_CLASSID_,new SheetTurret_MG(0,0),true);
            }
            AddSound("shot0",Turret_MG_Shot_1,1);
            AddSound("shot1",Turret_MG_Shot_2,1);
            AddSound("shot2",Turret_MG_Shot_3,1);
            SetState("State_GROWRADIUS","State_SEARCH");
            SetupRange(0,mRange);
            mTurnSpeed = CThingAngle.AsAngle256(5);
        }
        
        override public function Fire() : void
        {
            var _loc1_:* = null;
            super.Fire();
            _loc1_ = SpriteSheet_GetModelOffset("SHOT");
            AddThing(new CBullet(this,CAffect.BULLET(this,this,25),_loc1_,1,mRange + 1));
            AddThing(new CMuzzleFlash(this,_loc1_,Large_MuzzleFlash));
            PlaySound("shot" + Math.floor(Math.random() * 3));
        }
        
        override public function get mWeaponName() : String
        {
            return "Turret Gun";
        }
        
        override public function get _CLASSID_() : String
        {
            return "CTurret_MG";
        }
    }
}
