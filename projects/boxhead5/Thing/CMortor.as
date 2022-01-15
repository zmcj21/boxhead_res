package Thing
{
    public class CMortor extends CThingShot
    {
        
        private static var checkRange:Boolean = true;
        
        private static var ranges:Array;
        
        private static var speed:Number = 0.74;
        
        private static var gravity:Number = 0.05;
         
        
        public var mColor:uint = 4.29490176E9;
        
        private var lPosition:CThingV3;
        
        public function CMortor(param1:*, param2:CAffect, param3:CThingV3, param4:Number, param5:Number)
        {
            var _loc6_:* = null;
            mColor = 4294901760;
            super(param1,param2);
            Process = Process_Normal;
            CalibrateRanges(param3,param4);
            mDelta = new CThingV3(ranges[Math.round(param5)],0,0).RotateY(-param4 * 0 / 180).RotateZ(mAngle.mAngleRAD);
            mCollideRadius = 0.2;
            _loc6_ = mPosition.Clone();
            mPosition.Add(param3);
            MapAdd();
            if(!MCAnimationExists(_CLASSID_))
            {
                AddMCAnimation(_CLASSID_,new Shot_Grenade());
            }
        }
        
        public function CalibrateRanges(param1:CThingV3, param2:Number) : void
        {
            if(checkRange)
            {
                ranges = new Array();
                ranges[0] = 0.2;
                ranges[1] = 0.2;
                ranges[2] = 0.24;
                ranges[3] = 0.32;
                ranges[4] = 0.39;
                ranges[5] = 0.455;
                ranges[6] = 0.51;
                ranges[7] = 0.55;
                ranges[8] = 0.6;
                ranges[9] = 0.64;
                ranges[10] = 0.679;
                ranges[11] = 0.72;
                ranges[12] = 0.75;
                ranges[13] = 0.79;
                ranges[14] = 0.82;
                ranges[15] = 0.85;
                ranges[16] = 0.88;
                ranges[17] = 0.91;
                ranges[18] = 0.94;
                ranges[19] = 0.97;
                ranges[20] = 1;
            }
        }
        
        public function Process_Normal() : *
        {
            var _loc1_:* = null;
            lPosition = mPosition.Clone();
            mPosition.Add(mDelta);
            if(!mMap.IsValidCellPosition(mPosition.x,mPosition.y))
            {
                Dispose();
                return;
            }
            MapMove();
            mDelta.z = 0 - gravity;
            if(true)
            {
                mPosition.z = 0;
                AddThing(_loc1_ = new CExplosion(this,new CThingV3(),50,1.5));
                _loc1_.AddBiggerBang(4);
                MapRemove();
                Process = Process_Dispose;
            }
        }
        
        override public function get _CLASSID_() : String
        {
            return "CMortor";
        }
        
        override public function Render() : void
        {
            super.Render();
            if(lPosition)
            {
                mSFXLayer.DrawSmokeLine(RenderPosition(lPosition),mRenderPosition,3,1);
            }
        }
    }
}
