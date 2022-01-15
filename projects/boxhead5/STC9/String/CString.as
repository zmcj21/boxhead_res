package STC9.String
{
    import flash.utils.ByteArray;
    
    public class CString
    {
         
        
        public function CString()
        {
            super();
        }
        
        public static function MakeAlpha(param1:String) : String
        {
            var _loc2_:* = null;
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            _loc2_ = "";
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
                if((_loc4_ = param1.charCodeAt(_loc3_)) >= 65 && _loc4_ <= 91 || _loc4_ >= 97 && _loc4_ <= 122 || _loc4_ >= 48 && _loc4_ <= 57)
                {
                    _loc2_ += param1.substr(_loc3_,1);
                }
                _loc3_++;
            }
            return _loc2_;
        }
        
        public static function Trim(param1:String) : String
        {
            return TrimL(TrimR(param1));
        }
        
        public static function FormatAsNumber(param1:Number) : String
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            _loc2_ = Math.floor(param1).toString();
            _loc3_ = "";
            _loc4_ = 0;
            _loc5_ = _loc2_.length - 1;
            while(_loc5_ >= 0)
            {
                _loc3_ = _loc2_.charAt(_loc5_) + _loc3_;
                if(++_loc4_ % 3 == 0 && _loc5_ != 0)
                {
                    _loc3_ = "," + _loc3_;
                }
                _loc5_--;
            }
            return _loc3_;
        }
        
        public static function Pad(param1:*, param2:String, param3:Number, param4:Boolean = true) : String
        {
            var _loc5_:* = null;
            _loc5_ = param1;
            while(_loc5_.length < param3)
            {
                _loc5_ = !!param4 ? param2 + _loc5_ : _loc5_ + param2;
            }
            return _loc5_;
        }
        
        private static function TrimInvalid(param1:String) : Boolean
        {
            switch(param1.charCodeAt(0))
            {
                case 13:
                case 10:
                case 9:
                case 32:
                    return true;
                default:
                    return false;
            }
        }
        
        public static function TrimR(param1:String) : String
        {
            while(TrimInvalid(param1.substr(param1.length - 1)))
            {
                param1 = param1.substring(0,param1.length - 1);
            }
            return param1;
        }
        
        public static function TrimL(param1:String) : String
        {
            while(TrimInvalid(param1.substr(0,1)))
            {
                param1 = param1.substring(1);
            }
            return param1;
        }
        
        public static function ByteArrayToHex(param1:ByteArray) : String
        {
            var _loc2_:int = 0;
            var _loc3_:* = null;
            param1.position = 0;
            _loc2_ = param1.length;
            _loc3_ = "";
            while(_loc2_)
            {
                _loc3_ += CString.Pad(param1.readUnsignedByte().toString(16),"0",2);
                _loc2_--;
            }
            return _loc3_;
        }
        
        public function get _CLASSID_() : String
        {
            return "CString";
        }
    }
}
