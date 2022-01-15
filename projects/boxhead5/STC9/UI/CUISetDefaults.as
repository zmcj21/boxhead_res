package STC9.UI
{
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    
    public class CUISetDefaults
    {
         
        
        public function CUISetDefaults()
        {
            super();
        }
        
        public static function SetField(param1:DisplayObjectContainer, param2:String, param3:*, param4:Boolean = true) : *
        {
            var _loc5_:int = 0;
            var _loc6_:* = null;
            _loc5_ = param1.numChildren - 1;
            while(_loc5_ >= 0)
            {
                if((_loc6_ = param1.getChildAt(_loc5_)).hasOwnProperty(param2))
                {
                    _loc6_[param2] = param3;
                }
                if(param4 && _loc6_.hasOwnProperty("numChildren"))
                {
                    SetField(DisplayObjectContainer(_loc6_),param2,param3,param4);
                }
                _loc5_--;
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CUISetDefaults";
        }
    }
}
