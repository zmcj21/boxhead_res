package Thing
{
    public class CThingState extends CThingMath
    {
        
        public static var STATEEXIT:String = "stateexit";
        
        public static var STATEENTER:String = "stateenter";
         
        
        public var mReturnStateID:String;
        
        public var mStateID:String;
        
        public var mStateCount:int;
        
        public var mBaseStateID:String;
        
        public function CThingState()
        {
            super();
        }
        
        public function ReturnState() : Boolean
        {
            var _loc1_:* = null;
            if(mReturnStateID == null)
            {
                return !ReturnState_Base();
            }
            _loc1_ = mReturnStateID;
            mReturnStateID = null;
            return SetState(_loc1_);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingState";
        }
        
        public function SetBaseState(param1:String = "") : void
        {
            mBaseStateID = param1 == "" ? mStateID : param1;
        }
        
        public function ReturnState_Base() : Boolean
        {
            if(mBaseStateID)
            {
                SetState(mBaseStateID);
                return true;
            }
            return false;
        }
        
        public function SetState(param1:String, param2:String = null) : Boolean
        {
            if(mStateID == param1)
            {
                return false;
            }
            if(mStateID)
            {
                this[mStateID + "_Exit"]();
            }
            if(param2 != null)
            {
                mReturnStateID = param2;
            }
            mStateID = param1;
            this[mStateID + "_Enter"]();
            return true;
        }
    }
}
