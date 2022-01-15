package World
{
    import Thing.CThingAffect;
    
    public class CWMCBase
    {
         
        
        public var mMapwhoCount:int;
        
        public var nID:int;
        
        public var sID:String;
        
        public var mCollide:uint;
        
        public var mMapwho:Object;
        
        public var mapX:int;
        
        public var mapY:int;
        
        public function CWMCBase()
        {
            super();
        }
        
        public function get _CLASSID_() : String
        {
            return "CWMCBase";
        }
        
        public function toString() : String
        {
            return _CLASSID_;
        }
        
        public function GetThings(param1:int, param2:int = 16775167, param3:int = 1) : Array
        {
            var _loc4_:* = null;
            var _loc5_:* = null;
            _loc4_ = new Array();
            for each(_loc5_ in mMapwho)
            {
                if(param2 & _loc5_.mAffectFlags)
                {
                    if(_loc5_.mCollideID != param1)
                    {
                        if(_loc4_.push(_loc5_) >= param3)
                        {
                            break;
                        }
                    }
                }
            }
            return _loc4_;
        }
        
        public function Dispose() : void
        {
        }
    }
}
