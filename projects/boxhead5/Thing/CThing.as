package Thing
{
    import World.CWorld;
    
    public class CThing
    {
        
        public static var INDENT:String;
        
        public static const DISPOSED:String = "DISPOSED";
        
        public static var VERBOSE:Boolean;
        
        public static var mAllocateID:int = 0;
        
        public static const SECONDS:int = CWorld.SECONDS;
         
        
        public var mCollideRadius:Number;
        
        public var nID:int;
        
        public var mName:String;
        
        public var mCollideHeight:Number;
        
        public var OnDispose:Function;
        
        public var mLife:int;
        
        public var mCollideMass:Number = 1;
        
        public var mScore:int;
        
        public var mDisposed:Boolean;
        
        public var OnDeath:Function;
        
        public var mPosition:CThingV3;
        
        public var mDrawn:Boolean;
        
        public var mKilledBy;
        
        public var mDamage:Number;
        
        public var mOwner;
        
        public var mID:String;
        
        public var mMoved:Boolean;
        
        public var Process:Function;
        
        public var mMaxLife:int;
        
        public var mTurretTargeted:CThingTurret;
        
        public var mCounter:int;
        
        public var mTarget:CThingMap;
        
        public var mAngle:CThingAngle;
        
        public var mCollideID:int;
        
        public var nProcessID:int;
        
        public var mDelete:Boolean;
        
        public function CThing()
        {
            mCollideMass = 1;
            super();
            nID = ++mAllocateID;
            mID = "T" + nID;
            mCollideID = nID;
        }
        
        public static function Restart() : void
        {
            mAllocateID = 0;
            CThingTurret.Restart();
            CThingPeep.Restart();
        }
        
        public function Dispose() : void
        {
            if(!mDisposed)
            {
                mDisposed = true;
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CThing";
        }
        
        public function GrowRadius(param1:Number, param2:Number = 0.05) : Boolean
        {
            if(mCollideRadius < param1)
            {
                mCollideRadius += param2;
                return false;
            }
            return true;
        }
        
        public function get mExists() : Boolean
        {
            return !(mDead || mDisposed);
        }
        
        public function get mThingType() : String
        {
            return "NONE";
        }
        
        public function Inherit(param1:*) : void
        {
            if(!param1)
            {
                return;
            }
            mPosition = param1.mPosition.Clone();
            mAngle = param1.mAngle.Clone();
            mCollideID = param1.mCollideID;
            mOwner = !!param1.mOwner ? param1.mOwner : param1;
        }
        
        public function get mDead() : Boolean
        {
            return mLife <= 0;
        }
        
        public function toString() : String
        {
            var _loc1_:* = null;
            return INDENT + _CLASSID_ + ":(cID = " + mCollideID + ")";
        }
    }
}
