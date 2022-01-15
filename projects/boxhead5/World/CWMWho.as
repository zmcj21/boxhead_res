package World
{
    import Thing.CThing;
    import Thing.CThingAffect;
    import Thing.CThingV3;
    import flash.geom.Point;
    
    public class CWMWho extends CWMSearch
    {
         
        
        public function CWMWho()
        {
            super();
        }
        
        public function GetThingsRadius(param1:Number, param2:Number, param3:Number) : Array
        {
            return GetThings(new CWMSearchArea(param1 - param3,param2 - param3,param3 * 2,param3 * 2));
        }
        
        public function GetThings(param1:CWMSearchArea) : Array
        {
            var _loc2_:* = null;
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            var _loc6_:* = null;
            var _loc7_:* = undefined;
            var _loc8_:int = 0;
            _loc2_ = new Array();
            if(!param1.valid)
            {
                return _loc2_;
            }
            _loc8_ = param1.right;
            _loc4_ = param1.top;
            _loc5_ = param1.bottom;
            while(_loc4_ <= _loc5_)
            {
                _loc6_ = mCells[_loc4_];
                _loc3_ = param1.left;
                while(_loc3_ <= _loc8_)
                {
                    for each(_loc7_ in _loc6_[_loc3_].mMapwho)
                    {
                        _loc2_.push(_loc7_);
                    }
                    _loc3_++;
                }
                _loc4_++;
            }
            return _loc2_;
        }
        
        public function RemoveThing(param1:*, param2:CWMCell) : void
        {
            param2.RemoveThing(param1);
        }
        
        public function GetThingsLine(param1:int, param2:Point, param3:Point, param4:Number = 0, param5:int = 16775167, param6:int = 1) : Object
        {
            var _loc7_:* = null;
            var _loc8_:* = null;
            var _loc9_:* = null;
            var _loc10_:* = null;
            _loc7_ = new Array();
            _loc8_ = GetCellsLine(param2,param3,param4,true);
            for each(_loc9_ in _loc8_)
            {
                if(param5 & _loc9_.mAffectFlags)
                {
                    if(_loc9_.mCollideID != param1)
                    {
                        _loc10_ = _loc9_.mPosition.Clone().Sub(_GTL_ZEROLOC);
                        if(_GTL_LineIntersectsRadius(_loc10_.x,_loc10_.y,param4 + _loc9_.mCollideRadius))
                        {
                            _loc7_.push(_loc9_);
                            if(_loc7_.length >= param6)
                            {
                                break;
                            }
                        }
                    }
                }
            }
            return {
                "mImpactPOI":_GTL_POI,
                "mThings":_loc7_
            };
        }
        
        override public function get _CLASSID_() : String
        {
            return "CWMWho";
        }
        
        public function AddThing(param1:CThing) : CWMCell
        {
            var _loc2_:* = null;
            (_loc2_ = GetCellAt(param1.mPosition.x,param1.mPosition.y)).AddThing(param1);
            return _loc2_;
        }
    }
}
