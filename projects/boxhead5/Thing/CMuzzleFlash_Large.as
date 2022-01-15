package Thing
{
    public class CMuzzleFlash_Large extends CMuzzleFlash
    {
         
        
        public function CMuzzleFlash_Large(param1:*, param2:CThingV3)
        {
            super(param1,param2,Large_MuzzleFlash);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CMuzzleFlash_Large";
        }
    }
}
