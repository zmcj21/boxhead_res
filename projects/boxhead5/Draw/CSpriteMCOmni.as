package Draw
{
    import Landscape.CLSDraw;
    import STC9.Bitmap.CBitmapData;
    import STC9.Math.CFLMatrix;
    import STC9.Math.CMatrix4;
    import STC9.Math.CVector3;
    import flash.display.MovieClip;
    import flash.geom.Matrix;
    import flash.geom.Point;
    
    public class CSpriteMCOmni extends CSprite
    {
        
        private static var ELE_FWIDTH:Number;
        
        private static var ELE_FPLIST1:Array;
        
        private static var ELE_LIST2:Array = [new CVector3(),new CVector3(),new CVector3(),new CVector3()];
        
        private static var ELE_FHEIGHT:Number;
        
        private static var ELE_TMAP1:Array;
        
        private static var ELE_THEIGHT:Number;
        
        private static var ELE_TWIDTH:Number;
        
        private static var ELE_FMAP1:Array;
        
        private static const zMatrix:Matrix = new Matrix(1,0,0,1,0,0);
        
        private static var ELE_TPLIST1:Array;
         
        
        private var mTopID:String;
        
        private var mFrontID:String;
        
        public function CSpriteMCOmni(param1:MovieClip, param2:int = 1, param3:Number = 0, param4:String = "mcTop", param5:String = "mcFront")
        {
            super();
            mFrontID = param5;
            mTopID = param4;
            Buffer(param1,param2,param3);
        }
        
        private function _BufferEle(param1:MovieClip, param2:Number, param3:Number = 0) : CSpriteBMD
        {
            var _loc4_:* = null;
            var _loc5_:Number = NaN;
            var _loc6_:* = null;
            var _loc7_:int = 0;
            var _loc8_:* = null;
            _loc4_ = CMatrix4.Identity_Matrix();
            _loc5_ = param2;
            _loc4_.RotateZ(-_loc5_);
            _loc4_.RotateY(-param3);
            _loc4_.transformVectors(ELE_FPLIST1,ELE_LIST2);
            _loc7_ = -1;
            _loc6_ = new Array();
            while(_loc7_ >= 0)
            {
                _loc8_ = ELE_LIST2[_loc7_];
                _loc6_[_loc7_] = CLSDraw.ProjectionXYZ(_loc8_.x,_loc8_.y,_loc8_.z);
                _loc7_--;
            }
            param1[mFrontID].transform.matrix = CFLMatrix.RemapPlane(ELE_FMAP1,_loc6_);
            param1[mFrontID].visible = param1[mFrontID].width != 0 || param1[mFrontID].height != 0;
            _loc4_.transformVectors(ELE_TPLIST1,ELE_LIST2);
            _loc7_ = -1;
            _loc6_ = new Array();
            while(_loc7_ >= 0)
            {
                _loc8_ = ELE_LIST2[_loc7_];
                _loc6_[_loc7_] = CLSDraw.ProjectionXYZ(_loc8_.x,_loc8_.y,_loc8_.z);
                _loc7_--;
            }
            param1[mTopID].transform.matrix = CFLMatrix.RemapPlane(ELE_TMAP1,_loc6_);
            param1[mTopID].visible = param1[mTopID].width != 0 || param1[mTopID].height != 0;
            return CSpriteBMD.asDisplayObject(param1);
        }
        
        private function Buffer(param1:MovieClip, param2:int = 1, param3:Number = 0) : *
        {
            var _loc4_:* = NaN;
            var _loc5_:int = 0;
            mDirections = new Array();
            if(param3)
            {
                _BufferEle_PRE(param1,param3);
            }
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc4_ < 0)
            {
                mDirections.push(!!param3 ? _BufferEle(param1,_loc4_,param3) : _Buffer(param1,_loc4_));
                _loc4_ += 0 / param2;
                _loc5_++;
            }
            cacheDirections();
        }
        
        private function _BufferEle_PRE(param1:MovieClip, param2:Number = 0) : void
        {
            var _loc3_:Number = NaN;
            var _loc4_:Number = NaN;
            ELE_FWIDTH = param1[mFrontID].width / 2;
            ELE_FHEIGHT = param1[mFrontID].height / 2;
            ELE_TWIDTH = param1[mTopID].width;
            ELE_THEIGHT = param1[mTopID].height / 2;
            _loc3_ = ELE_FWIDTH / 0;
            _loc4_ = ELE_FHEIGHT / 0;
            ELE_FPLIST1 = [new CVector3(0,-_loc3_,-_loc4_),new CVector3(0,-_loc3_,Number(_loc4_)),new CVector3(0,Number(_loc3_),Number(_loc4_)),new CVector3(0,Number(_loc3_),-_loc4_)];
            ELE_FMAP1 = [new Point(-ELE_FWIDTH,-ELE_FHEIGHT),new Point(-ELE_FWIDTH,Number(ELE_FHEIGHT)),new Point(Number(ELE_FWIDTH),Number(ELE_FHEIGHT)),new Point(Number(ELE_FWIDTH),-ELE_FHEIGHT)];
            _loc3_ = ELE_TWIDTH / 0;
            _loc4_ = ELE_THEIGHT / 0;
            ELE_TPLIST1 = [new CVector3(0,-_loc4_),new CVector3(0,Number(_loc4_)),new CVector3(_loc3_,Number(_loc4_)),new CVector3(_loc3_,-_loc4_)];
            ELE_TMAP1 = [new Point(0,-ELE_THEIGHT),new Point(0,Number(ELE_THEIGHT)),new Point(ELE_TWIDTH,Number(ELE_THEIGHT)),new Point(ELE_TWIDTH,-ELE_THEIGHT)];
        }
        
        public function Draw(param1:CBitmapData, param2:int, param3:int, param4:int = 0, param5:Number = 1) : void
        {
            var _loc6_:* = null;
            (_loc6_ = mDirections[param4]).Draw(param1,param2,param3,param5);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CSpriteMCOmni";
        }
        
        override public function toString() : String
        {
            return _CLASSID_;
        }
        
        private function _Buffer(param1:MovieClip, param2:Number) : CSpriteBMD
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:Number = NaN;
            var _loc8_:Number = NaN;
            var _loc9_:* = null;
            var _loc10_:Number = NaN;
            var _loc11_:* = null;
            _loc3_ = new Matrix();
            _loc3_.rotate(param2);
            _loc4_ = CLSDraw.ProjectionPoint(_loc3_.transformPoint(new Point(Infinity,0)));
            _loc5_ = CLSDraw.ProjectionPoint(_loc3_.transformPoint(new Point(0,Infinity)));
            _loc6_ = new Matrix();
            _loc7_ = _loc4_.x;
            _loc8_ = _loc5_.y;
            _loc6_.b = _loc4_.y / _loc7_;
            _loc6_.c = _loc5_.x / _loc8_;
            (_loc9_ = new Matrix()).scale(_loc7_,_loc8_);
            _loc9_.concat(_loc6_);
            param1[mTopID].transform.matrix = _loc9_.clone();
            _loc10_ = param2 + 0;
            (_loc11_ = new Matrix(Math.cos(_loc10_),Math.sin(_loc10_),0,1,0,0)).scale(1,CLSDraw.sProjection);
            param1[mFrontID].transform.matrix = _loc11_;
            return CSpriteBMD.asDisplayObject(param1);
        }
    }
}
