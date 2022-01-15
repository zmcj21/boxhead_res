package Thing
{
    public class CMuzzleFlash extends CThingEffect
    {
         
        
        public var mColor:uint = 4.29490176E9;
        
        public function CMuzzleFlash(param1:*, param2:CThingV3, param3:Class)
        {
            mColor = 4294901760;
            super(param1);
            Process = Process_Normal;
            if(!MCOmniExists(_CLASSID_))
            {
                AddMCOmni(_CLASSID_,new param3(),32);
            }
            mLife = 1;
            if(param2)
            {
                mPosition.Add(param2);
            }
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
            return "CMuzzleFlash";
        }
    }
}
