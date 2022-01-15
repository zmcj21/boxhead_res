package STC9.Sprite
{
    import STC9.Data.CByteArray;
    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.utils.ByteArray;
    
    public class CSpriteFrame extends BitmapData
    {
        
        private static const nKey:uint = 2772367241;
         
        
        public var mDirectionAmount:int;
        
        public var mModelInfo:Object;
        
        public var mDisplacement:Point;
        
        public var mFrameIndex:int;
        
        public var mAnimID:String;
        
        public var mDirectionIndex:int;
        
        public var mFrameAmount:int;
        
        public function CSpriteFrame(param1:int, param2:int)
        {
            super(param1,param2,true,0);
        }
        
        public static function UnpackBytes(param1:ByteArray) : Object
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:int = 0;
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc7_:int = 0;
            var _loc8_:int = 0;
            var _loc9_:int = 0;
            var _loc10_:* = null;
            _loc2_ = new Object();
            _loc3_ = new CByteArray();
            _loc2_.mAnimID = param1.readUTF();
            _loc2_.mDirectionIndex = param1.readShort();
            _loc2_.mFrameIndex = param1.readShort();
            _loc2_.mTopLeft = new Point();
            _loc2_.mTopLeft.x = param1.readShort();
            _loc2_.mTopLeft.y = param1.readShort();
            _loc4_ = param1.readShort();
            _loc5_ = param1.readShort();
            _loc6_ = param1.readShort();
            _loc7_ = param1.readShort();
            _loc2_.mArea = new Rectangle(_loc4_,_loc5_,_loc6_,_loc7_);
            _loc8_ = param1.readShort();
            _loc2_.mModelInfo = new Object();
            _loc9_ = 0;
            while(_loc9_ < _loc8_)
            {
                (_loc10_ = _loc2_.mModelInfo[param1.readUTF()] = {
                    "mPosition":{
                        "x":0,
                        "y":0,
                        "z":0
                    },
                    "mDirection":{
                        "x":0,
                        "y":0,
                        "z":0
                    }
                }).mPosition.x = param1.readFloat();
                _loc10_.mPosition.y = param1.readFloat();
                _loc10_.mPosition.z = param1.readFloat();
                _loc10_.mDirection.x = param1.readFloat();
                _loc10_.mDirection.y = param1.readFloat();
                _loc10_.mDirection.z = param1.readFloat();
                _loc9_++;
            }
            return _loc2_;
        }
        
        public static function PackBytes(param1:String, param2:int, param3:int, param4:Point, param5:Rectangle, param6:Object = null) : ByteArray
        {
            var _loc7_:* = null;
            var _loc8_:* = null;
            var _loc9_:int = 0;
            var _loc10_:* = null;
            (_loc7_ = new ByteArray()).writeUTF(param1);
            _loc7_.writeShort(param2);
            _loc7_.writeShort(param3);
            _loc7_.writeShort(param4.x);
            _loc7_.writeShort(param4.y);
            _loc7_.writeShort(param5.left);
            _loc7_.writeShort(param5.top);
            _loc7_.writeShort(param5.width);
            _loc7_.writeShort(param5.height);
            if(param6)
            {
                _loc9_ = 0;
                for(_loc8_ in param6)
                {
                    _loc9_++;
                }
                _loc7_.writeShort(_loc9_);
                for(_loc8_ in param6)
                {
                    _loc10_ = param6[_loc8_];
                    _loc7_.writeUTF(_loc8_);
                    _loc7_.writeFloat(_loc10_.mPosition.x);
                    _loc7_.writeFloat(_loc10_.mPosition.y);
                    _loc7_.writeFloat(_loc10_.mPosition.z);
                    _loc7_.writeFloat(_loc10_.mDirection.x);
                    _loc7_.writeFloat(_loc10_.mDirection.y);
                    _loc7_.writeFloat(_loc10_.mDirection.z);
                }
            }
            else
            {
                _loc7_.writeShort(0);
            }
            _loc7_.position = 0;
            return _loc7_;
        }
        
        public function get _CLASSID_() : String
        {
            return "CSpriteFrame";
        }
        
        public function Draw(param1:Graphics, param2:int, param3:int) : *
        {
            param1.beginBitmapFill(this,new Matrix(1,0,0,1,param2 + mDisplacement.x,param3 + mDisplacement.y));
            param1.drawRect(param2 + mDisplacement.x,param3 + mDisplacement.y,width,height);
            param1.endFill();
        }
    }
}
