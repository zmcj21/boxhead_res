package Thing
{
    public class CAffect
    {
         
        
        public var mAffector;
        
        public var mOwner;
        
        public var mType:int;
        
        public var mRange:Number;
        
        public var mHitDirection:CThingAngle;
        
        public var mDamage:Number;
        
        public var mForce:Number;
        
        public var mName:String;
        
        public function CAffect()
        {
            super();
        }
        
        public static function SLICED(param1:*, param2:*, param3:Number, param4:CThingAngle) : CAffect
        {
            var _loc5_:* = null;
            (_loc5_ = new CAffect()).Defaults("SLICED",param1,param2);
            _loc5_.mHitDirection = param4;
            _loc5_.mDamage = param3;
            return _loc5_;
        }
        
        public static function BULLET(param1:*, param2:*, param3:Number, param4:Number = 1) : CAffect
        {
            var _loc5_:* = null;
            (_loc5_ = new CAffect()).Defaults("BULLET",param1,param2);
            _loc5_.mDamage = param3;
            _loc5_.mForce = param4;
            return _loc5_;
        }
        
        public static function HIT(param1:*, param2:*, param3:Number, param4:Number = 1) : CAffect
        {
            var _loc5_:* = null;
            (_loc5_ = new CAffect()).Defaults("HIT",param1,param2);
            _loc5_.mDamage = param3;
            _loc5_.mForce = param4;
            return _loc5_;
        }
        
        public static function VAPOURIZE(param1:*, param2:*, param3:Number, param4:CThingAngle) : CAffect
        {
            var _loc5_:* = null;
            (_loc5_ = new CAffect()).Defaults("VAPOURIZE",param1,param2);
            _loc5_.mHitDirection = param4;
            _loc5_.mDamage = param3;
            return _loc5_;
        }
        
        public static function EXPLOSION(param1:*, param2:*, param3:Number, param4:Number = 1) : CAffect
        {
            var _loc5_:* = null;
            (_loc5_ = new CAffect()).Defaults("EXPLOSION",param1,param2);
            _loc5_.mDamage = param3;
            _loc5_.mForce = param4;
            return _loc5_;
        }
        
        public static function FIRE(param1:*, param2:*, param3:Number, param4:Number = 1) : CAffect
        {
            var _loc5_:* = null;
            (_loc5_ = new CAffect()).Defaults("FIRE",param1,param2);
            _loc5_.mDamage = param3;
            _loc5_.mForce = param4;
            return _loc5_;
        }
        
        public static function PUSH(param1:*, param2:Number = 1) : CAffect
        {
            var _loc3_:* = null;
            _loc3_ = new CAffect();
            _loc3_.Defaults("PUSH",param1,param1);
            _loc3_.mForce = param2;
            return _loc3_;
        }
        
        public static function PUNCHED(param1:*, param2:*, param3:Number, param4:CThingAngle) : CAffect
        {
            var _loc5_:* = null;
            (_loc5_ = new CAffect()).Defaults("PUNCHED",param1,param2);
            _loc5_.mHitDirection = param4;
            _loc5_.mDamage = param3;
            return _loc5_;
        }
        
        public static function ZOMBIEATTACK(param1:*, param2:Number, param3:Number = 1) : CAffect
        {
            var _loc4_:* = null;
            (_loc4_ = new CAffect()).Defaults("ZOMBIEATTACK",param1,param1);
            _loc4_.mDamage = param2;
            _loc4_.mForce = param3;
            return _loc4_;
        }
        
        public function get _CLASSID_() : String
        {
            return "CAffect";
        }
        
        private function Defaults(param1:String, param2:*, param3:*) : void
        {
            mType = eAffectType[param1];
            mName = param1;
            mOwner = param2;
            mAffector = param3;
        }
        
        public function toString() : String
        {
            return mType + " - mOwner:" + mOwner + ",mOwner:" + mOwner + ",mDamage:" + mDamage;
        }
    }
}
