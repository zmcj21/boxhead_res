package Thing
{
    import World.eWMCCollideType;
    
    public class CFlameLine extends CThingShot
    {
         
        
        public var mColor:uint = 4.29490176E9;
        
        private var pCounter:int;
        
        public function CFlameLine(param1:*, param2:CThingV3)
        {
            mColor = 4294901760;
            super(param1);
            Process = Process_Normal;
            mSpeed = 0.78;
            mDelta = mAngle.mDelta.ScaleN(mSpeed);
            mLife = 15;
            pCounter = 0;
            mPosition.Add(param2);
        }
        
        public function Process_Normal() : *
        {
            ProcessChildren();
            pCounter = 0;
            AddThing(new CFire(this,new CThingV3(0,0,0)));
            mPosition.Add(mDelta);
            if(mMap.GetCellAt(mPosition.x,mPosition.y).mCollide & 0)
            {
                mLife = 0;
            }
            if(--mLife < 0)
            {
                Process = Process_Dispose;
                return;
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CFlameLine";
        }
    }
}
