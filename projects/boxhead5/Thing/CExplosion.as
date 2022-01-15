package Thing
{
    public class CExplosion extends CThingEffect
    {
         
        
        private var mDelayCounter:int;
        
        public function CExplosion(param1:*, param2:CThingV3 = null, param3:Number = 150, param4:Number = 2)
        {
            super(param1);
            Process = Process_Normal;
            if(!GenExplosionExists(_CLASSID_))
            {
                AddGenExplosion(_CLASSID_);
            }
            mAnimationFrame = 0;
            if(param2)
            {
                mPosition.Add(param2);
            }
            mCollideRadius = param4;
            AddSound("Explosion",Explosion_0,1,2);
            mCounter = RandomInt(3) + 2;
            SetDelay(0);
        }
        
        public static function PrepareClass() : void
        {
            var _loc1_:* = null;
            _loc1_ = new CThingDraw();
            if(!_loc1_.GenExplosionExists("CExplosion"))
            {
                _loc1_.AddGenExplosion("CExplosion");
            }
            _loc1_.Dispose();
        }
        
        public function AddBiggerBang(param1:int = 0) : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            if(param1 <= 0)
            {
                return;
            }
            mAngle.mAngle256 = RandomInt(256);
            _loc3_ = CThingAngle.AsAngle256(256 / param1);
            while(param1)
            {
                AddThing(_loc2_ = new CExplosion(this,mAngle.mDelta.ScaleN(1.5)));
                _loc2_.SetDelay(2 + RandomInt(4));
                mAngle.Add(_loc3_);
                param1--;
            }
        }
        
        public function SetDelay(param1:int) : void
        {
            Process = Process_Delay;
            mDelayCounter = param1;
        }
        
        public function Process_Normal() : void
        {
            if(mCounter-- == 0)
            {
                AffectRadius(CAffect.EXPLOSION(mOwner,this,150));
            }
            if(AnimateEnd(0.06666666666666667))
            {
                Process = Process_Dispose;
            }
            ProcessChildren();
        }
        
        public function Process_Delay() : void
        {
            if(mDelayCounter-- <= 0)
            {
                MapAdd();
                PlaySound("Explosion");
                DrawScorch();
                Process = Process_Normal;
                Process();
                return;
            }
            ProcessChildren();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CExplosion";
        }
        
        public function AddClusterShells(param1:int = 0) : void
        {
            var _loc2_:* = null;
            var _loc3_:int = 0;
            if(param1 <= 0)
            {
                return;
            }
            mAngle.mAngle256 = RandomInt(256);
            _loc2_ = CThingAngle.AsAngle256(256 / param1);
            _loc3_ = param1;
            while(_loc3_)
            {
                mAngle.Add(CThingAngle.AsAngle256(RandomInt(128 / param1)));
                AddThing(new CClusterShell(this));
                mAngle.Add(_loc2_);
                _loc3_--;
            }
        }
    }
}
