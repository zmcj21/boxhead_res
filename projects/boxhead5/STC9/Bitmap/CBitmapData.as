package STC9.Bitmap
{
    import STC9.System.Profiler.CFPS;
    import flash.display.BitmapData;
    import flash.display.DisplayObject;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    
    public class CBitmapData extends BitmapData
    {
        
        private static var mItems:Object;
        
        private static var mTracking:Boolean = false;
        
        private static var mAllocateID:int = 0;
        
        private static var mTotalMemory:Number;
         
        
        public var mOffset:Point;
        
        private var sID:String;
        
        public function CBitmapData(param1:int, param2:int, param3:Boolean = true, param4:uint = 0)
        {
            super(param1,param2,param3,param4);
            if(mTracking)
            {
                sID = "BMD" + ++mAllocateID;
                mItems[sID] = this;
                mTotalMemory += width * height * 4;
                UpdateTotalmem();
            }
        }
        
        public static function Record() : void
        {
            mTracking = true;
            mTotalMemory = 0;
            mItems = new Object();
        }
        
        public static function FromDisplayObject(param1:DisplayObject) : CBitmapData
        {
            var _loc2_:* = null;
            _loc2_ = new CBitmapData(param1.width,param1.height);
            _loc2_.RenderDisplayObject(param1);
            return _loc2_;
        }
        
        public static function ReleaseAll() : void
        {
            var _loc1_:* = null;
            var _loc2_:int = 0;
            if(!mTracking)
            {
                return;
            }
            for each(_loc1_ in mItems)
            {
                _loc1_.dispose();
            }
            _loc2_ = Math.round(mTotalMemory / (1024 * 1024));
            mTracking = false;
        }
        
        override public function dispose() : void
        {
            if(sID)
            {
                mTotalMemory -= width * height * 4;
                UpdateTotalmem();
                delete mItems[sID];
            }
            super.dispose();
        }
        
        private function UpdateTotalmem() : void
        {
            var _loc1_:int = 0;
            _loc1_ = Math.round(mTotalMemory / (1024 * 1024));
            CFPS.AddDebug("BMD.MEM",_loc1_.toString() + "mb");
        }
        
        public function toString() : String
        {
            return "";
        }
        
        public function RenderDisplayObject(param1:DisplayObject) : Point
        {
            var _loc2_:* = null;
            _loc2_ = param1.getBounds(param1);
            mOffset = new Point(-_loc2_.topLeft.x,-_loc2_.topLeft.y);
            draw(param1,new Matrix(1,0,0,1,-_loc2_.topLeft.x,-_loc2_.topLeft.y),null,"normal",null,true);
            return _loc2_.topLeft;
        }
        
        public function GetAverageColor() : Number
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = NaN;
            var _loc5_:* = NaN;
            var _loc6_:* = NaN;
            var _loc7_:* = NaN;
            var _loc8_:Number = NaN;
            var _loc9_:Number = NaN;
            _loc1_ = new BitmapData(8,8,transparent,0);
            _loc2_ = new Matrix(_loc1_.width / width,0,0,_loc1_.height / height,0,0);
            _loc1_.draw(this,_loc2_,null,null,null,true);
            _loc3_ = _loc1_.getPixels(_loc1_.rect);
            _loc3_.position = 0;
            _loc4_ = 0;
            _loc5_ = 0;
            _loc6_ = 0;
            _loc7_ = 0;
            _loc8_ = _loc3_.length / 4;
            while(_loc8_)
            {
                _loc7_ += _loc3_.readUnsignedByte();
                _loc4_ += _loc3_.readUnsignedByte();
                _loc5_ += _loc3_.readUnsignedByte();
                _loc6_ += _loc3_.readUnsignedByte();
                _loc8_--;
            }
            _loc9_ = _loc3_.length / 4;
            _loc7_ = Number(Math.round(_loc7_ / _loc9_));
            _loc4_ = Number(Math.round(_loc4_ / _loc9_));
            _loc5_ = Number(Math.round(_loc5_ / _loc9_));
            _loc6_ = Number(Math.round(_loc6_ / _loc9_));
            return _loc7_ << 24 | _loc4_ << 16 | _loc5_ << 8 | _loc6_ << 0;
        }
        
        public function get _CLASSID_() : String
        {
            return "CBitmapData";
        }
        
        public function get _BASECLASSID_() : String
        {
            return "BitmapData";
        }
    }
}
