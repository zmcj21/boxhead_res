package Thing
{
    import IO.CPlayerControl;
    
    public class CThingControl extends CThingNavigation
    {
         
        
        public var mControl:CPlayerControl;
        
        public function CThingControl()
        {
            super();
        }
        
        public function ProcessControl() : CPlayerControl
        {
            mControl.Process();
            return mControl;
        }
        
        public function DeactivateControl() : void
        {
            mControl.Deactivate();
        }
        
        public function ActivateControl(param1:CPlayerControl) : void
        {
            (mControl = param1).Activate();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingControl";
        }
    }
}
