package STC9.Security
{
    public class CSecureNumber extends CSecureVar
    {
         
        
        private var _Number:Number;
        
        private var _Validation:Number;
        
        public function CSecureNumber(param1:Number = 0)
        {
            super();
            _Number = param1;
            _Validation = GetValidationCode(_Number);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CSecureNumber";
        }
        
        public function set mNumber(param1:Number) : void
        {
            if(GetValidationCode(_Number) !== _Validation)
            {
                param1 = 0;
            }
            _Number = param1;
            _Validation = GetValidationCode(_Number);
        }
        
        public function get mNumber() : Number
        {
            return GetValidationCode(_Number) == _Validation ? Number(_Number) : Number(0);
        }
        
        public function toString() : String
        {
            return mNumber.toString();
        }
        
        private function GetValidationCode(param1:Number) : Number
        {
            var _loc2_:* = NaN;
            var _loc3_:* = null;
            var _loc4_:int = 0;
            _loc2_ = 0;
            _loc3_ = param1.toString();
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
                _loc2_ += _loc3_.charCodeAt(_loc4_);
                _loc4_++;
            }
            return _loc2_;
        }
    }
}
