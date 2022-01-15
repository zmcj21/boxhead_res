package Thing
{
    public class CSGrenade extends CThingShot
    {
         
        
        private var rUpgrades:Object;
        
        public function CSGrenade(param1:*, param2:CThingV3, param3:Number = 1, param4:Object = null)
        {
            super(param1);
            rUpgrades = param4;
            Process = Process_Normal;
            param3 = Math.min(1,Math.max(0.3,param3));
            var _loc5_:* = 2 * SECONDS;
            mLife = 2 * SECONDS;
            mMaxLife = _loc5_;
            mPosition.Add(param2);
            mDelta = mAngle.mDelta;
            mDelta.z = 0.5;
            mDelta.ScaleN(param3);
            mCollideRadius = 0.15;
            mCollideHeight = mCollideRadius * 2;
            MapAdd();
            AddSound("Bounce",Grenade_Bounce);
            if(!MCAnimationExists(_CLASSID_))
            {
                AddMCAnimation(_CLASSID_,new Shot_Grenade());
            }
        }
        
        public function Process_Normal() : *
        {
            var _loc1_:Boolean = false;
            var _loc2_:* = null;
            Animate();
            _loc1_ = false;
            mDelta.z = -0.06;
            if(false)
            {
                if((mDelta.z = Math.abs(mDelta.z)) <= 0.06)
                {
                    mDelta.z = 0;
                }
                mDelta.ScaleN(0.5);
                mPosition.z = 0;
                _loc1_ = true;
            }
            if(BounceCollide())
            {
                _loc1_ = true;
                mDelta.ScaleN2D(0.25);
            }
            if(_loc1_ && false)
            {
                PlaySound("Bounce");
            }
            mPosition.Add(mDelta);
            MapMove();
            if(--mLife == 0)
            {
                AddThing(_loc2_ = new CExplosion(this,new CThingV3(0,0,mCollideHeight / 2)));
                if(rUpgrades)
                {
                    if(false)
                    {
                        _loc2_.AddClusterShells(rUpgrades.mClusterShells);
                    }
                    if(false)
                    {
                        _loc2_.AddBiggerBang(rUpgrades.mBiggerBang);
                    }
                }
                MapRemove();
                Process = Process_Dispose;
                return;
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CSGrenade";
        }
    }
}
