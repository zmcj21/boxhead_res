package World
{
    import STC9.Bitmap.CBitmapData;
    import Thing.CThingV3;
    import flash.display.Sprite;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    public class CWMSearch extends CWMBase
    {
        
        private static const LS_ANGLES:int = 256;
        
        public static var mSearchLines:Array;
        
        public static const a256PI:Number = Infinity;
        
        private static const LS_LENGTH:int = 16;
         
        
        public var _GTL_ldx:Number;
        
        public var _GTL_ldy:Number;
        
        public var _GTL_COLLIDE:Function;
        
        public var _GTL_POI:Point;
        
        public var _GTL_1divldv:Number;
        
        public var _GTL_OFFLOC:Point;
        
        public var _GTL_ZEROLOC:CThingV3;
        
        public var _GTL_ldv:Number;
        
        public function CWMSearch()
        {
            super();
        }
        
        private static function Sort_LineSearchPoints(param1:Object, param2:Object) : Number
        {
            return param1.len > param2.len ? 1 : (param1.len < param2.len ? -1 : Number(0));
        }
        
        public static function CreateLineSearches() : void
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:* = null;
            var _loc8_:* = null;
            var _loc9_:int = 0;
            var _loc10_:* = null;
            var _loc11_:* = null;
            var _loc12_:int = 0;
            var _loc13_:int = 0;
            var _loc14_:int = 0;
            var _loc15_:int = 0;
            _loc1_ = new Sprite();
            _loc2_ = new CBitmapData(LS_LENGTH * 2 + 1,LS_LENGTH * 2 + 1,false,0);
            _loc3_ = new Point(LS_LENGTH + 0.5,LS_LENGTH + 0.5);
            _loc4_ = new Point(LS_LENGTH,LS_LENGTH);
            _loc5_ = new Rectangle(-0.5,-1.5,LS_LENGTH,3);
            _loc6_ = [new Point(_loc5_.left,_loc5_.top),new Point(_loc5_.left,_loc5_.bottom),new Point(_loc5_.right,_loc5_.bottom),new Point(_loc5_.right,_loc5_.top)];
            _loc7_ = new Array();
            _loc8_ = new Matrix();
            _loc9_ = 0;
            mSearchLines = new Array();
            _loc9_ = LS_ANGLES;
            while(_loc9_)
            {
                _loc7_[0] = _loc8_.transformPoint(_loc6_[0]);
                _loc7_[1] = _loc8_.transformPoint(_loc6_[1]);
                _loc7_[2] = _loc8_.transformPoint(_loc6_[2]);
                _loc7_[3] = _loc8_.transformPoint(_loc6_[3]);
                _loc1_.graphics.clear();
                _loc1_.graphics.beginFill(65280,1);
                _loc1_.graphics.moveTo(_loc3_.x + _loc7_[3].x,_loc3_.y + _loc7_[3].y);
                for each(_loc10_ in _loc7_)
                {
                    _loc1_.graphics.lineTo(_loc3_.x + _loc10_.x,_loc3_.y + _loc10_.y);
                }
                _loc1_.graphics.endFill();
                _loc2_.fillRect(_loc2_.rect,0);
                _loc2_.draw(_loc1_,null,null,null,null,false);
                _loc11_ = new Array();
                _loc12_ = 0;
                while(_loc12_ < _loc2_.height)
                {
                    _loc13_ = 0;
                    while(_loc13_ < _loc2_.width)
                    {
                        if(_loc2_.getPixel(_loc13_,_loc12_))
                        {
                            _loc14_ = _loc13_ - _loc4_.x;
                            _loc15_ = _loc12_ - _loc4_.y;
                            _loc11_.push({
                                "x":_loc14_,
                                "y":_loc15_,
                                "len":Math.sqrt(_loc14_ * _loc14_ + _loc15_ * _loc15_)
                            });
                        }
                        _loc13_++;
                    }
                    _loc12_++;
                }
                _loc11_.sort(Sort_LineSearchPoints);
                mSearchLines.push(_loc11_);
                _loc8_.rotate(0);
                _loc9_--;
            }
            _loc2_.dispose();
        }
        
        public function GetCellAt(param1:uint, param2:uint) : CWMCell
        {
            return param1 >= mWidth || param2 >= mHeight ? dumbCell : mCells[param2][param1];
        }
        
        public function _GTL_COLLIDE_TL(param1:Number, param2:Number) : Boolean
        {
            if(_GTL_LineIntersectsLineX(param1,param2))
            {
                return true;
            }
            if(_GTL_LineIntersectsLineY(param1,param2))
            {
                return true;
            }
            return false;
        }
        
        public function IsValidCellPosition(param1:uint, param2:uint) : Boolean
        {
            return !(param1 >= mWidth || param2 >= mHeight);
        }
        
        public function _GTL_Setup(param1:Point, param2:Point) : void
        {
            _GTL_ldx = param2.x - param1.x;
            _GTL_ldy = param2.y - param1.y;
            _GTL_ldv = _GTL_ldx * _GTL_ldx + _GTL_ldy * _GTL_ldy;
            _GTL_1divldv = 1 / _GTL_ldv;
            _GTL_ZEROLOC = new CThingV3(param1.x,param1.y);
            _GTL_OFFLOC = new Point(param1.x % 1,param1.y % 1);
            _GTL_POI = null;
            _GTL_COLLIDE = _GTL_ldy >= 0 ? (_GTL_ldx >= 0 ? _GTL_COLLIDE_TL : _GTL_COLLIDE_TR) : (_GTL_ldx >= 0 ? _GTL_COLLIDE_BL : _GTL_COLLIDE_BR);
        }
        
        public function _GTL_COLLIDE_TR(param1:Number, param2:Number) : Boolean
        {
            if(_GTL_LineIntersectsLineX(param1,param2))
            {
                return true;
            }
            if(_GTL_LineIntersectsLineY(param1 + 1,param2))
            {
                return true;
            }
            return false;
        }
        
        public function GetCellsRadius(param1:Number, param2:Number, param3:Number, param4:Function = null) : Array
        {
            return GetCells(new CWMSearchArea(param1 - param3,param2 - param3,param3 * 2,param3 * 2),param4);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CWMSearch";
        }
        
        public function GetCells(param1:CWMSearchArea, param2:Function = null) : Array
        {
            var _loc3_:* = null;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc7_:int = 0;
            var _loc8_:* = null;
            _loc3_ = new Array();
            if(!param1.valid)
            {
                return _loc3_;
            }
            _loc5_ = param1.right;
            if(param2 != null)
            {
                _loc6_ = param1.top;
                _loc7_ = param1.bottom;
                while(_loc6_ <= _loc7_)
                {
                    _loc4_ = param1.left;
                    _loc8_ = mCells[_loc6_];
                    while(_loc4_ <= _loc5_)
                    {
                        if(param2(_loc8_[_loc4_]))
                        {
                            _loc3_.push(_loc8_[_loc4_]);
                        }
                        _loc4_++;
                    }
                    _loc6_++;
                }
            }
            else
            {
                _loc6_ = param1.top;
                _loc7_ = param1.bottom;
                while(_loc6_ <= _loc7_)
                {
                    _loc4_ = param1.left;
                    _loc8_ = mCells[_loc6_];
                    while(_loc4_ <= _loc5_)
                    {
                        _loc3_.push(_loc8_[_loc4_]);
                        _loc4_++;
                    }
                    _loc6_++;
                }
            }
            return _loc3_;
        }
        
        public function _GTL_LineIntersectsRadius(param1:Number, param2:Number, param3:Number) : Boolean
        {
            var _loc4_:Number = NaN;
            var _loc5_:Number = NaN;
            var _loc6_:Number = NaN;
            var _loc7_:Number = NaN;
            var _loc8_:Number = NaN;
            var _loc9_:Number = NaN;
            if((_loc6_ = _GTL_ldx * param1 + _GTL_ldy * param2) <= 0)
            {
                return param1 * param1 + param2 * param2 <= param3 * param3;
            }
            if(_GTL_ldv <= _loc6_)
            {
                param1 -= _GTL_ldx;
                param2 -= _GTL_ldy;
                return param1 * param1 + param2 * param2 <= param3 * param3;
            }
            _loc7_ = _loc6_ * _GTL_1divldv;
            _loc8_ = param1 - _GTL_ldx * _loc7_;
            _loc9_ = param2 - _GTL_ldy * _loc7_;
            return _loc8_ * _loc8_ + _loc9_ * _loc9_ <= param3 * param3;
        }
        
        public function GetCellsLine(param1:Point, param2:Point, param3:Number = 0, param4:Boolean = false) : Array
        {
            var _loc5_:* = 0;
            var _loc6_:* = null;
            var _loc7_:Number = NaN;
            var _loc8_:* = null;
            var _loc9_:* = null;
            var _loc12_:* = null;
            var _loc13_:* = undefined;
            _GTL_Setup(param1,param2);
            _loc5_ = Math.atan2(_GTL_ldy,_GTL_ldx) * a256PI & 255;
            _loc6_ = mSearchLines[_loc5_];
            _loc7_ = Math.sqrt(_GTL_ldv) + param3;
            if(param4)
            {
                _loc12_ = new Array();
                for each(_loc8_ in _loc6_)
                {
                    if((_loc9_ = GetCellAt(param1.x + _loc8_.x,param1.y + _loc8_.y)).mCollide & 0)
                    {
                        if(_GTL_COLLIDE(_loc8_.x - 0,_loc8_.y - 0))
                        {
                            break;
                        }
                    }
                    for each(_loc13_ in _loc9_.mMapwho)
                    {
                        _loc12_.push(_loc13_);
                    }
                    if(_loc8_.len > _loc7_)
                    {
                        break;
                    }
                }
                return _loc12_;
            }
            return new Array();
        }
        
        public function QGetCellAt(param1:int, param2:int) : CWMCell
        {
            return mCells[param2][param1];
        }
        
        public function _GTL_LineIntersectsLineX(param1:Number, param2:Number) : Boolean
        {
            var _loc3_:Number = NaN;
            var _loc4_:Number = NaN;
            if(Math.abs(_GTL_ldy) < 0.000001)
            {
                return false;
            }
            _loc3_ = param2 / _GTL_ldy;
            if(_loc3_ < 0 || _loc3_ > 1)
            {
                return false;
            }
            if((_loc4_ = (_GTL_ldy * param1 - _GTL_ldx * param2) / -_GTL_ldy) >= 0 && _loc4_ <= 1)
            {
                _GTL_POI = new Point(_GTL_ZEROLOC.x + _loc3_ * _GTL_ldx,_GTL_ZEROLOC.y + _loc3_ * _GTL_ldy);
                return true;
            }
            return false;
        }
        
        public function _GTL_LineIntersectsLineY(param1:Number, param2:Number, param3:Number = 0, param4:Number = 1) : Boolean
        {
            var _loc5_:Number = NaN;
            var _loc6_:Number = NaN;
            if(Math.abs(_GTL_ldx) < 0.000001)
            {
                return false;
            }
            if((_loc5_ = param1 / _GTL_ldx) < 0 || _loc5_ > 1)
            {
                return false;
            }
            if((_loc6_ = (_GTL_ldy * param1 - _GTL_ldx * param2) / _GTL_ldx) >= 0 && _loc6_ <= 1)
            {
                _GTL_POI = new Point(_GTL_ZEROLOC.x + _loc5_ * _GTL_ldx,_GTL_ZEROLOC.y + _loc5_ * _GTL_ldy);
                return true;
            }
            return false;
        }
        
        public function QLineOfSight(param1:Point, param2:Point, param3:Number = 0) : Boolean
        {
            var _loc4_:* = 0;
            var _loc5_:* = null;
            var _loc6_:Number = NaN;
            var _loc7_:* = null;
            var _loc8_:* = null;
            _GTL_Setup(param1,param2);
            _loc4_ = Math.atan2(_GTL_ldy,_GTL_ldx) * a256PI & 255;
            _loc5_ = mSearchLines[_loc4_];
            _loc6_ = Math.sqrt(_GTL_ldv) + param3;
            for each(_loc7_ in _loc5_)
            {
                if((_loc8_ = GetCellAt(param1.x + _loc7_.x,param1.y + _loc7_.y)).mCollide & 0)
                {
                    if(_GTL_COLLIDE(_loc7_.x - 0,_loc7_.y - 0))
                    {
                        return false;
                    }
                }
                if(_loc7_.len > _loc6_)
                {
                    return true;
                }
            }
            return false;
        }
        
        public function _GTL_COLLIDE_BL(param1:Number, param2:Number) : Boolean
        {
            if(_GTL_LineIntersectsLineX(param1,param2 + 1))
            {
                return true;
            }
            if(_GTL_LineIntersectsLineY(param1,param2))
            {
                return true;
            }
            return false;
        }
        
        public function _GTL_COLLIDE_BR(param1:Number, param2:Number) : Boolean
        {
            if(_GTL_LineIntersectsLineX(param1,param2 + 1))
            {
                return true;
            }
            if(_GTL_LineIntersectsLineY(param1 + 1,param2))
            {
                return true;
            }
            return false;
        }
    }
}
