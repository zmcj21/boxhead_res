package Thing
{
    import World.eWMCCollideType;
    
    public class CSAirstrike extends CThingShot
    {
         
        
        private var mStrikeInit:Number;
        
        private var mStrikeWidth:int;
        
        private var mStrikeSpread:int;
        
        public var mColor:uint = 4.29490176E9;
        
        private var mStrikeExChance:Number;
        
        private var mStrikeCount:int;
        
        private var mStrikeRange:int;
        
        public function CSAirstrike(param1:Object, param2:*, param3:String = "normal")
        {
            mColor = 4294901760;
            super(param2);
            SetPositionByInitObject(param1);
            MapAdd();
            AddSound("Airstrike",Airstrike_Plane);
            if(!MCAnimationExists(_CLASSID_))
            {
                AddMCAnimation(_CLASSID_,new Airstrike_Beacon());
            }
            PlaySound("Airstrike");
            mStrikeCount = 4.5 * SECONDS;
            mAngle = CThingAngle.AsAngle256(Random() * 256);
            switch(param3)
            {
                case "normal":
                default:
                    mStrikeSpread = 2;
                    mStrikeRange = 6 / mStrikeSpread;
                    mStrikeInit = 2;
                    Process = Process_Normal;
                    break;
                case "carpet":
                    mStrikeSpread = 2;
                    mStrikeRange = 40 / mStrikeSpread;
                    mStrikeWidth = 8 / mStrikeSpread;
                    mStrikeInit = 2;
                    Process = Process_Carpet;
                    break;
                case "snuke":
                    mStrikeSpread = 1.8;
                    mStrikeRange = 11 / mStrikeSpread;
                    mStrikeInit = 2;
                    mStrikeExChance = 1;
                    Process = Process_Nuke;
                    break;
                case "nuke":
                    mStrikeSpread = 1.8;
                    mStrikeRange = 18 / mStrikeSpread;
                    mStrikeInit = 2;
                    mStrikeExChance = 0.6;
                    Process = Process_Nuke;
            }
        }
        
        override public function Process_Dispose() : void
        {
            if(mAlpha > 0)
            {
                mAlpha -= 0.05;
                if(mAlpha <= 0)
                {
                    MapRemove();
                }
            }
            if(!ProcessChildren())
            {
                Dispose();
            }
        }
        
        public function Process_Beacon() : void
        {
            Animate();
            ProcessChildren();
        }
        
        private function _GetCount(param1:int) : int
        {
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            _loc2_ = mStrikeSpread * param1;
            _loc3_ = _loc2_ * 2 * 0 / 2;
            return Math.ceil(_loc3_ / mStrikeSpread);
        }
        
        public function Process_Carpet() : void
        {
            var _loc1_:int = 0;
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:* = null;
            var _loc8_:int = 0;
            var _loc9_:* = null;
            var _loc10_:int = 0;
            Process_Beacon();
            if(--mStrikeCount == 0)
            {
                mAlpha = 1;
                _loc1_ = 0;
                _loc3_ = new Array();
                mAngle.mAngleRAD = mOwner.mPosition.GetAngle(mPosition);
                _loc4_ = mAngle.mDelta.ScaleN(-mStrikeWidth / 2 * mStrikeSpread);
                _loc5_ = mAngle.mDelta.RotateZ(0).ScaleN(-mStrikeRange / 2 * mStrikeSpread);
                _loc6_ = new CThingV3().Sub(_loc4_).Sub(_loc5_);
                _loc4_.ScaleN(1 / (mStrikeWidth / 2));
                _loc5_.ScaleN(1 / (mStrikeRange / 2));
                _loc7_ = _loc6_.Clone();
                _loc8_ = 0;
                while(_loc8_ < mStrikeRange)
                {
                    _loc9_ = _loc7_.Clone();
                    _loc10_ = 0;
                    while(_loc10_ < mStrikeWidth)
                    {
                        if(!(mMap.GetCellAt(mPosition.x + _loc9_.x,mPosition.y + _loc9_.y).mCollide & 0))
                        {
                            AddThing(_loc2_ = new CExplosion(this,_loc9_));
                            _loc2_.SetDelay(_loc8_ * mStrikeInit);
                        }
                        _loc10_++;
                        _loc9_.Add(_loc4_);
                    }
                    _loc8_++;
                    _loc7_.Add(_loc5_);
                }
                Process = Process_Dispose;
            }
        }
        
        public function Process_Normal() : void
        {
            var _loc1_:int = 0;
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            var _loc6_:* = null;
            var _loc7_:int = 0;
            var _loc8_:* = null;
            if(--mStrikeCount == 0)
            {
                mAlpha = 1;
                _loc1_ = 0;
                _loc3_ = new Array();
                _loc4_ = 1;
                while(_loc4_ <= mStrikeRange)
                {
                    _loc5_ = _GetCount(_loc4_);
                    _loc6_ = CThingAngle.AsAngle256(256 / _loc5_);
                    _loc7_ = _loc5_;
                    while(_loc7_)
                    {
                        _loc8_ = mAngle.mDelta.ScaleN(_loc4_ * mStrikeSpread);
                        if(!(mMap.GetCellAt(mPosition.x + _loc8_.x,mPosition.y + _loc8_.y).mCollide & 0))
                        {
                            _loc3_.push(_loc1_++);
                            AddThing(_loc2_ = new CExplosion(this,_loc8_));
                        }
                        mAngle.Add(_loc6_);
                        _loc7_--;
                    }
                    _loc4_++;
                }
                for each(_loc2_ in mChildren)
                {
                    _loc2_.SetDelay(_loc3_.splice(RandomInt(_loc3_.length),1)[0] * mStrikeInit);
                }
                Process = Process_Dispose;
            }
            Process_Beacon();
        }
        
        public function Process_Nuke() : void
        {
            var _loc1_:int = 0;
            var _loc2_:* = null;
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            var _loc5_:* = null;
            var _loc6_:int = 0;
            var _loc7_:* = null;
            if(--mStrikeCount == 0)
            {
                mAlpha = 1;
                _loc1_ = 0;
                _loc3_ = 1;
                while(_loc3_ <= mStrikeRange)
                {
                    _loc4_ = _GetCount(_loc3_);
                    _loc5_ = CThingAngle.AsAngle256(256 / _loc4_);
                    _loc6_ = _loc4_;
                    while(_loc6_)
                    {
                        _loc7_ = mAngle.mDelta.ScaleN(_loc3_ * mStrikeSpread);
                        if(!(mMap.GetCellAt(mPosition.x + _loc7_.x,mPosition.y + _loc7_.y).mCollide & 0))
                        {
                            AddThing(_loc2_ = new CExplosion(this,_loc7_));
                            _loc2_.SetDelay(_loc3_ * mStrikeInit);
                        }
                        mAngle.Add(_loc5_);
                        _loc6_--;
                    }
                    _loc3_++;
                }
                Process = Process_Dispose;
            }
            Process_Beacon();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CSAirstrike";
        }
    }
}
