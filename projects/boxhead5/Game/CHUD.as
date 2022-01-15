package Game
{
    import STC9.Bitmap.CBitmapData;
    import STC9.IO.CKeyboard;
    import STC9.String.CString;
    import flash.display.BlendMode;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    
    public class CHUD
    {
        
        public static var mDraw:Boolean;
        
        public static var mDrawBlendMode:String;
        
        private static var dColorTransform:ColorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
        
        public static var mSilentMessages:Boolean = false;
         
        
        private var tbKillScore:TextField;
        
        private var mScoreUpdateTick:int;
        
        private var mcLevel:HUD_Level;
        
        private var mcMessage:HUD_Message;
        
        private var dPoint:Point;
        
        private var bmdScore:CBitmapData;
        
        private var mcScore:HUD_Score;
        
        private var lastScore:Number;
        
        private var tbLevel:TextField;
        
        private var mScoreAlpha:Number;
        
        private var tbMessage:TextField;
        
        private var tbScore:TextField;
        
        private var mShowScores:Boolean;
        
        private var tbMultiplier:TextField;
        
        private var mMessages:Array;
        
        private var mcKillScore:HUD_KillScore;
        
        private var mKills:Array;
        
        private var mRenderPos:Point;
        
        private var _Score:Number;
        
        private var mcMultiplier:HUD_Multiplier;
        
        public function CHUD()
        {
            super();
            mcScore = new HUD_Score();
            mcMultiplier = new HUD_Multiplier();
            mcKillScore = new HUD_KillScore();
            mcMessage = new HUD_Message();
            mKills = new Array();
            mMessages = new Array();
            tbScore = mcScore._Contents.tbAmount;
            tbKillScore = mcKillScore._Contents.tbAmount;
            tbMultiplier = mcMultiplier._Contents.tbAmount;
            tbMessage = mcMessage._Contents.tbMessage;
            tbScore.autoSize = TextFieldAutoSize.LEFT;
            tbKillScore.autoSize = TextFieldAutoSize.LEFT;
            tbMultiplier.autoSize = TextFieldAutoSize.LEFT;
            tbMessage.autoSize = TextFieldAutoSize.LEFT;
            mcMessage._Contents._Size.visible = false;
            mcScore._Contents._Size.visible = false;
            mcMultiplier._Contents._Size.visible = false;
            mScoreUpdateTick = 0;
            lastScore = -1;
            _Score = 0;
            mScoreAlpha = 1;
            mRenderPos = new Point(0,0);
            mDraw = CGlobalData.GetData("HUD","on") == "on" ? true : false;
            mDrawBlendMode = CGlobalData.GetData("Quality") == "low" ? "null" : BlendMode.OVERLAY;
            mShowScores = CGlobalData.GetData("Quality") != "low";
        }
        
        public function AddScore(param1:Point, param2:Number) : void
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            if(!mDraw)
            {
                return;
            }
            if(!mShowScores)
            {
                return;
            }
            _loc3_ = dPoint.subtract(param1);
            _loc3_.normalize(3);
            tbKillScore.text = param2.toString();
            _loc4_ = new CBitmapData(mcKillScore.width,mcKillScore.height,true,0);
            param1.x -= _loc4_.width / 2;
            param1.y -= _loc4_.height / 2;
            (_loc5_ = {
                "bmd":_loc4_,
                "pos":param1,
                "dpos":_loc3_
            }).bmd.draw(mcKillScore);
            mKills.push(_loc5_);
        }
        
        private function UpdateScore() : void
        {
            var _loc1_:Boolean = false;
            _loc1_ = true;
            if(lastScore != _Score && --mScoreUpdateTick < 0)
            {
                lastScore = _Score;
                mScoreUpdateTick = CGame.SECONDS;
                if(bmdScore)
                {
                    _loc1_ = false;
                }
                tbScore.text = CString.Pad(_Score.toString(),"0",8);
                if(_loc1_)
                {
                    bmdScore = new CBitmapData(mcScore.width,mcScore._Contents._Size.height,true,0);
                }
                else
                {
                    bmdScore.fillRect(bmdScore.rect,0);
                }
                bmdScore.draw(mcScore,new Matrix(1,0,0,1,0,-mcScore._Contents._Size.y));
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CHUD";
        }
        
        public function set mMultiplier(param1:Number) : void
        {
            tbMultiplier.text = "x" + param1.toString();
        }
        
        public function AddMessage(param1:Point, param2:String, param3:String, param4:Number = 1) : void
        {
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:* = null;
            if(!mDraw)
            {
                return;
            }
            if(mSilentMessages)
            {
                return;
            }
            param1 = param1.clone();
            tbMessage.text = param2;
            mcMessage._Contents.scaleX = mcMessage._Contents.scaleY = param4;
            _loc5_ = mcMessage._Contents._Size.getBounds(mcMessage);
            _loc6_ = new CBitmapData(mcMessage.width,int(_loc5_.height),true,0);
            param1.x -= _loc6_.width / 2;
            param1.y -= _loc6_.height / 2;
            (_loc7_ = {
                "alpha":0,
                "type":param3,
                "bmd":_loc6_,
                "pos":param1,
                "dpos":new Point(0,-3),
                "life":0
            }).mBlendMode = mDrawBlendMode;
            _loc7_.bmd.draw(mcMessage,new Matrix(1,0,0,1,0,-_loc5_.y));
            _loc7_.maxAlpha = _loc7_.mBlendMode == BlendMode.NORMAL ? 0.5 : 1;
            mMessages.push(_loc7_);
        }
        
        public function set mMultiplierCounter(param1:Number) : void
        {
            mcMultiplier._Contents.alpha = param1 * 0.5 + 0.5;
        }
        
        public function set mScore(param1:Number) : void
        {
            _Score = param1;
        }
        
        public function Process() : void
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            var _loc3_:Number = NaN;
            var _loc4_:* = null;
            var _loc5_:int = 0;
            var _loc6_:int = 0;
            var _loc7_:* = null;
            var _loc8_:* = null;
            var _loc9_:* = null;
            var _loc10_:int = 0;
            var _loc11_:* = null;
            var _loc12_:* = null;
            var _loc13_:Number = NaN;
            var _loc14_:Number = NaN;
            if(CKeyboard.IsDown("SHIFT") && CKeyboard.IsDown("CONTROL") && CKeyboard.IsReleased("PAGE_UP"))
            {
                CGlobalData.SetData("HUD",!!mDraw ? "off" : "on");
                mDraw = CGlobalData.GetData("HUD") == "on" ? true : false;
            }
            for each(_loc4_ in mKills.slice())
            {
                _loc1_ = _loc4_.pos;
                _loc2_ = _loc4_.dpos;
                _loc1_.x += _loc2_.x;
                _loc1_.y += _loc2_.y;
                _loc2_.x *= 1.05;
                _loc2_.y *= 1.05;
                _loc3_ = Point.distance(_loc1_,dPoint);
                _loc4_.alpha = Math.min(1,_loc3_ / 100);
                if(_loc4_.ldist)
                {
                    if(_loc3_ > _loc4_.ldist)
                    {
                        mKills.splice(mKills.indexOf(_loc4_),1);
                        _loc4_.bmd.dispose();
                        mScoreAlpha = 1;
                    }
                }
                _loc4_.ldist = _loc3_;
            }
            _loc5_ = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
                _loc9_ = (_loc8_ = mMessages[_loc6_]).pos;
                _loc10_ = _loc6_ + 1;
                while(_loc10_ < _loc5_)
                {
                    _loc12_ = (_loc11_ = mMessages[_loc10_]).pos;
                    if(_loc9_.x + _loc8_.bmd.width > _loc12_.x && _loc12_.x + _loc11_.bmd.width > _loc9_.x)
                    {
                        if(_loc9_.y + _loc8_.bmd.height > _loc12_.y && _loc12_.y + _loc11_.bmd.height > _loc9_.y)
                        {
                            _loc13_ = (_loc8_.bmd.height + _loc11_.bmd.height) / 2;
                            if(_loc12_.y > _loc9_.y)
                            {
                                _loc14_ = _loc13_ - (_loc12_.y - _loc9_.y);
                                _loc9_.y -= _loc14_ * 0.5;
                                _loc12_.y += _loc14_ * 0.5;
                            }
                            else
                            {
                                _loc14_ = _loc13_ - (_loc9_.y - _loc12_.y);
                                _loc9_.y -= _loc14_ * 0.5;
                                _loc12_.y += _loc14_ * 0.5;
                            }
                        }
                    }
                    _loc10_++;
                }
                _loc6_++;
            }
            for each(_loc7_ in mMessages.slice())
            {
                _loc1_ = _loc7_.pos;
                _loc2_ = _loc7_.dpos;
                _loc1_.x += _loc2_.x;
                _loc1_.y += _loc2_.y;
                _loc2_.x *= 0.99;
                _loc2_.y *= 0.99;
                _loc7_.alpha = Math.min(_loc7_.maxAlpha,_loc7_.life >= CGame.SECONDS ? Number(_loc7_.alpha + 0.1) : Number(_loc7_.life / 0));
                if(--_loc7_.life < 0)
                {
                    mMessages.splice(mMessages.indexOf(_loc7_),1);
                    _loc7_.bmd.dispose();
                }
            }
        }
        
        public function Draw(param1:Rectangle, param2:CBitmapData) : void
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            var _loc7_:int = 0;
            var _loc8_:int = 0;
            var _loc9_:* = null;
            var _loc10_:* = null;
            if(!mDraw)
            {
                return;
            }
            CGame.mFPS.StartProfile("HUD_Draw");
            Scroll(param1.topLeft);
            _loc3_ = new Matrix(1,0,0,1,0,0);
            _loc7_ = 1;
            _loc8_ = 0;
            for each(_loc9_ in mKills)
            {
                if(++_loc8_ % _loc7_ == 0)
                {
                    _loc4_ = _loc9_.bmd;
                    _loc5_ = _loc9_.pos;
                    dColorTransform.alphaMultiplier = _loc9_.alpha;
                    _loc3_.tx = _loc5_.x;
                    _loc3_.ty = _loc5_.y;
                    param2.draw(_loc4_,_loc3_,dColorTransform,mDrawBlendMode);
                }
            }
            for each(_loc10_ in mMessages)
            {
                _loc4_ = _loc10_.bmd;
                _loc5_ = _loc10_.pos;
                dColorTransform.alphaMultiplier = _loc10_.alpha;
                _loc3_.tx = _loc5_.x;
                _loc3_.ty = _loc5_.y;
                param2.draw(_loc4_,_loc3_,dColorTransform,_loc10_.mBlendMode);
            }
            UpdateScore();
            _loc3_.tx = param2.width - 0 - 1;
            _loc3_.ty = 0;
            dColorTransform.alphaMultiplier = mScoreAlpha;
            param2.draw(bmdScore,_loc3_,dColorTransform);
            dPoint = new Point(_loc3_.tx + 0,_loc3_.ty + 0);
            if(mScoreAlpha > 0.75)
            {
                mScoreAlpha -= 0.02;
            }
            _loc3_.tx = param2.width - 0 - 1;
            _loc3_.ty += -4;
            param2.draw(mcMultiplier,_loc3_);
            CGame.mFPS.StopProfile("HUD_Draw");
        }
        
        public function Scroll(param1:Point) : void
        {
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            var _loc4_:* = null;
            _loc2_ = Math.round(0 - param1.x);
            _loc3_ = Math.round(0 - param1.y);
            mRenderPos.x = 0 - _loc2_;
            mRenderPos.y = 0 - _loc3_;
            for each(_loc4_ in mMessages)
            {
                _loc4_.pos.x += _loc2_;
                _loc4_.pos.y += _loc3_;
            }
        }
    }
}
