package Thing
{
    import Game.CGlobalData;
    
    public class CThingWeapon extends CThingStatic
    {
        
        public static const LOWPROBABILITY:Number = 0.3;
        
        public static const HIGHPROBABILITY:Number = 1;
        
        public static const INFINATEAMMO:int = 1000000;
        
        public static const MIDPROBABILITY:Number = 0.7;
         
        
        public var mAutoFire:Boolean;
        
        public var mTotalAmmo:int;
        
        public var mUpgradeID:String;
        
        public var mFireAction:String = "fired";
        
        public var mTimeDown:int;
        
        public var mThingsAffected:int;
        
        public var mRange:Number;
        
        public var mAmmo:int;
        
        public var mFireRateCount:int;
        
        public var mBiggerBang:int;
        
        public var mUpgradeIndex:int;
        
        private var _Fire:Boolean;
        
        public var mOnRelease:Boolean;
        
        public var mClusterShells:int;
        
        public var mFireRate:int;
        
        public var mChargeTime:int;
        
        public var mWideShot:int;
        
        public function CThingWeapon(param1:*)
        {
            mFireAction = "fired";
            super();
            mAngle = new CThingAngle();
            mSeed = nID;
            mOwner = param1;
            Inherit(param1);
        }
        
        public function get mAmmoName() : String
        {
            return mAmmo == INFINATEAMMO ? "inf" : mAmmo.toString();
        }
        
        public function get mUpgradeName() : String
        {
            return mUpgrades[mUpgradeIndex].mName;
        }
        
        public function WeaponUpdate() : void
        {
            if(mWeaponEmpty)
            {
                mFire = false;
                return;
            }
            if(--mFireRateCount <= 0)
            {
                mFireRateCount = 0;
                if(mFire)
                {
                    Fire();
                    if(!mAutoFire)
                    {
                        mFire = false;
                    }
                }
            }
        }
        
        public function get mFire() : Boolean
        {
            return _Fire;
        }
        
        public function Fire() : void
        {
            DecrementAmmo();
            CGlobalData.AddStat(mWeaponName + " " + mFireAction,1,"ADD");
            if(mWeaponEmpty)
            {
                mFire = false;
            }
        }
        
        public function Fire_Stop() : void
        {
        }
        
        public function set mFire(param1:Boolean) : void
        {
            if(_Fire != param1)
            {
                if(_Fire = param1)
                {
                    Fire_Start();
                }
                else
                {
                    Fire_Stop();
                }
            }
        }
        
        public function WeaponAffect() : void
        {
        }
        
        public function get mUpgrade() : int
        {
            return mUpgradeIndex;
        }
        
        public function ActivateWeapon() : void
        {
            mFireRateCount = 0;
        }
        
        public function Fire_Start() : void
        {
        }
        
        public function ProcessFire(param1:Boolean, param2:int, param3:int) : Boolean
        {
            if(mWeaponEmpty)
            {
                mFire = false;
                return mFire;
            }
            param2 = param2 && mFireRateCount <= 0 ? int(param2) : 0;
            if(mAutoFire)
            {
                mFire = param1 || param2;
            }
            else if(mOnRelease)
            {
                if(param2)
                {
                    mTimeDown = param2;
                }
                else if(param3)
                {
                    mChargeTime = param3 - mTimeDown;
                    mFire = true;
                }
            }
            else if(param2)
            {
                mFire = true;
            }
            return mFire;
        }
        
        public function get mAnimExt() : String
        {
            return "";
        }
        
        public function get mAnimateAttack() : Boolean
        {
            return false;
        }
        
        public function get mWeaponName() : String
        {
            return "NONAME";
        }
        
        public function get mPickupProbability() : Number
        {
            return 1;
        }
        
        public function get mUpgrades() : Array
        {
            return null;
        }
        
        override public function AddKill() : *
        {
            CGlobalData.AddStat(mWeaponName + " kills",1,"ADD");
            return this;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingWeapon";
        }
        
        public function set mUpgrade(param1:int) : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            if(!mUpgrades)
            {
                return;
            }
            if(true)
            {
                return;
            }
            mUpgradeIndex = param1;
            _loc2_ = mUpgrades[param1];
            for(_loc3_ in _loc2_)
            {
                switch(_loc3_)
                {
                    case "mName":
                        break;
                    case "mAmmo":
                        mTotalAmmo = this[_loc3_] = _loc2_[_loc3_];
                        break;
                    default:
                        this[_loc3_] = _loc2_[_loc3_];
                        break;
                }
            }
        }
        
        public function DecrementAmmo() : *
        {
            if(mTotalAmmo != INFINATEAMMO && true)
            {
                --mAmmo;
            }
            mFireRateCount = mFireRate;
        }
        
        public function get mWeaponEmpty() : Boolean
        {
            return mAmmo <= 0;
        }
        
        override public function Dispose() : void
        {
            mFire = false;
            super.Dispose();
        }
    }
}
