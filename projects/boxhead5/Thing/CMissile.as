package Thing
{
    public class CMissile extends CThingShot
    {
         
        
        public var mColor:uint = 4.29490176E9;
        
        private var lPosition:CThingV3;
        
        public function CMissile(param1:*, param2:CAffect, param3:CThingV3, param4:Number = 150)
        {
            mColor = 4294901760;
            super(param1,param2);
            Process = Process_Normal;
            mSpeed = 1;
            mDelta = mAngle.mDelta.ScaleN(mSpeed);
            mCollideRadius = 0.3;
            mLife = 50;
            mDamage = param4;
            mPosition.Add(param3);
            if(!MCAnimationExists(_CLASSID_))
            {
                AddMCAnimation(_CLASSID_,new Missile_Flare());
            }
            mDrawScale = 0.5;
            mAlpha = 0.8;
            MapAdd();
        }
        
        public function Process_Normal() : *
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            var _loc3_:* = null;
            lPosition = mPosition.Clone();
            _loc1_ = mPosition.Clone().Add(mDelta);
            _loc2_ = GetThingsLine(_loc1_,mCollideRadius,eAffectType.BULLET,1);
            _loc3_ = _loc2_.mThings;
            if(_loc3_.length)
            {
                mPosition.Set(_loc3_[0].mPosition.x,_loc3_[0].mPosition.y,mPosition.z);
                mLife = 0;
                AddThing(new CExplosion(this,new CThingV3()));
                MapRemove();
            }
            else if(_loc2_.mImpactPOI)
            {
                mPosition.Set(_loc2_.mImpactPOI.x,_loc2_.mImpactPOI.y,mPosition.z);
                mLife = 0;
                AddThing(new CExplosion(this,new CThingV3(),mDamage));
                MapRemove();
            }
            else
            {
                mPosition.Add(mDelta);
                mDelta.ScaleN(1.1);
                MapMove();
            }
            if(--mLife < 0)
            {
                Process = Process_Dispose;
                return;
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CMissile";
        }
        
        override public function Render() : void
        {
            mAnimationFrame = Math.random();
            super.Render();
            if(lPosition)
            {
                mSFXLayer.DrawSmokeLine(RenderPosition(lPosition),mRenderPosition,3,1);
            }
        }
    }
}
