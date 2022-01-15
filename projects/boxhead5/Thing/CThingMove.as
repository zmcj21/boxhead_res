package Thing
{
    import World.CWMCell;
    
    public class CThingMove extends CThingAffect
    {
         
        
        public var mAngleDelta:CThingAngle;
        
        public var mDelta:CThingV3;
        
        public var mAngleTarget:CThingAngle;
        
        public var mSpeedScale:Number;
        
        public var mSpeed:Number;
        
        public var mCellTarget:CWMCell;
        
        public function CThingMove()
        {
            super();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingMove";
        }
    }
}
