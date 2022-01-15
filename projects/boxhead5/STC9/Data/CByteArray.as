package STC9.Data
{
    import flash.utils.ByteArray;
    
    public class CByteArray extends ByteArray
    {
         
        
        public function CByteArray()
        {
            super();
        }
        
        public function Pad4() : void
        {
            var _loc1_:int = 0;
            _loc1_ = Math.floor((length - 1) / 4 + 1) * 4 - length;
            while(_loc1_ > 0)
            {
                this.writeByte(0);
                _loc1_--;
            }
        }
        
        public function Pad2() : void
        {
            var _loc1_:int = 0;
            _loc1_ = Math.floor((length - 1) / 2 + 1) * 2 - length;
            while(_loc1_ > 0)
            {
                this.writeByte(0);
                _loc1_--;
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CByteArray";
        }
        
        public function UnprotectAlpha() : CByteArray
        {
            var _loc1_:* = null;
            _loc1_ = new CByteArray();
            this.position = 0;
            while(this.position < this.length)
            {
                if(this.position % 4 == 0)
                {
                    this.readByte();
                }
                else
                {
                    _loc1_.writeByte(this.readByte());
                }
            }
            _loc1_.position = 0;
            return _loc1_;
        }
        
        public function PadN(param1:int) : void
        {
            var _loc2_:int = 0;
            _loc2_ = Math.floor((length - 1) / param1 + 1) * param1 - length;
            while(_loc2_ > 0)
            {
                this.writeByte(0);
                _loc2_--;
            }
        }
        
        public function ProtectAlpha() : CByteArray
        {
            var _loc1_:* = null;
            _loc1_ = new CByteArray();
            this.position = 0;
            while(this.position < this.length)
            {
                if(_loc1_.position % 4 == 0)
                {
                    _loc1_.writeByte(255);
                }
                _loc1_.writeByte(this.readByte());
            }
            return _loc1_;
        }
    }
}
