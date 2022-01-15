package Thing
{
    public class CDestroySmoke extends CThingEffect
    {
         
        
        public function CDestroySmoke(param1:*, param2:CThingV3 = null)
        {
            super(param1);
            Process = Process_Normal;
            if(!GenSmokeExists(_CLASSID_))
            {
                AddGenSmoke(_CLASSID_,[Smoke_0001],0.65);
            }
            mAnimationFrame = 0;
            if(param2)
            {
                mPosition.Add(param2);
            }
            MapAdd();
        }
        
        public static function PrepareClass() : void
        {
            var _loc1_:* = null;
            _loc1_ = new CThingDraw();
            if(!_loc1_.GenSmokeExists("CDestroySmoke"))
            {
                _loc1_.AddGenSmoke("CDestroySmoke",[Smoke_0001],0.65);
            }
            _loc1_.Dispose();
        }
        
        public function Process_Normal() : *
        {
            if(AnimateEnd(0.06666666666666667))
            {
                Dispose();
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CDestroySmoke";
        }
    }
}
