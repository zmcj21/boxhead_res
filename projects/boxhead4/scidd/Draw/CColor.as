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
if(!_global.scidd.Draw.CColor)
{
    var _loc1_ = null;
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    };
    var _loc2_ = scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.prototype;
    _loc2_.toString = function toString()
    {
        return "{R:" + this.mRed + ", G:" + this.mGreen + ", B:" + this.mBlue + ", A:" + this.mAlpha + "}";
    };
    _loc2_.Clone = function Clone()
    {
        return new scidd.Draw.CColor(this.mRed,this.mGreen,this.mBlue,this.mAlpha,this.mBrightness);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.Red = function Red(tAmount)
    {
        tAmount = scidd.Math.CMath.Define(tAmount,255);
        return new scidd.Draw.CColor(tAmount,0,0);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.Green = function Green(tAmount)
    {
        tAmount = scidd.Math.CMath.Define(tAmount,255);
        return new scidd.Draw.CColor(0,tAmount,0);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.Blue = function Blue(tAmount)
    {
        tAmount = scidd.Math.CMath.Define(tAmount,255);
        return new scidd.Draw.CColor(0,0,tAmount);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.White = function White(tAmount)
    {
        tAmount = scidd.Math.CMath.Define(tAmount,255);
        return new scidd.Draw.CColor(tAmount,tAmount,tAmount);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.Grey = function Grey(tAmount)
    {
        tAmount = scidd.Math.CMath.Define(tAmount,128);
        return new scidd.Draw.CColor(tAmount,tAmount,tAmount);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.Clear = function Clear()
    {
        return new scidd.Draw.CColor(0,0,0,0);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.Black = function Black()
    {
        return new scidd.Draw.CColor(0,0,0);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.Blank = function Blank()
    {
        return new scidd.Draw.CColor(0,0,0,0);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.Random = function Random()
    {
        return new scidd.Draw.CColor(random(256),random(256),random(256));
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.FromRGB = function FromRGB(tRGB)
    {
        var _loc3_ = tRGB >> 16 & 255;
        var _loc1_ = tRGB >> 8 & 255;
        var _loc4_ = tRGB >> 0 & 255;
        return new scidd.Draw.CColor(_loc3_,_loc1_,_loc4_,255);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.FromRGB32 = function FromRGB32(tARGB)
    {
        var _loc4_ = tARGB >> 16 & 255;
        var _loc2_ = tARGB >> 8 & 255;
        var _loc5_ = tARGB >> 0 & 255;
        var _loc3_ = tARGB >> 24 & 255;
        return new scidd.Draw.CColor(_loc4_,_loc2_,_loc5_,_loc3_);
    };
    _loc2_.Combine = function Combine(combineColor)
    {
        var _loc2_ = new scidd.Draw.CColor(0,0,0,0);
        _loc2_.mRed = (this.mRed + combineColor.mRed) / 2;
        _loc2_.mGreen = (this.mGreen + combineColor.mGreen) / 2;
        _loc2_.mBlue = (this.mBlue + combineColor.mBlue) / 2;
        _loc2_.mAlpha = (this.mAlpha + combineColor.mAlpha) / 2;
        _loc2_.mBrightness = (this.mBrightness + combineColor.mBrightness) / 2;
        return _loc2_;
    };
    _loc2_.GetBaseColor = function GetBaseColor()
    {
        var _loc2_ = this.Clone();
        return _loc2_;
    };
    _loc2_.getRGB = function getRGB()
    {
        if(this.mBrightness < 0)
        {
            var _loc3_ = scidd.Math.CMath.Range(this.mRed + this.mRed * this.mBrightness,0,255) << 16;
            var _loc2_ = scidd.Math.CMath.Range(this.mGreen + this.mGreen * this.mBrightness,0,255) << 8;
            var _loc4_ = scidd.Math.CMath.Range(this.mBlue + this.mBlue * this.mBrightness,0,255) << 0;
            return _loc3_ | _loc2_ | _loc4_;
        }
        if(this.mBrightness > 0)
        {
            _loc3_ = scidd.Math.CMath.Range(this.mRed + (255 - this.mRed) * this.mBrightness,0,255) << 16;
            _loc2_ = scidd.Math.CMath.Range(this.mGreen + (255 - this.mGreen) * this.mBrightness,0,255) << 8;
            _loc4_ = scidd.Math.CMath.Range(this.mBlue + (255 - this.mBlue) * this.mBrightness,0,255) << 0;
            return _loc3_ | _loc2_ | _loc4_;
        }
        return (this.mRed << 16) + (this.mGreen << 8) + this.mBlue;
    };
    _loc2_.getRGB32 = function getRGB32()
    {
        return this.getRGB() + (this.mAlpha << 24);
    };
    _loc2_.__get__mAlpha100 = function get mAlpha100()
    {
        return Math.round(this.mAlpha * 100 / 255);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.GetColorMatrixFilter = function GetColorMatrixFilter(dMat)
    {
        return new flash.filters.ColorMatrixFilter(dMat);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.ColorMatrix_Identity = function ColorMatrix_Identity()
    {
        return new Array(1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }._BlendMatrix = function _BlendMatrix(mat1, mat2, tAmount)
    {
        var _loc3_ = scidd.Draw.CColor.ColorMatrix_Identity();
        0;
        while(0 < mat1.length)
        {
            _loc3_[0] = scidd.Math.CMath.Tween(mat1[0],mat2[0],tAmount);
            1;
        }
        return _loc3_;
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.ColorMatrix_Colorize = function ColorMatrix_Colorize(tColor, tAmount, tLightness)
    {
        tLightness = scidd.Math.CMath.Define(tLightness,1);
        var _loc1_ = tAmount;
        var _loc5_ = 1 - _loc1_;
        var _loc3_ = tColor.mRed / 255 * (tLightness + 1);
        var _loc6_ = tColor.mGreen / 255 * (tLightness + 1);
        var _loc2_ = tColor.mBlue / 255 * (tLightness + 1);
        var _loc7_ = new Array(_loc5_ + _loc1_ * _loc3_ * scidd.Draw.CColor._LumR,_loc1_ * _loc3_ * scidd.Draw.CColor._LumG,_loc1_ * _loc3_ * scidd.Draw.CColor._LumB,0,0,_loc1_ * _loc6_ * scidd.Draw.CColor._LumR,_loc5_ + _loc1_ * _loc6_ * scidd.Draw.CColor._LumG,_loc1_ * _loc6_ * scidd.Draw.CColor._LumB,0,0,_loc1_ * _loc2_ * scidd.Draw.CColor._LumR,_loc1_ * _loc2_ * scidd.Draw.CColor._LumG,_loc5_ + _loc1_ * _loc2_ * scidd.Draw.CColor._LumB,0,0,0,0,0,1,0);
        return _loc7_;
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.ColorMatrix_Serpia = function ColorMatrix_Serpia(tAmount)
    {
        tAmount = scidd.Math.CMath.Define(tAmount,1);
        var _loc1_ = new Array(0.393,0.769,0.189,0,0,0.349,0.686,0.168,0,0,0.272,0.534,0.131,0,0,0,0,0,1,0);
        return scidd.Draw.CColor._BlendMatrix(scidd.Draw.CColor.ColorMatrix_Identity(),_loc1_,tAmount);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.ColorMatrix_GreyScale = function ColorMatrix_GreyScale(tAmount)
    {
        tAmount = scidd.Math.CMath.Define(tAmount,1);
        var _loc1_ = new Array(scidd.Draw.CColor._LumR,scidd.Draw.CColor._LumG,scidd.Draw.CColor._LumB,0,0,scidd.Draw.CColor._LumR,scidd.Draw.CColor._LumG,scidd.Draw.CColor._LumB,0,0,scidd.Draw.CColor._LumR,scidd.Draw.CColor._LumG,scidd.Draw.CColor._LumB,0,0,0,0,0,1,0);
        return scidd.Draw.CColor._BlendMatrix(scidd.Draw.CColor.ColorMatrix_Identity(),_loc1_,tAmount);
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.ColorMatrix_HUE = function ColorMatrix_HUE(tHue)
    {
        if(tHue != 0)
        {
            var _loc1_ = Math.cos(tHue);
            var _loc2_ = Math.sin(tHue);
            0.213;
            0.715;
            0.072;
            var _loc6_ = new Array(0.213 + _loc1_ * 0.787 + _loc2_ * -0.213,0.715 + _loc1_ * -0.715 + _loc2_ * -0.715,0.072 + _loc1_ * -0.072 + _loc2_ * 0.928,0,0,0.213 + _loc1_ * -0.213 + _loc2_ * 0.143,0.715 + _loc1_ * 0.28500000000000003 + _loc2_ * 0.14,0.072 + _loc1_ * -0.072 + _loc2_ * -0.283,0,0,0.213 + _loc1_ * -0.213 + _loc2_ * -0.787,0.715 + _loc1_ * -0.715 + _loc2_ * 0.715,0.072 + _loc1_ * 0.928 + _loc2_ * 0.072,0,0,0,0,0,1,0,0,0,0,0,1);
            return _loc6_;
        }
        return scidd.Draw.CColor.ColorMatrix_Identity();
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.ColorMatrix_Saturation = function ColorMatrix_Saturation(tSaturation)
    {
        if(tSaturation != 0)
        {
            if(tSaturation > 0)
            {
                tSaturation = tSaturation * 5 + 1;
            }
            else if(tSaturation < 0)
            {
                tSaturation += 1;
            }
            var _loc2_ = (1 - tSaturation) * scidd.Draw.CColor._LumR;
            var _loc3_ = (1 - tSaturation) * scidd.Draw.CColor._LumG;
            var _loc4_ = (1 - tSaturation) * scidd.Draw.CColor._LumB;
            var _loc5_ = new Array(_loc2_ + tSaturation,_loc3_,_loc4_,0,0,_loc2_,_loc3_ + tSaturation,_loc4_,0,0,_loc2_,_loc3_,_loc4_ + tSaturation,0,0,0,0,0,1,0);
            return _loc5_;
        }
        return scidd.Draw.CColor.ColorMatrix_Identity();
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.ColorMatrix_Alpha = function ColorMatrix_Alpha(tAlpha)
    {
        if(tAlpha != 1)
        {
            var _loc1_ = new Array(1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,tAlpha,0);
            return _loc1_;
        }
        return scidd.Draw.CColor.ColorMatrix_Identity();
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.ColorMatrix_Contrast = function ColorMatrix_Contrast(tContrast)
    {
        if(tContrast != 0)
        {
            if(tContrast > 0)
            {
                tContrast *= 5;
            }
            tContrast += 1;
            var _loc2_ = new Array(tContrast,0,0,0,128 * (1 - tContrast),0,tContrast,0,0,128 * (1 - tContrast),0,0,tContrast,0,128 * (1 - tContrast),0,0,0,1,0);
            return _loc2_;
        }
        return scidd.Draw.CColor.ColorMatrix_Identity();
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.ColorMatrix_Brightness = function ColorMatrix_Brightness(tBrightness)
    {
        if(tBrightness != 0)
        {
            tBrightness *= 255;
            var _loc2_ = new Array(1,0,0,0,tBrightness,0,1,0,0,tBrightness,0,0,1,0,tBrightness,0,0,0,1,0);
            return _loc2_;
        }
        return scidd.Draw.CColor.ColorMatrix_Identity();
    };
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }.MatrixMulti = function MatrixMulti(sMat, dMat)
    {
        var _loc6_ = new Array();
        0;
        0;
        while(true)
        {
            0;
            while(true)
            {
                _loc6_[0 + 0] = sMat[0] * dMat[0] + sMat[1] * dMat[5] + sMat[2] * dMat[10] + sMat[3] * dMat[15] + (true ? 0 : sMat[4]);
                1;
            }
            1;
            0;
            5;
        }
        return _loc6_;
    };
    _loc2_._CLASSID_ = "scidd.Draw.CColor";
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }._LumR = 0.3086;
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }._LumG = 0.6094;
    scidd.Draw.CColor = function(tRed, tGreen, tBlue, tAlpha, tBrightness)
    {
        this.mRed = scidd.Math.CMath.Define(tRed,255);
        this.mGreen = scidd.Math.CMath.Define(tGreen,255);
        this.mBlue = scidd.Math.CMath.Define(tBlue,255);
        this.mAlpha = scidd.Math.CMath.Define(tAlpha,255);
        this.mBrightness = scidd.Math.CMath.Define(tBrightness,0);
    }._LumB = 0.082;
    §§push(_loc2_.addProperty("mAlpha100",_loc2_.__get__mAlpha100,0));
    §§push(ASSetPropFlags(scidd.Draw.CColor.prototype,null,1));
}
§§pop();
