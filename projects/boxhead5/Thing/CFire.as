package Thing
{
    public class CFire extends CThingEffect
    {
         
        
        public function CFire(param1:*, param2:CThingV3 = null)
        {
            super(param1);
            Process = Process_Normal;
            if(!GenFireExists(_CLASSID_))
            {
                AddGenFire(_CLASSID_,0.66);
            }
            mAnimationFrame = 0;
            if(param2)
            {
                mPosition.Add(param2);
            }
            MapAdd();
            mCollideRadius = 0.5;
            AddSound("Fire",Fire_0);
            mCounter = RandomInt(3) + 2;
        }
        
        public static function PrepareClass() : void
        {
            var _loc1_:* = null;
            _loc1_ = new CThingDraw();
            if(!_loc1_.GenFireExists("CFire"))
            {
                _loc1_.AddGenFire("CFire",0.66);
            }
            _loc1_.Dispose();
        }
        
        public function Process_Normal() : *
        {
            if(mAnimationFrame == 0)
            {
                PlaySound("Fire");
                DrawScorch();
            }
            if(mAnimationFrame <= 0.25)
            {
                AffectRadius(CAffect.FIRE(mOwner,this,20));
            }
            if(AnimateEnd(1 / (SECONDS * 1.5)))
            {
                Dispose();
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CFire";
        }
    }
}
