package Thing
{
    public class CThingContainer extends CThing
    {
         
        
        public var mThings:Array;
        
        public var mParent;
        
        public function CThingContainer()
        {
            super();
        }
        
        public function CountChildren(param1:String, param2:Boolean = false) : int
        {
            var _loc3_:int = 0;
            var _loc4_:* = undefined;
            _loc3_ = 0;
            for each(_loc4_ in mThings)
            {
                if(_loc4_._CLASSID_ == param1)
                {
                    if(!param2)
                    {
                    }
                    _loc3_++;
                }
            }
            return _loc3_;
        }
        
        public function Process_Dispose() : void
        {
            if(!ProcessChildren())
            {
                Dispose();
            }
        }
        
        public function get mChildren() : Array
        {
            return mThings;
        }
        
        public function RemoveThing(param1:*) : *
        {
            param1.mParent = null;
            mThings.splice(mThings.indexOf(param1),1);
            if(true)
            {
                mThings = null;
            }
            return param1;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingContainer";
        }
        
        public function AddKill() : *
        {
            return !!mParent ? mParent.AddKill() : this;
        }
        
        public function mChildrenCount() : int
        {
            return mThings.length;
        }
        
        public function get mNumChildren() : int
        {
            return mThings.length;
        }
        
        public function AddThing(param1:*) : *
        {
            param1.mParent = this;
            if(mThings)
            {
                mThings.push(param1);
            }
            else
            {
                mThings = [param1];
            }
            return param1;
        }
        
        public function ProcessChildren() : Boolean
        {
            var _loc1_:* = undefined;
            if(!mThings)
            {
                return false;
            }
            for each(_loc1_ in mThings.slice())
            {
                if(_loc1_.Process)
                {
                    _loc1_.Process();
                }
            }
            return true;
        }
        
        override public function toString() : String
        {
            var _loc1_:* = null;
            var _loc2_:* = undefined;
            _loc1_ = super.toString();
            if(mThings != null)
            {
                _loc1_ += " Children:" + String(mNumChildren);
                _loc1_ += " mChildren:";
                _loc1_ += "\n" + INDENT + "{";
                INDENT += String.fromCharCode(9);
                for each(_loc2_ in mThings)
                {
                    _loc1_ += "\n" + _loc2_.toString() + " ";
                }
                INDENT = INDENT.length <= 1 ? "" : INDENT.substr(1);
                _loc1_ += "\n" + INDENT + "}";
            }
            return _loc1_;
        }
        
        override public function Dispose() : void
        {
            var _loc1_:* = undefined;
            if(mDisposed)
            {
                return;
            }
            if(mParent)
            {
                mParent.RemoveThing(this);
            }
            if(mThings)
            {
                for each(_loc1_ in mThings.slice())
                {
                    _loc1_.Dispose();
                }
            }
            super.Dispose();
        }
    }
}
