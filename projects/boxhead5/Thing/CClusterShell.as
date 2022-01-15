package Thing
{
    public class CClusterShell extends CThingShot
    {
         
        
        public function CClusterShell(param1:*, param2:CThingV3 = null)
        {
            super(param1);
            Process = Process_Normal;
            if(param2)
            {
                mPosition.Add(param2);
            }
            var _loc3_:* = SECONDS - 4 + RandomInt(8);
            mLife = SECONDS - 4 + RandomInt(8);
            mMaxLife = _loc3_;
            mDelta = mAngle.mDelta.ScaleN(1 * (0.08 + Random() * 0.07));
            mDelta.z = 0.4 + Random() * 0.2;
            mCollideRadius = 0.15;
            mCollideHeight = mCollideRadius * 2;
            MapAdd();
            AddSound("Bounce",Grenade_Bounce);
            if(!MCAnimationExists(_CLASSID_))
            {
                AddMCAnimation(_CLASSID_,new Shot_ClusterShell());
            }
        }
        
        public function Process_Normal() : *
        {
            var _loc1_:Boolean = false;
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
                AddThing(new CExplosion(this,new CThingV3(0,0,mCollideHeight / 2)));
                MapRemove();
                Process = Process_Dispose;
                return;
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CClusterShell";
        }
    }
}
