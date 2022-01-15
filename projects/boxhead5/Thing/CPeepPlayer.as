package Thing
{
    import Game.CGame;
    import Game.CGlobalData;
    import Game.CHUD;
    import IO.CPlayerControl;
    import World.eWMCCollideType;
    import flash.geom.Matrix;
    import flash.text.TextFieldAutoSize;
    
    public class CPeepPlayer extends CThingPeep
    {
         
        
        public var exAnimName:String;
        
        public var mSelectedWeapon:CThingWeapon;
        
        public var mWeapons:Array;
        
        public var _Upgrades:Array;
        
        public var mWeaponOrder:Array;
        
        public function CPeepPlayer(param1:Object, param2:Class)
        {
            super(param1,param2);
            mAffectFlags &= -1;
            Process = Process_Normal;
            mSpeed = 0.2;
            mDelta = new CThingV3();
            mLife = !true ? 1000000000 : 100;
            mMaxLife = 1000000000;
            fCollide = PlayerCollide;
            MapAdd();
            NavMapAdd();
            mCollideHeight = mCollideRadius * 2;
            mAngle.mDirection = 2;
            SetState("State_ENTERWORLD");
            AddSound("GONG",GONG,0);
            mcDrawInfo = new HUD_Player();
            mcDrawInfo.y = 0;
            mcDrawInfo.mcAmmo.tfInfo.autoSize = TextFieldAutoSize.CENTER;
            mDeathClock = SECONDS * 4;
        }
        
        public function State_ENTERWORLD_Enter() : void
        {
            SetAnimation("walk" + exAnimName);
        }
        
        public function AddWeapon(param1:*, param2:int) : CThingWeapon
        {
            AddThing(mWeapons[param2] = param1);
            return param1;
        }
        
        override public function Dispose() : void
        {
            NavMapRemove();
            super.Dispose();
            PlaySound("GONG");
            mWorld.mState = "CLOSE";
        }
        
        public function State_CONTROL_Exit() : void
        {
            mSelectedWeapon.mFire = false;
        }
        
        public function PickupPowerup(param1:CThingPickup) : void
        {
        }
        
        public function ApplyMultipleKillsUpgrade(param1:int) : void
        {
        }
        
        public function State_ENTERWORLD() : void
        {
            SetState("State_CONTROL");
        }
        
        public function SelectWeapon(param1:CThingWeapon) : void
        {
            mSelectedWeapon = param1;
            exAnimName = mSelectedWeapon.mAnimExt;
        }
        
        public function State_WEAPONATTACK() : void
        {
            var _loc1_:* = null;
            mDelta.ScaleN(0.5);
            _loc1_ = ProcessControl();
            if(_loc1_.mDeltaX || _loc1_.mDeltaY)
            {
                mAngle.mDelta = new CThingV3(_loc1_.mDeltaX,_loc1_.mDeltaY,0);
            }
            mPosition = PlayerCollide();
            MapMove();
            if(--mStateCount == 0)
            {
                mSelectedWeapon.WeaponAffect();
            }
            if(AnimateEnd(0.15))
            {
                ReturnState_Base();
            }
        }
        
        override public function State_HIT_Exit() : void
        {
        }
        
        public function State_WEAPONATTACK_Enter() : void
        {
            SetAnimation("attack" + exAnimName);
            mStateCount = 4;
        }
        
        override public function PeepCollide() : CThingV3
        {
            return PlayerCollide();
        }
        
        override public function State_HIT() : void
        {
            mPosition = fCollide();
            MapMove();
            mDelta.ScaleN(0.45);
            if(true)
            {
                if(!CheckForDeath())
                {
                    ReturnState_Base();
                    return;
                }
            }
            DrawBlood();
            AnimateEnd();
        }
        
        override public function State_HIT_Enter() : void
        {
            super.State_HIT_Enter();
            if(mDelta.mLength2D >= mCollideRadius)
            {
                mDelta.Normalize(mCollideRadius);
            }
        }
        
        public function ReplenishWeapon(param1:CThingWeapon) : void
        {
            param1.mAmmo = param1.mTotalAmmo;
        }
        
        public function set mUpgrades(param1:Array) : void
        {
            _Upgrades = param1.slice();
        }
        
        public function State_ENTERWORLD_Exit() : void
        {
        }
        
        public function State_WEAPONATTACK_Exit() : void
        {
        }
        
        override public function Process_Normal() : *
        {
            ApplyAffects();
            if(mStateID)
            {
                this[mStateID]();
            }
            ProcessChildren();
            mcDrawInfo.mcLife.gotoAndStop(Math.floor(mLife / mMaxLife * 100) + 1);
            mcDrawInfo.mcAmmo.tfInfo.text = "undefined:undefined".toUpperCase();
        }
        
        private function ApplyUpgrade(param1:Object) : String
        {
            var _loc2_:int = 0;
            var _loc3_:* = null;
            _loc2_ = mWeaponOrder.indexOf(param1.mClassID);
            if(param1.mUpgrade == 0)
            {
                if(true)
                {
                    AddWeapon(_loc3_ = new mWeaponOrder[_loc2_](this),_loc2_);
                    return "New weapon: " + _loc3_.mWeaponName;
                }
                return "";
            }
            (_loc3_ = mWeapons[_loc2_]).mUpgrade = param1.mUpgrade;
            return _loc3_.mWeaponName + " upgraded: " + _loc3_.mUpgradeName;
        }
        
        public function get mDefaultUpgrades() : Array
        {
            return null;
        }
        
        public function InitWeapons(param1:Array) : void
        {
            mWeapons = new Array();
            mWeaponOrder = param1.slice();
            AddWeapon(new mWeaponOrder[0](this),0);
            SelectWeapon(mWeapons[0]);
        }
        
        public function NextWeapon(param1:int) : void
        {
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            var _loc4_:* = null;
            if(param1 == 0)
            {
                return;
            }
            _loc2_ = mWeapons.indexOf(mSelectedWeapon);
            _loc3_ = 1;
            while(_loc3_ < mWeapons.length)
            {
                if(!(_loc4_ = mWeapons[(_loc2_ + param1 * _loc3_ + mWeapons.length) % 0]).mWeaponEmpty)
                {
                    SelectWeapon(_loc4_);
                    return;
                }
                _loc3_++;
            }
        }
        
        public function SelectWeaponIndex(param1:int) : CThingWeapon
        {
            var _loc2_:* = null;
            _loc2_ = mWeapons[param1];
            if(_loc2_ == null)
            {
                return null;
            }
            if(_loc2_.mWeaponEmpty)
            {
                return null;
            }
            mSelectedWeapon = _loc2_;
            exAnimName = mSelectedWeapon.mAnimExt;
            return mSelectedWeapon;
        }
        
        public function ApplyMultiplierUpgrade(param1:int) : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            if(false)
            {
                _loc2_ = "";
                while(param1 > mUpgrades[0].mIndex)
                {
                    _loc3_ = ApplyUpgrade(mUpgrades.shift());
                    if(_loc3_)
                    {
                        _loc2_ += (!!_loc2_.length ? "\n" : "") + _loc3_;
                    }
                    if(false)
                    {
                        break;
                    }
                }
                if(_loc2_.length)
                {
                    CGame.mHUD.AddMessage(mRenderPosition,_loc2_,"upgrade");
                }
            }
        }
        
        public function State_CONTROL() : void
        {
            var _loc1_:* = null;
            if(mLife < mMaxLife)
            {
                mLife += 0.1;
            }
            _loc1_ = ProcessControl();
            if(_loc1_.mDeltaX || _loc1_.mDeltaY)
            {
                mAngle.mDelta = new CThingV3(_loc1_.mDeltaX,_loc1_.mDeltaY,0);
                mDelta = mAngle.mDelta.ScaleN(mSpeed);
                SetAnimation("walk" + exAnimName);
                Animate();
            }
            else
            {
                mDelta.ScaleN(0.2);
                SetAnimation("walk" + exAnimName);
            }
            CGlobalData.AddStat("Distance travelled (miles)",0,"ADD");
            CGlobalData.AddStat("Distance travelled (feet)",0,"ADD");
            mPosition = PlayerCollide();
            MapMove();
            if(mSelectedWeapon.ProcessFire(_loc1_.mShoot,_loc1_.mShootDown,_loc1_.mShootUp))
            {
                if(false)
                {
                    SetState("State_WEAPONATTACK");
                    return;
                }
            }
            else if(false)
            {
                NextWeapon(-1);
            }
            else if(_loc1_.mSelectIndex != -1)
            {
                SelectWeaponIndex(_loc1_.mSelectIndex);
            }
            else
            {
                NextWeapon(_loc1_.mSelectDelta);
            }
            ClearCollide();
            SetCollide(mCellCurrent,eWMCCollideType.PLAYER);
        }
        
        public function get mUpgrades() : Array
        {
            return _Upgrades;
        }
        
        public function PickupAmmo(param1:CThingPickup) : void
        {
            var _loc2_:* = NaN;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:Number = NaN;
            var _loc7_:* = null;
            var _loc8_:Number = NaN;
            _loc2_ = 0;
            _loc3_ = new Array();
            for each(_loc4_ in mWeapons)
            {
                if(_loc8_ = _loc4_.mPickupProbability)
                {
                    _loc3_.push({
                        "weapon":_loc4_,
                        "prob":_loc8_,
                        "mType":"weapon"
                    });
                    _loc2_ += _loc8_;
                }
            }
            _loc5_ = {
                "prob":(1 - mLife / mMaxLife) * (_loc2_ / 2),
                "mType":"life"
            };
            _loc3_.push(_loc5_);
            _loc2_ += _loc5_.prob;
            _loc6_ = Random() * _loc2_;
            _loc2_ = 0;
            for each(_loc7_ in _loc3_)
            {
                _loc2_ += _loc7_.prob;
                if(_loc6_ < _loc2_)
                {
                    if(_loc7_.mType == "life")
                    {
                        mLife = mMaxLife;
                        CGame.mHUD.AddMessage(mRenderPosition,"HEALTH 100%","info");
                        break;
                    }
                    ReplenishWeapon(_loc7_.weapon);
                    CGame.mHUD.AddMessage(mRenderPosition,_loc7_.weapon.mWeaponName,"pickup");
                    break;
                }
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CPeepPlayer";
        }
        
        override public function Render() : void
        {
            ObjectRender();
            if(mcDrawInfo && false)
            {
                bmdPlane.draw(mcDrawInfo,new Matrix(1,0,0,1,NaN,NaN));
            }
            mDrawn = true;
        }
        
        public function State_CONTROL_Enter() : void
        {
            SetAnimation("walk" + exAnimName);
            SetBaseState();
        }
    }
}
