package Thing
{
    import Game.CHUD;
    import World.CWMCNavigation;
    import World.CWMCell;
    import World.eWMCCollideType;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.text.TextFieldAutoSize;
    
    public class CThingTurret extends CThingWeapon
    {
        
        private static var mAllocateProcessID:int = 0;
         
        
        public const mRicochetAmount:int = 3;
        
        private var mSearchQuadrants_Monitor:Object;
        
        private var mAngleDelta:CThingAngle;
        
        public var mTargetRange:Number;
        
        private var mAngleTarget:CThingAngle;
        
        private var mMinRange:int;
        
        private var mTurretTarget:CThingPeep;
        
        private var mMaxRange:int;
        
        public var mTurnSpeed:CThingAngle;
        
        private var mAddCellIndex:Object;
        
        private var mSearchCells:Array;
        
        public function CThingTurret(param1:Object, param2:* = null, param3:* = null)
        {
            super(param2);
            nProcessID = ++mAllocateProcessID;
            mSeed = nID;
            mAngle = new CThingAngle();
            mAngle.mAngle256 = RandomInt(256);
            SetPositionByInitObject(param1);
            mCollideRadius = !!param1.mCollideRadius ? Number(param1.mCollideRadius) : Number(0.5);
            mCollideHeight = mCollideRadius * 2;
            mAffectFlags = 0 | 0 | 0 | 0 | 0 | 0;
            mAffectFlags |= 0 | 0;
            if(param3)
            {
                mFireRate = param3.mTurretFireRate;
                mAutoFire = false;
                mTotalAmmo = mAmmo = param3.mTurretAmmo;
                mRange = param3.mRange;
            }
            MapAdd();
            Process = Process_Normal;
            mAudioMaterial = "METAL";
            NavMapAdd();
            mAngleTarget = new CThingAngle();
            mTurnSpeed = CThingAngle.AsAngle256(2);
            if(mOwner)
            {
                mcDrawInfo = new HUD_Turret();
                mcDrawInfo.y = 0;
                mcDrawInfo.mcAmmo.tfInfo.autoSize = TextFieldAutoSize.CENTER;
            }
            mFireAction = "fired";
        }
        
        public static function Restart() : void
        {
            mAllocateProcessID = 0;
        }
        
        override public function Dispose() : void
        {
            var _loc1_:* = null;
            for each(_loc1_ in mSearchCells)
            {
                _loc1_.RemoveMonitor(mID);
            }
            super.Dispose();
        }
        
        override public function Fire() : void
        {
            super.Fire();
            if(mAmmo <= 0)
            {
                Destroyed();
            }
        }
        
        public function State_SEARCH_Enter() : void
        {
            SetBaseState();
            mFire = false;
        }
        
        public function State_IDLE_Exit() : void
        {
        }
        
        public function State_SEARCH_Exit() : void
        {
        }
        
        public function ApplyAffects() : Boolean
        {
            var _loc1_:* = null;
            if(mAffects)
            {
                for each(_loc1_ in mAffects)
                {
                    this["Affect_" + _loc1_.mName](_loc1_);
                }
                mAffects = null;
                if(mDead)
                {
                    return Destroyed();
                }
            }
            return false;
        }
        
        public function State_IDLE() : void
        {
            if(--mStateCount < 0)
            {
                SetState("State_SEARCH");
            }
        }
        
        override public function Affect_FIRE(param1:CAffect) : void
        {
            mLife -= param1.mDamage / 8;
        }
        
        public function SetupRange(param1:Number, param2:Number) : void
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:Number = NaN;
            var _loc6_:Number = NaN;
            var _loc7_:int = 0;
            var _loc8_:int = 0;
            var _loc9_:Number = NaN;
            var _loc10_:* = null;
            var _loc11_:* = null;
            mMinRange = param1;
            mMaxRange = param2;
            _loc3_ = new Point(mPosition.x,mPosition.y);
            mSearchCells = new Array();
            mAddCellIndex = 0;
            mSearchQuadrants_Monitor = new Object();
            for each(_loc4_ in CThingAngle.mDirectionNames)
            {
                mSearchQuadrants_Monitor[_loc4_] = new Object();
            }
            _loc5_ = Math.pow(mMaxRange + 0.5,2);
            _loc6_ = Math.pow(mMinRange - 0.5,2);
            _loc7_ = -mMaxRange;
            while(_loc7_ <= mMaxRange)
            {
                _loc8_ = -mMaxRange;
                while(_loc8_ <= mMaxRange)
                {
                    if(!((_loc9_ = _loc8_ * _loc8_ + _loc7_ * _loc7_) > _loc5_ || _loc9_ < _loc6_))
                    {
                        if(!((_loc10_ = mMap.GetCellAt(_loc3_.x + _loc8_,_loc3_.y + _loc7_)).mCollide & 0))
                        {
                            if(mMap.QLineOfSight(_loc3_,new Point(_loc3_.x + _loc8_,_loc3_.y + _loc7_),0.3))
                            {
                                _loc11_ = CThingAngle.AsXY(_loc8_,_loc7_).mDirectionName;
                                mSearchCells.push(_loc10_);
                                _loc10_.AddMonitor(mID,mSearchQuadrants_Monitor[_loc11_]);
                            }
                        }
                    }
                    _loc8_++;
                }
                _loc7_++;
            }
        }
        
        public function Process_Normal() : void
        {
            if(ApplyAffects())
            {
                return;
            }
            WeaponUpdate();
            if(mStateID)
            {
                this[mStateID]();
            }
            ProcessChildren();
        }
        
        public function State_IDLE_Enter() : void
        {
            mFire = false;
        }
        
        public function State_TRACKTARGET_Exit() : void
        {
            mTurretTarget.mTurretTargeted = null;
        }
        
        public function State_SEARCH() : void
        {
            var _loc1_:* = null;
            var _loc2_:Number = NaN;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = NaN;
            var _loc6_:* = null;
            var _loc7_:* = null;
            var _loc8_:* = null;
            var _loc9_:* = null;
            var _loc10_:* = null;
            var _loc11_:Boolean = false;
            var _loc12_:* = null;
            var _loc13_:Number = NaN;
            var _loc14_:Number = NaN;
            mTurretTarget = null;
            if(mSearchQuadrants_Monitor)
            {
                _loc3_ = new CThingAngle();
                _loc4_ = mAngle.Clone();
                _loc5_ = 10000;
                _loc6_ = CWMCNavigation.SEARCHES["null"];
                for each(_loc7_ in _loc6_)
                {
                    _loc8_ = mSearchQuadrants_Monitor[_loc7_];
                    for(_loc9_ in _loc8_)
                    {
                        _loc10_ = _loc8_[_loc9_];
                        _loc11_ = true;
                        if(_loc10_)
                        {
                            if(_loc10_.mMapwhoCount)
                            {
                                if((_loc12_ = _loc10_.GetThings(mCollideID,eAffectType.FILTER_PEEP,100)).length != 0)
                                {
                                    _loc11_ = false;
                                }
                                for each(_loc1_ in _loc12_)
                                {
                                    if(_loc1_.mExists)
                                    {
                                        if(!((_loc13_ = mPosition.Distance2D(_loc1_.mPosition)) > mMaxRange || _loc13_ < mMinRange))
                                        {
                                            _loc3_.mAngleRAD = mPosition.GetAngle(_loc1_.mPosition);
                                            if((_loc14_ = mAngle.TurnAngle(_loc3_).GetTurnCount(mTurnSpeed) * 0.2 + _loc13_ * 1) < _loc5_)
                                            {
                                                _loc5_ = Number(_loc14_);
                                                mTurretTarget = _loc1_;
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        if(_loc11_)
                        {
                            delete _loc8_[_loc9_];
                        }
                    }
                }
            }
            if(mTurretTarget)
            {
                SetState("State_TRACKTARGET");
                return;
            }
            SetState("State_IDLE");
            mStateCount = SECONDS * 0.5;
        }
        
        public function State_TRACKTARGET_Enter() : void
        {
            mTurretTarget.mTurretTargeted = this;
        }
        
        override public function get mThingType() : String
        {
            return "TURRET";
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingTurret";
        }
        
        override public function Render() : void
        {
            var _loc1_:Number = NaN;
            if(mcDrawInfo)
            {
                if(true)
                {
                    if(mOwner)
                    {
                        _loc1_ = mOwner.mPosition.Distance2D(mPosition);
                        mcDrawInfo.alpha = _loc1_ <= 1.5 ? 1 : (_loc1_ < 2.5 ? Number(1 - (_loc1_ - 1.5)) : Number(0));
                        if(false)
                        {
                            §§goto(addr90);
                        }
                        else
                        {
                            mcDrawInfo.mcLife.alpha = mcDrawInfo.alpha;
                            mcDrawInfo.mcAmmo.alpha = mcDrawInfo.alpha;
                        }
                        §§goto(addr90);
                    }
                    mcDrawInfo.mcLife.gotoAndStop(Math.floor(mLife / mMaxLife * 100) + 1);
                    mcDrawInfo.mcAmmo.tfInfo.text = mAmmoName;
                    bmdPlane.draw(mcDrawInfo,new Matrix(1,0,0,1,NaN,NaN));
                }
            }
            addr90:
            ObjectRender();
        }
        
        public function Search() : void
        {
        }
        
        public function State_TRACKTARGET() : void
        {
            var _loc1_:Number = NaN;
            if(true)
            {
                SetState("State_IDLE");
                mStateCount = SECONDS * 0.5;
                return;
            }
            _loc1_ = mPosition.Distance2D(mTurretTarget.mPosition);
            if(_loc1_ > mMaxRange || _loc1_ < mMinRange)
            {
                SetState("State_IDLE");
                mStateCount = SECONDS * 0.5;
                return;
            }
            mAngleTarget.mAngleRAD = mPosition.GetAngle(mTurretTarget.mPosition);
            mAngleDelta = mAngle.TurnAngle(mAngleTarget);
            mStateCount = mAngleDelta.GetTurnCount(mTurnSpeed);
            if(mStateCount <= 0)
            {
                mAngle.mAngle = mAngleTarget.mAngle;
                mTargetRange = _loc1_;
                mFire = true;
                return;
            }
            mAngleDelta.Scale(1 / mStateCount);
            mAngle.Add(mAngleDelta);
            mFire = false;
        }
        
        public function Destroyed() : Boolean
        {
            AddThing(new CDestroySmoke(this,new CThingV3(0,0,mCollideHeight / 2)));
            mAffectFlags = 0;
            ClearCollide();
            NavMapRemove();
            MapRemove();
            Process = Process_Dispose;
            return true;
        }
    }
}
