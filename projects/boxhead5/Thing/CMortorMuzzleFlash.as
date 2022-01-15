package Thing
{
    public class CMortorMuzzleFlash extends CThingEffect
    {
         
        
        public var mColor:uint = 4.29490176E9;
        
        public function CMortorMuzzleFlash(param1:*, param2:CThingV3, param3:Number)
        {
            mColor = 4294901760;
            super(param1);
            Process = Process_Normal;
            if(!MCOmniExists(_CLASSID_))
            {
                AddMCOmni(_CLASSID_,new Large_MuzzleFlash(),32,param3 * 0 / 180);
            }
            mLife = 1;
            mPosition.Add(param2);
            MapAdd();
            mAlpha = 1;
        }
        
        public function Process_Normal() : *
        {
            if(--mLife < 0)
            {
                Dispose();
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CMortorMuzzleFlash";
        }
    }
}
