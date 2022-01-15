package Thing
{
    public class CShotgunBullet extends CThingShot
    {
         
        
        public function CShotgunBullet(param1:*, param2:CAffect, param3:CThingV3, param4:Number, param5:int)
        {
            var _loc6_:* = null;
            var _loc7_:* = null;
            var _loc8_:int = 0;
            super(param1,param2);
            switch(param5)
            {
                case 0:
                    _loc7_ = CThingAngle.AsAngle256(3);
                    mAngle.Sub(_loc7_);
                    _loc8_ = 3;
                    while(_loc8_)
                    {
                        AddThing(_loc6_ = new CBullet(this,param2,param3,1,param4));
                        _loc8_--;
                        mAngle.Add(_loc7_);
                    }
                    break;
                case 1:
                    _loc7_ = CThingAngle.AsAngle256(6);
                    mAngle.Sub(_loc7_);
                    _loc8_ = 3;
                    while(_loc8_)
                    {
                        AddThing(_loc6_ = new CBullet(this,param2,param3,1,param4));
                        _loc8_--;
                        mAngle.Add(_loc7_);
                    }
                    break;
                case 2:
                    _loc7_ = CThingAngle.AsAngle256(10);
                    mAngle.Sub(_loc7_);
                    _loc7_.Scale(0.5);
                    _loc8_ = 5;
                    while(_loc8_)
                    {
                        AddThing(_loc6_ = new CBullet(this,param2,param3,1,param4));
                        _loc8_--;
                        mAngle.Add(_loc7_);
                    }
            }
            Process = Process_Dispose;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CShotgunBullet";
        }
    }
}
