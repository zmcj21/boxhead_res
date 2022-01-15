package Thing
{
    import World.CWMCell;
    
    public class CThingAffect extends CThingMap
    {
        
        public static var AFFECTED:String = "affected";
         
        
        public var mAffects:Array;
        
        public var mAffectFlags:uint = 16775167;
        
        public var mAffect:CAffect;
        
        public function CThingAffect()
        {
            mAffectFlags = eAffectType.ANY;
            super();
        }
        
        public function AffectRadius(param1:CAffect, param2:int = 100000, param3:CThingV3 = null, param4:Number = -1) : void
        {
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:* = null;
            _loc5_ = !!param3 ? mPosition.Clone().Add(param3) : mPosition;
            param4 = param4 < 0 ? Number(mCollideRadius) : Number(param4);
            _loc6_ = mMap.GetThingsRadius(_loc5_.x,_loc5_.y,mCollideRadius);
            for each(_loc7_ in _loc6_)
            {
                if((param1.mType & _loc7_.mAffectFlags) != 0)
                {
                    if(_loc7_.mCollideID != mCollideID)
                    {
                        if(_loc5_.Distance2D(_loc7_.mPosition) <= _loc7_.mCollideRadius + param4)
                        {
                            _loc7_.AddAffect(param1);
                            if(--param2 <= 0)
                            {
                                return;
                            }
                        }
                    }
                }
            }
        }
        
        public function AffectCell(param1:CAffect, param2:CWMCell, param3:int = 100000) : void
        {
            var _loc4_:* = null;
            _loc4_ = new CThingV3(param2.mapX + 0.5,param2.mapY + 0.5,mPosition.z);
            AffectRadius(param1,param3,_loc4_.Sub(mPosition),0.5);
        }
        
        public function Affect_EXPLOSION(param1:CAffect) : void
        {
            mLife -= param1.mDamage;
        }
        
        public function Affect_ZOMBIEATTACK(param1:CAffect) : void
        {
            mLife -= param1.mDamage;
        }
        
        public function AffectThings(param1:Array, param2:CAffect) : Array
        {
            var _loc3_:* = null;
            for each(_loc3_ in param1)
            {
                _loc3_.AddAffect(param2);
            }
            return param1;
        }
        
        public function AddAffect(param1:CAffect) : void
        {
            if(!param1)
            {
                return;
            }
            if(mAffects)
            {
                mAffects.push(param1);
            }
            else
            {
                mAffects = [param1];
            }
        }
        
        public function Affect_FIRE(param1:CAffect) : void
        {
            mLife -= param1.mDamage;
        }
        
        public function Affect_VAPOURIZE(param1:CAffect) : void
        {
            mLife -= param1.mDamage;
        }
        
        public function Affect_HIT(param1:CAffect) : void
        {
            mLife -= param1.mDamage;
        }
        
        public function Affect_BULLET(param1:CAffect) : void
        {
            mLife -= param1.mDamage;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingAffect";
        }
        
        public function Affect_PUSH(param1:CAffect) : void
        {
        }
    }
}
