package Thing
{
    import World.CWMCell;
    import World.eWMCCollideType;
    
    public class CThingCollision extends CThingMove
    {
        
        private static var CollideCell_Filter:Function = IsCollideCell;
         
        
        private var _CollideFlag:Boolean;
        
        private var _CollideThings:Object;
        
        public function CThingCollision()
        {
            super();
        }
        
        private static function IsCollideCell_Player(param1:CWMCell) : Boolean
        {
            return !!(param1.mCollide & (0 | 0)) ? true : false;
        }
        
        private static function IsCollideCell(param1:CWMCell) : Boolean
        {
            return !!(param1.mCollide & 0) ? true : false;
        }
        
        public function ThingCollideRadius(param1:int = 16775167) : CThingAffect
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            _loc2_ = new Array();
            for each(_loc3_ in mMap.GetThingsRadius(mPosition.x,mPosition.y,mCollideRadius))
            {
                if(param1 & _loc3_.mAffectFlags)
                {
                    if(_loc3_.mCollideID != mCollideID)
                    {
                        if(mPosition.Distance2D(_loc3_.mPosition) <= _loc3_.mCollideRadius + mCollideRadius)
                        {
                            return _loc3_;
                        }
                    }
                }
            }
            return null;
        }
        
        public function BounceCollide() : Boolean
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:Number = NaN;
            CollideCell_Filter = IsCollideCell;
            _CollideFlag = false;
            _loc1_ = mDelta.Clone();
            _loc2_ = MapwhoCollide(mPosition.Clone().Add(mDelta),!!mOwner ? 0 : int(nID),eAffectType.FILTER_SOLID);
            _loc1_.x = _loc2_.x - 0;
            _loc1_.y = _loc2_.y - 0;
            _loc2_ = Collide_Map(_loc1_);
            if(!_CollideFlag)
            {
                return false;
            }
            _loc3_ = _loc2_.Sub(mPosition.Clone().Add(mDelta)).Normalize2D(1);
            _loc4_ = 2 * (0 * _loc3_.x + 0 * _loc3_.y);
            mDelta.x = 0 - _loc3_.x * _loc4_;
            mDelta.y = 0 - _loc3_.y * _loc4_;
            return true;
        }
        
        public function PeepCollide() : CThingV3
        {
            var _loc1_:* = NaN;
            var _loc2_:* = null;
            CollideCell_Filter = IsCollideCell;
            if(CollideCell_Filter(mCellCurrent))
            {
                return mPosition.Clone();
            }
            _loc1_ = 1;
            while(_loc1_)
            {
                _CollideFlag = false;
                _loc2_ = MapwhoCollide(mPosition.Clone().Add(mDelta),nID,eAffectType.FILTER_SOLID);
                mDelta = _loc2_.Clone().Sub(mPosition);
                _loc2_ = Collide_Map(mDelta);
                if(!_CollideFlag)
                {
                    break;
                }
                _loc1_--;
            }
            mDelta = _loc2_.Clone().Sub(mPosition);
            return _loc2_;
        }
        
        private function QCollide_Map(param1:Number, param2:Number) : CThingV3
        {
            return !!mMap.GetCellsRadius(param1,param2,mCollideRadius,CollideCell_Filter).length ? null : new CThingV3(param1,param2,mPosition.z);
        }
        
        public function MapwhoCollide(param1:CThingV3, param2:int, param3:int = 1024, param4:int = 0) : CThingV3
        {
            var _loc5_:Number = NaN;
            var _loc6_:* = NaN;
            var _loc7_:Number = NaN;
            var _loc8_:Number = NaN;
            var _loc9_:* = null;
            var _loc10_:* = null;
            _loc7_ = (_loc6_ = 0) + mCollideHeight;
            for each(_loc9_ in mMap.GetThingsRadius(mPosition.x,mPosition.y,mCollideRadius))
            {
                if(param3 & _loc9_.mAffectFlags)
                {
                    if(_loc9_.nID != param2)
                    {
                        if(!((_loc8_ = _loc9_.mPosition.z) > _loc7_ || _loc8_ + _loc9_.mCollideHeight < _loc6_))
                        {
                            if((_loc5_ = _loc9_.mPosition.Distance2D(param1)) < mCollideRadius + _loc9_.mCollideRadius)
                            {
                                if(!(param4 & _loc9_.mAffectFlags))
                                {
                                    (_loc10_ = param1.Clone().Sub(_loc9_.mPosition)).ScaleN((mCollideRadius + _loc9_.mCollideRadius - _loc5_) / _loc5_);
                                    param1.Add(_loc10_);
                                    _CollideFlag = true;
                                }
                                if(_CollideThings)
                                {
                                    _CollideThings[_loc9_.mID] = _loc9_;
                                }
                            }
                        }
                    }
                }
            }
            return param1;
        }
        
        public function Collide_Map(param1:CThingV3) : CThingV3
        {
            var _loc2_:* = null;
            if(_loc2_ = QCollide_Map(mPosition.x + param1.x,mPosition.y + param1.y))
            {
                return _loc2_;
            }
            _CollideFlag = true;
            if(_loc2_ = QCollide_Map(mPosition.x + param1.x,mPosition.y))
            {
                return _loc2_;
            }
            if(_loc2_ = QCollide_Map(mPosition.x,mPosition.y + param1.y))
            {
                return _loc2_;
            }
            return mPosition;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingCollision";
        }
        
        public function get mCollideThings() : Object
        {
            return _CollideThings;
        }
        
        public function PlayerCollide() : CThingV3
        {
            var _loc1_:* = 0;
            var _loc2_:* = NaN;
            var _loc3_:* = undefined;
            var _loc4_:* = null;
            CollideCell_Filter = IsCollideCell_Player;
            if(CollideCell_Filter(mCellCurrent))
            {
                return mPosition.Clone();
            }
            _loc1_ = 0 | 0;
            _CollideThings = new Object();
            _loc2_ = 3;
            while(_loc2_)
            {
                _CollideFlag = false;
                _loc4_ = MapwhoCollide(mPosition.Clone().Add(mDelta),nID,_loc1_,eAffectType.FILTER_PICKUP);
                mDelta = _loc4_.Clone().Sub(mPosition);
                _loc4_ = Collide_Map(mDelta);
                if(!_CollideFlag)
                {
                    break;
                }
                _loc2_--;
            }
            mDelta = _loc4_.Clone().Sub(mPosition);
            for each(_loc3_ in _CollideThings)
            {
                if(_loc3_.mAffectFlags & 0)
                {
                    _loc3_.Pickup(this);
                }
            }
            _CollideThings = null;
            return _loc4_;
        }
    }
}
