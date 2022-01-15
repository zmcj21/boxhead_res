if(!_global.scidd)
{
    _global.scidd = new Object();
}
§§pop();
if(!_global.scidd.Draw)
{
    _global.scidd.Draw = new Object();
}
§§pop();
if(!_global.scidd.Draw.F3D)
{
    _global.scidd.Draw.F3D = new Object();
}
§§pop();
if(!_global.scidd.Draw.F3D.CMaterial)
{
    var _loc1_ = null;
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    };
    var _loc2_ = scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.prototype;
    _loc2_.Clone = function Clone()
    {
        var _loc2_ = new scidd.Draw.F3D.CMaterial(this.mName);
        _loc2_.mColor = this.mColor.Clone();
        _loc2_.mSourceBitmapData = this.mSourceBitmapData.clone();
        _loc2_.mSmooth = this.mSmooth;
        _loc2_.mUVMatrixDefault = this.mUVMatrixDefault.clone();
        _loc2_.mType = this.mType;
        _loc2_.mLinkageID = this.mLinkageID;
        return _loc2_;
    };
    _loc2_.__get__mNeedsTriangluation = function get mNeedsTriangluation()
    {
        return this.mType == scidd.Draw.F3D.CMaterial.mType_Texture;
    };
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.newSolidColor = function newSolidColor(tName, tColor)
    {
        var _loc1_ = new scidd.Draw.F3D.CMaterial(tName);
        _loc1_.mColor = tColor;
        _loc1_.mType = scidd.Draw.F3D.CMaterial.mType_Solid;
        return _loc1_;
    };
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.newLineColor = function newLineColor(tName, tColor, tThickness)
    {
        var _loc1_ = new scidd.Draw.F3D.CMaterial(tName);
        _loc1_.mColor = tColor;
        _loc1_.mType = scidd.Draw.F3D.CMaterial.mType_Line;
        _loc1_.mThickness = tThickness != undefined ? tThickness : 0;
        return _loc1_;
    };
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.newBitmapData = function newBitmapData(tName, tBitmapData)
    {
        var _loc1_ = new scidd.Draw.F3D.CMaterial(tName);
        if(tBitmapData != undefined)
        {
            _loc1_.mSourceBitmapData = tBitmapData;
            _loc1_.mColor = scidd.Draw.CColor.FromRGB(_loc1_.mSourceBitmapData.getPixel(0,0));
            _loc1_.mType = scidd.Draw.F3D.CMaterial.mType_Texture;
        }
        else
        {
            _loc1_.mType = scidd.Draw.F3D.CMaterial.mType_Solid;
        }
        return _loc1_;
    };
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.newMaterial = function newMaterial(tLinkageID, tColor)
    {
        var _loc1_ = undefined;
        _loc1_ = scidd.Draw.F3D.CMaterial.newBitmapData(tLinkageID,flash.display.BitmapData.loadBitmap(tLinkageID));
        return _loc1_;
    };
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.newMovieClip = function newMovieClip(tName, tLinkageID)
    {
        var _loc1_ = new scidd.Draw.F3D.CMaterial(tName);
        _loc1_.mType = scidd.Draw.F3D.CMaterial.mType_MovieClip;
        _loc1_.mLinkageID = tLinkageID;
        return _loc1_;
    };
    _loc2_.Render = function Render(tDraw_MC, tFace, tBrightness)
    {
        var _loc17_ = tFace.mID;
        var _loc2_ = tFace.mPosition_List_Projected;
        switch(this.mType)
        {
            case scidd.Draw.F3D.CMaterial.mType_Texture:
                var _loc5_ = _loc2_[0];
                var _loc8_ = _loc2_[1];
                var _loc7_ = _loc2_[2];
                var _loc12_ = new flash.geom.Matrix();
                var _loc14_ = _loc8_.mX - _loc5_.mX;
                var _loc15_ = _loc7_.mY - _loc5_.mY;
                _loc12_.b = (_loc8_.mY - _loc5_.mY) / _loc14_;
                _loc12_.c = (_loc7_.mX - _loc5_.mX) / _loc15_;
                var _loc9_ = new flash.geom.Matrix();
                _loc9_.scale(_loc14_ / this.mSourceBitmapData.width,_loc15_ / this.mSourceBitmapData.height);
                _loc9_.concat(_loc12_);
                _loc9_.translate(_loc5_.mX,_loc5_.mY);
                var _loc19_ = tFace.mUVMatrix.clone();
                _loc19_.concat(_loc9_);
                tDraw_MC.lineStyle();
                tDraw_MC.beginBitmapFill(this.mSourceBitmapData,_loc19_,false,false);
                if(_loc2_.length == 3)
                {
                    tDraw_MC.moveTo(_loc5_.mX,_loc5_.mY);
                    tDraw_MC.lineTo(_loc8_.mX,_loc8_.mY);
                    tDraw_MC.lineTo(_loc7_.mX,_loc7_.mY);
                    tDraw_MC.lineTo(_loc5_.mX,_loc5_.mY);
                }
                else
                {
                    tDraw_MC.moveTo(_loc5_.mX,_loc5_.mY);
                    1;
                    while(1 < _loc2_.length)
                    {
                        tDraw_MC.lineTo(_loc2_[1].mX,_loc2_[1].mY);
                        2;
                    }
                    tDraw_MC.lineTo(_loc5_.mX,_loc5_.mY);
                }
                tDraw_MC.endFill();
                var _loc16_ = scidd.Math.CMath.Range(tBrightness,-1,1);
                var _loc21_ = _loc16_ >= 0 ? 16777215 : 0;
                var _loc20_ = Math.abs(_loc16_) * 100;
                tDraw_MC.beginFill(_loc21_,_loc20_);
                if(_loc2_.length == 3)
                {
                    tDraw_MC.moveTo(_loc5_.mX,_loc5_.mY);
                    tDraw_MC.lineTo(_loc8_.mX,_loc8_.mY);
                    tDraw_MC.lineTo(_loc7_.mX,_loc7_.mY);
                    tDraw_MC.lineTo(_loc5_.mX,_loc5_.mY);
                }
                else
                {
                    tDraw_MC.moveTo(_loc5_.mX,_loc5_.mY);
                    1;
                    while(1 < _loc2_.length)
                    {
                        tDraw_MC.lineTo(_loc2_[1].mX,_loc2_[1].mY);
                        2;
                    }
                    tDraw_MC.lineTo(_loc5_.mX,_loc5_.mY);
                }
                tDraw_MC.endFill();
                break;
            case scidd.Draw.F3D.CMaterial.mType_Solid:
            case scidd.Draw.F3D.CMaterial.mType_None:
                this.mColor.mBrightness = scidd.Math.CMath.Range(tBrightness + this.mBrightnessOffset + scidd.Draw.F3D.CMaterial.mGlobal_BrightnessOffset,-1,1);
                tDraw_MC.beginFill(this.mColor.getRGB(),this.mColor.__get__mAlpha100());
                tDraw_MC.lineStyle(1.5,0,35);
                tDraw_MC.moveTo(_loc2_[0].mX,_loc2_[0].mY);
                1;
                while(1 < _loc2_.length)
                {
                    tDraw_MC.lineTo(_loc2_[1].mX,_loc2_[1].mY);
                    2;
                }
                tDraw_MC.lineTo(_loc2_[0].mX,_loc2_[0].mY);
                tDraw_MC.endFill();
                break;
            case scidd.Draw.F3D.CMaterial.mType_Line:
                tDraw_MC.lineStyle(this.mThickness,this.mColor.getRGB(),this.mColor.__get__mAlpha100());
                tDraw_MC.moveTo(_loc2_[0].mX,_loc2_[0].mY);
                1;
                while(1 < _loc2_.length)
                {
                    tDraw_MC.lineTo(_loc2_[1].mX,_loc2_[1].mY);
                    2;
                }
                tDraw_MC.lineTo(_loc2_[0].mX,_loc2_[0].mY);
                break;
            case scidd.Draw.F3D.CMaterial.mType_MovieClip:
                if(_loc2_.length != 4)
                {
                    break;
                }
                _loc5_ = _loc2_[0];
                _loc8_ = _loc2_[1];
                _loc7_ = _loc2_[2];
                var _loc6_ = _loc2_[3];
                var _loc11_ = this.GetMovieClip("A",tDraw_MC,this.mLinkageID + _loc17_ + "A",tBrightness);
                _loc11_._visible = true;
                var _loc10_ = _loc11_.mSize;
                this.mSkewMatrix.b = this.N0(_loc8_.mY - _loc5_.mY) / this.N0(_loc8_.mX - _loc5_.mX);
                this.mSkewMatrix.c = this.N0(_loc7_.mX - _loc8_.mX) / this.N0(_loc7_.mY - _loc8_.mY);
                this.mMatrix.identity();
                this.mMatrix.scale(this.N0(_loc8_.mX - _loc5_.mX) / _loc10_.x,this.N0(_loc7_.mY - _loc8_.mY) / _loc10_.y);
                this.mMatrix.concat(this.mSkewMatrix);
                this.mMatrix.translate(_loc5_.mX,_loc5_.mY);
                _loc11_.transform.matrix = this.mMatrix;
                if(tDraw_MC.mPerpendicular == false)
                {
                    var _loc13_ = this.GetMovieClip("B",tDraw_MC,this.mLinkageID + _loc17_ + "B",tBrightness);
                    _loc13_._visible = true;
                    this.mSkewMatrix.b = this.N0(_loc7_.mY - _loc6_.mY) / this.N0(_loc7_.mX - _loc6_.mX);
                    this.mSkewMatrix.c = this.N0(_loc5_.mX - _loc6_.mX) / this.N0(_loc5_.mY - _loc6_.mY);
                    this.mMatrix.identity();
                    this.mMatrix.scale(this.N0(_loc7_.mX - _loc6_.mX) / _loc10_.x,this.N0(_loc6_.mY - _loc5_.mY) / _loc10_.y);
                    this.mMatrix.concat(this.mSkewMatrix);
                    this.mMatrix.translate(_loc5_.mX,_loc5_.mY);
                    _loc13_.transform.matrix = this.mMatrix;
                    break;
                }
                break;
        }
    };
    _loc2_.ClearMC = function ClearMC(tDraw_MC, tFaceID)
    {
        var tMC_A = eval(tDraw_MC + "." + (this.mLinkageID + tFaceID) + "A");
        var tMC_B = eval(tDraw_MC + "." + (this.mLinkageID + tFaceID) + "B");
        tMC_A._visible = false;
        tMC_B._visible = false;
    };
    _loc2_.GetMovieClip = function GetMovieClip(tSide, tDraw_MC, tLinkageID, tBrightness)
    {
        var tMC = eval(tDraw_MC + "." + tLinkageID);
        if(tMC == undefined)
        {
            tMC = tDraw_MC.attachMovie(this.mLinkageID,tLinkageID,tDraw_MC.getNextHighestDepth());
            tMC.mLinkageID = tLinkageID;
            tMC.mSize = new flash.geom.Point(tMC._width,tMC._height);
            var tval = scidd.Math.CMath.Range(128,-128,128);
            tMC.mColorTransform = new flash.geom.ColorTransform(1,1,1,1,tval,tval,tval,0);
            tMC.mTransform = new flash.geom.Transform(tMC);
            if(tDraw_MC.mPerpendicular == false)
            {
                tMC.mMaskMC = tMC.createEmptyMovieClip("_mask",tMC.getNextHighestDepth());
                tMC.mMaskMC.beginFill(0,100);
                tMC.mMaskMC.moveTo(0,0);
                if(tSide == "A")
                {
                    tMC.mMaskMC.lineTo(tMC.mSize.x,0);
                }
                else
                {
                    tMC.mMaskMC.lineTo(0,tMC.mSize.y);
                }
                tMC.mMaskMC.lineTo(tMC.mSize.x,tMC.mSize.y);
                tMC.mMaskMC.lineTo(0,0);
                tMC.mMaskMC.endFill();
                tMC.setMask(tMC.mMaskMC);
            }
        }
        tMC.mColorTransform.blueOffset = tMC.mColorTransform.greenOffset = tMC.mColorTransform.redOffset = scidd.Math.CMath.Range(tBrightness * 128,-128,128);
        tMC.mTransform.colorTransform = tMC.mColorTransform;
        return tMC;
    };
    _loc2_.N0 = function N0(tNumber)
    {
        return tNumber != 0 ? tNumber : 0.000001;
    };
    _loc2_._CLASSID_ = "scidd.Draw.F3D.CMaterial";
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.mType_None = 0;
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.mType_Texture = 1;
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.mType_MovieClip = 2;
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.mType_Solid = 3;
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.mType_Line = 4;
    scidd.Draw.F3D.CMaterial = function(tName)
    {
        this.mName = tName;
        this.mColor = new scidd.Draw.CColor(255,255,0);
        this.mSmooth = false;
        this.mType = scidd.Draw.F3D.CMaterial.mType_None;
        this.mMatrix = new flash.geom.Matrix();
        this.mSkewMatrix = new flash.geom.Matrix();
        this.mUVMatrix = new Array();
        this.mBrightnessOffset = 0;
    }.mGlobal_BrightnessOffset = 0;
    §§push(_loc2_.addProperty("mNeedsTriangluation",_loc2_.__get__mNeedsTriangluation,0));
    §§push(ASSetPropFlags(scidd.Draw.F3D.CMaterial.prototype,null,1));
}
§§pop();
