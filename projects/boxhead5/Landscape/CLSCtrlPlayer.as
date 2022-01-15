package Landscape
{
    import flash.display.Sprite;
    
    public class CLSCtrlPlayer extends Sprite
    {
         
        
        public function CLSCtrlPlayer()
        {
            super();
        }
        
        override public function toString() : String
        {
            return _CLASSID_;
        }
        
        public function get _CLASSID_() : String
        {
            return "CLSCtrlPlayer";
        }
    }
}
