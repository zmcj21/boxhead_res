package Thing
{
    import Draw.CGenExplosion;
    import Draw.CGenFire;
    import Draw.CGenSmoke;
    import Draw.CSpriteMCAnimation;
    import Draw.CSpriteMCOmni;
    import Draw.CSpriteXSIAnimation;
    import Landscape.CLSDraw;
    import Landscape.CLSEffects;
    import STC9.Bitmap.CBitmapData;
    import STC9.Sprite.CSpriteSheet;
    import flash.display.BitmapData;
    import flash.display.MovieClip;
    import flash.geom.Point;
    
    public class CThingDraw extends CThingAudio
    {
        
        public static const defAnimSpeed:Number = 0.1;
        
        public static var bmdPlane:CBitmapData;
        
        public static var mSFXLayer:CLSEffects;
        
        private static var mCacheList:Object;
         
        
        public var mSpriteXSIAnimation:CSpriteXSIAnimation;
        
        public var mAnimationFrame:Number;
        
        public var preRenderPosition:Point;
        
        public var SetAnimation:Function;
        
        public var rpFloor:Point;
        
        public var mDrawScale:Number;
        
        public var mGenFire:CGenFire;
        
        public var mFloorZ:Number;
        
        public var mGenSmoke:CGenSmoke;
        
        public var mRenderPosition:Point;
        
        public var GetFrameCount:Function;
        
        public var mInvisible:Boolean;
        
        public var mSpriteMCAnimation:CSpriteMCAnimation;
        
        public var GetDirectionCount:Function;
        
        public var mGenExplosion:CGenExplosion;
        
        public var lAnimationFrame:Number;
        
        public var mcDrawInfo:MovieClip;
        
        public var mSortDepth:Number;
        
        public var mSpriteMCOmni:CSpriteMCOmni;
        
        public var ObjectRender:Function;
        
        public var mXSI_AnimList:Object;
        
        public var mAlpha:Number;
        
        public function CThingDraw()
        {
            super();
        }
        
        private function ActivateGenFire(param1:String) : Boolean
        {
            var id:String = param1;
            mGenFire = mCacheList[id][int(Math.random() * mCacheList[id].length)];
            ObjectRender = function():*
            {
                mGenFire.Draw(bmdPlane,mRenderPosition.x,mRenderPosition.y,mAnimationFrame,mAlpha,mDrawScale);
            };
            GetFrameCount = function():*
            {
                return mGenFire.mFrameCount;
            };
            GetDirectionCount = function():int
            {
                return 1;
            };
            SetAnimation = function():Boolean
            {
                return true;
            };
            InitDefaults();
            return true;
        }
        
        public function MCOmniExists(param1:String) : Boolean
        {
            return !!idExists(param1,mCacheList) ? Boolean(ActivateMCOmni(param1)) : false;
        }
        
        public function AddDrawDefault() : void
        {
            InitDefaults();
        }
        
        public function SpriteSheet_Render() : *
        {
            mSpriteXSIAnimation.Draw(bmdPlane,mRenderPosition.x,mRenderPosition.y,mAngle.mAngle256,mAnimationFrame,mAlpha);
        }
        
        public function MCOmni_Render() : *
        {
            mSpriteMCOmni.Draw(bmdPlane,mRenderPosition.x,mRenderPosition.y,mAngle.mAngle256,mAlpha);
        }
        
        private function ActivateGenSmoke(param1:String) : Boolean
        {
            var id:String = param1;
            mGenSmoke = mCacheList[id][int(Math.random() * mCacheList[id].length)];
            ObjectRender = function():*
            {
                mGenSmoke.Draw(bmdPlane,mRenderPosition.x,mRenderPosition.y,mAnimationFrame,mAlpha,mDrawScale);
            };
            GetFrameCount = function():*
            {
                return mGenSmoke.mFrameCount;
            };
            GetDirectionCount = function():int
            {
                return 1;
            };
            SetAnimation = function():Boolean
            {
                return true;
            };
            InitDefaults();
            return true;
        }
        
        public function SpriteSheet_SetAnimation(param1:String) : Boolean
        {
            if(mXSI_AnimList[param1] == mSpriteXSIAnimation)
            {
                return true;
            }
            if(true)
            {
                return false;
            }
            mSpriteXSIAnimation = mXSI_AnimList[param1];
            mAnimationFrame = 0;
            return true;
        }
        
        private function idExists(param1:String, param2:Object) : Boolean
        {
            if(param2)
            {
                if(param2[param1])
                {
                    return true;
                }
            }
            return false;
        }
        
        public function AddSpriteSheet(param1:String, param2:BitmapData, param3:Boolean = false) : void
        {
            var _loc4_:* = null;
            _loc4_ = CSpriteXSIAnimation.asSpriteSheet(CSpriteSheet.AsBitmapData(param2),param3);
            mCacheList = !!mCacheList ? mCacheList : new Object();
            mCacheList[param1] = _loc4_;
            ActivateSpriteSheet(param1);
            param2.dispose();
        }
        
        public function AnimateEnd(param1:Number = 0.1) : Boolean
        {
            mAnimationFrame += param1;
            if(mAnimationFrame >= 1)
            {
                mAnimationFrame = 0.99;
                return true;
            }
            return false;
        }
        
        private function ActivateGenExplosion(param1:String) : Boolean
        {
            var id:String = param1;
            mGenExplosion = mCacheList[id][int(Math.random() * mCacheList[id].length)];
            ObjectRender = function():*
            {
                mGenExplosion.Draw(bmdPlane,mRenderPosition.x,mRenderPosition.y,mAnimationFrame,mAlpha,mDrawScale);
            };
            GetFrameCount = function():*
            {
                return mGenExplosion.mFrameCount;
            };
            GetDirectionCount = function():int
            {
                return 1;
            };
            SetAnimation = function():Boolean
            {
                return true;
            };
            InitDefaults();
            return true;
        }
        
        public function AddMCAnimation(param1:String, param2:MovieClip) : void
        {
            var _loc3_:* = null;
            _loc3_ = new CSpriteMCAnimation(param2);
            mCacheList = !!mCacheList ? mCacheList : new Object();
            mCacheList[param1] = _loc3_;
            ActivateMCAnimation(param1);
        }
        
        public function SpriteSheet_GetModelOffset(param1:String) : CThingV3
        {
            var _loc2_:* = null;
            _loc2_ = mSpriteXSIAnimation.GetData(mAngle.mAngle256,mAnimationFrame).mModelInfo[param1];
            return !!_loc2_ ? _loc2_.mPosition : null;
        }
        
        public function SpriteSheetExists(param1:String) : Boolean
        {
            return !!idExists(param1,mCacheList) ? Boolean(ActivateSpriteSheet(param1)) : false;
        }
        
        public function GenSmokeExists(param1:String) : Boolean
        {
            return !!idExists(param1,mCacheList) ? Boolean(ActivateGenSmoke(param1)) : false;
        }
        
        public function SpriteSheet_GetModelInfo() : Object
        {
            return mSpriteXSIAnimation.GetData(mAngle.mAngle256,mAnimationFrame).mModelInfo;
        }
        
        public function GenFireExists(param1:String) : Boolean
        {
            return !!idExists(param1,mCacheList) ? Boolean(ActivateGenFire(param1)) : false;
        }
        
        public function MCAnimationExists(param1:String) : Boolean
        {
            return !!idExists(param1,mCacheList) ? Boolean(ActivateMCAnimation(param1)) : false;
        }
        
        public function MCAnimation_Render() : *
        {
            mSpriteMCAnimation.Draw(bmdPlane,mRenderPosition.x,mRenderPosition.y,mAnimationFrame,mAlpha,mDrawScale);
        }
        
        public function GenExplosionExists(param1:String) : Boolean
        {
            return !!idExists(param1,mCacheList) ? Boolean(ActivateGenExplosion(param1)) : false;
        }
        
        public function AddGenSmoke(param1:String, param2:Array, param3:Number = 0.9) : void
        {
            var _loc4_:int = 0;
            mCacheList = !!mCacheList ? mCacheList : new Object();
            mCacheList[param1] = new Array();
            _loc4_ = 2;
            while(_loc4_)
            {
                mCacheList[param1].push(new CGenSmoke(param2,param3,7));
                _loc4_--;
            }
            ActivateGenSmoke(param1);
        }
        
        public function AddMCOmni(param1:String, param2:MovieClip, param3:int, param4:Number = 0) : void
        {
            var _loc5_:* = null;
            _loc5_ = new CSpriteMCOmni(param2,param3,param4);
            mCacheList = !!mCacheList ? mCacheList : new Object();
            mCacheList[param1] = _loc5_;
            ActivateMCOmni(param1);
        }
        
        private function InitDefaults() : void
        {
            mAnimationFrame = 0;
            mAlpha = !!isNaN(mAlpha) ? 1 : Number(mAlpha);
            mDrawScale = !!isNaN(mDrawScale) ? 1 : Number(mDrawScale);
            mRenderPosition = new Point();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingDraw";
        }
        
        private function ActivateSpriteSheet(param1:String) : Boolean
        {
            var id:String = param1;
            mXSI_AnimList = mCacheList[id];
            ObjectRender = SpriteSheet_Render;
            GetFrameCount = function():int
            {
                return mSpriteXSIAnimation.mFrameCount;
            };
            GetDirectionCount = function():int
            {
                return mSpriteXSIAnimation.mDirectionAmount;
            };
            SetAnimation = SpriteSheet_SetAnimation;
            InitDefaults();
            return true;
        }
        
        private function ActivateMCOmni(param1:String) : Boolean
        {
            var id:String = param1;
            mSpriteMCOmni = mCacheList[id];
            ObjectRender = MCOmni_Render;
            GetFrameCount = function():*
            {
                return 1;
            };
            GetDirectionCount = function():int
            {
                return mSpriteMCOmni.mDirectionAmount;
            };
            InitDefaults();
            return true;
        }
        
        public function Render() : void
        {
            ObjectRender();
            mDrawn = true;
        }
        
        public function Animate(param1:Number = 0.1) : void
        {
            mAnimationFrame += param1;
        }
        
        public function ProjectionXYZ(param1:Number, param2:Number, param3:Number = 0) : Point
        {
            return CLSDraw.ProjectionXYZ(param1,param2,param3);
        }
        
        public function AddGenExplosion(param1:String, param2:Number = 0.9) : void
        {
            var _loc3_:int = 0;
            mCacheList = !!mCacheList ? mCacheList : new Object();
            mCacheList[param1] = new Array();
            _loc3_ = 4;
            while(_loc3_)
            {
                mCacheList[param1].push(new CGenExplosion([Explosion_0001],param2,5));
                _loc3_--;
            }
            ActivateGenExplosion(param1);
        }
        
        private function ActivateMCAnimation(param1:String) : Boolean
        {
            var id:String = param1;
            mSpriteMCAnimation = mCacheList[id];
            ObjectRender = MCAnimation_Render;
            GetFrameCount = function():*
            {
                return mSpriteMCAnimation.mFrameCount;
            };
            GetDirectionCount = function():int
            {
                return 1;
            };
            SetAnimation = function():Boolean
            {
                return true;
            };
            InitDefaults();
            return true;
        }
        
        public function AddGenFire(param1:String, param2:Number = 0.75) : void
        {
            var _loc3_:int = 0;
            mCacheList = !!mCacheList ? mCacheList : new Object();
            mCacheList[param1] = new Array();
            _loc3_ = 4;
            while(_loc3_)
            {
                mCacheList[param1].push(new CGenFire([Fire_0001],param2,4));
                _loc3_--;
            }
            ActivateGenFire(param1);
        }
    }
}
