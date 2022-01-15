package Thing
{
    public class CThingMath extends CThingContainer
    {
        
        private static const MULTIPLIER:uint = 16807;
        
        public static const SQRT2:Number = Math.SQRT2;
        
        private static const dMODULUS:Number = 4.656612875245797e-10;
        
        private static const MODULUS:uint = 2147483647;
        
        public static const SQRT1_2:Number = Math.SQRT1_2;
         
        
        private var _Seed:uint;
        
        public function CThingMath()
        {
            super();
        }
        
        public function Sign(param1:*) : Number
        {
            return param1 < 0 ? -1 : (param1 > 0 ? 1 : Number(0));
        }
        
        public function set mSeed(param1:uint) : void
        {
            _Seed = param1;
        }
        
        public function RandomSignOrZero() : int
        {
            return int(Random() * 3) - 1;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingMath";
        }
        
        public function RandomInt(param1:uint) : uint
        {
            return mSeed % param1;
        }
        
        public function RandomSign() : int
        {
            return int(Random() * 2) * 2 - 1;
        }
        
        public function RandomOffset(param1:Number) : Number
        {
            return Random() * 2 * param1 - param1;
        }
        
        public function Random() : Number
        {
            return mSeed * dMODULUS;
        }
        
        public function RandomOffsetAndAdd(param1:Number, param2:Number) : Number
        {
            param1 = RandomOffset(param1);
            return param1 < 0 ? Number(param1 - param2) : Number(param1 + param2);
        }
        
        public function get mSeed() : uint
        {
            var _loc1_:* = _Seed * MULTIPLIER % MODULUS;
            _Seed = _Seed * MULTIPLIER % MODULUS;
            return _loc1_;
        }
    }
}
