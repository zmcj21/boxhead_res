if(!_global.Thing)
{
    _global.Thing = new Object();
}
§§pop();
if(!_global.Thing.Math)
{
    _global.Thing.Math = new Object();
}
§§pop();
if(!_global.Thing.Math.CThing_Angle)
{
    var _loc1_ = null;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    };
    var _loc2_ = Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.prototype;
    _loc2_.Clone = function Clone(rads)
    {
        return new Thing.Math.CThing_Angle(this.mRadians);
    };
    _loc2_.toString = function toString()
    {
        return this._CLASSID_ + ":{mRadians=" + this.mRadians + ", mDirection=" + this.__get__mDirection() + "}";
    };
    _loc2_.__get__mAngle = function get mAngle()
    {
        return this.mRadians;
    };
    _loc2_.__set__mAngle = function set mAngle(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    };
    _loc2_.__get__mRotation = function __get__mRotation()
    {
        return this.mRadians * Thing.Math.CThing_Angle.Rad2Deg;
    };
    _loc2_.__set__mRotation = function __set__mRotation(a)
    {
        this.mRadians = a * Thing.Math.CThing_Angle.Deg2Rad;
        return this.__get__mRotation();
    };
    _loc2_.Add = function Add(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(this.mRadians + a);
        return this;
    };
    _loc2_.Sub = function Sub(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(this.mRadians - a);
        return this;
    };
    _loc2_.Random = function Random()
    {
        this.mRadians = Math.random() * Thing.Math.CThing_Angle.PI360;
        return this;
    };
    _loc2_.RandomDirection = function RandomDirection()
    {
        this.__set__mDirection(random(4) * 2);
        return this;
    };
    _loc2_.TurnAngle = function TurnAngle(targetAngle)
    {
        if(targetAngle.mRadians == this.mRadians)
        {
            return 0;
        }
        var _loc2_ = Math.abs(targetAngle.mRadians - this.mRadians) <= Thing.Math.CThing_Angle.PI ? 1 : -1;
        return targetAngle.mRadians <= this.mRadians ? 0 - _loc2_ : _loc2_;
    };
    _loc2_.TurnDirection = function TurnDirection(d2)
    {
        var _loc2_ = this.__get__mDirection();
        if(_loc2_ == d2)
        {
            return 0;
        }
        var _loc3_ = Math.abs(d2 - _loc2_) <= 4 ? 1 : -1;
        return d2 <= _loc2_ ? 0 - _loc3_ : _loc3_;
    };
    _loc2_.AngleDifference = function AngleDifference(targetAngle)
    {
        var _loc2_ = targetAngle.mRadians - this.mRadians;
        return _loc2_ >= 0 - Thing.Math.CThing_Angle.PI ? (_loc2_ <= Thing.Math.CThing_Angle.PI ? _loc2_ : _loc2_ - Thing.Math.CThing_Angle.PI360) : _loc2_ + Thing.Math.CThing_Angle.PI360;
    };
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.Correct = function Correct(a)
    {
        return (a + Thing.Math.CThing_Angle.PI360x100) % Thing.Math.CThing_Angle.PI360;
    };
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.CorrectDirection = function CorrectDirection(d)
    {
        return d & 7;
    };
    _loc2_.__get__mDirection = function get mDirection()
    {
        return Math.round(this.mRadians / Thing.Math.CThing_Angle.mRadsToDirection) & 7;
    };
    _loc2_.__set__mDirection = function set mDirection(d)
    {
        this.mRadians = Thing.Math.CThing_Angle.mDirection_Angles[d & 7];
    };
    _loc2_.__get__mDirectionOpposite = function __get__mDirectionOpposite()
    {
        return Math.round(this.mRadians / Thing.Math.CThing_Angle.mRadsToDirection + Thing.Math.CThing_Angle.mDirection_Amount / 2) & 7;
    };
    _loc2_.ToDirectionN = function ToDirectionN(tNumberOfDirections)
    {
        return Math.round(this.mRadians / (Thing.Math.CThing_Angle.PI360 / tNumberOfDirections)) % tNumberOfDirections;
    };
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.GetDirection = function GetDirection(rads)
    {
        return Math.round(rads / Thing.Math.CThing_Angle.mRadsToDirection) & 7;
    };
    _loc2_.__get__mDelta = function get mDelta()
    {
        return new Thing.Math.CThing_Position(Math.cos(this.mRadians),Math.sin(this.mRadians),0);
    };
    _loc2_.__set__mDelta = function set mDelta(d)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(Math.atan2(d.mY,d.mX));
    };
    _loc2_.__get__mDirectionDelta = function get mDirectionDelta()
    {
        return Thing.Math.CThing_Angle.mDirection_Deltas[this.__get__mDirection()];
    };
    _loc2_.__set__mDirectionDelta = function set mDirectionDelta(d)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(Math.atan2(d.mY,d.mX));
    };
    _loc2_.__get__mDirectionDeltaOpposite = function get mDirectionDeltaOpposite()
    {
        return Thing.Math.CThing_Angle.mDirection_Deltas[this.__get__mDirectionOpposite()];
    };
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.Create_LookupTables = function Create_LookupTables()
    {
        if(Thing.Math.CThing_Angle.mLookup256 == undefined)
        {
            Thing.Math.CThing_Angle.mLookup256 = new Array();
            32;
            while(true)
            {
                Thing.Math.CThing_Angle.mLookup256[32] = new Array();
                255;
                while(true)
                {
                    Thing.Math.CThing_Angle.mLookup256[32][255] = Math.round(31.875) % 32;
                    254;
                }
                31;
            }
        }
    };
    _loc2_._CLASSID_ = "CThing_Angle";
    _loc2_._BASECLASSID_ = "CThing_Angle";
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.PI = 3.141592653589793;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.PI360 = Thing.Math.CThing_Angle.PI * 2;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.PI360x100 = Thing.Math.CThing_Angle.PI360 * 100;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.Deg2Rad = Thing.Math.CThing_Angle.PI / 180;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.Rad2Deg = 180 / Thing.Math.CThing_Angle.PI;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_E = 0;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_SE = 1;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_S = 2;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_SW = 3;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_W = 4;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_NW = 5;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_N = 6;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_NE = 7;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_Amount = 8;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_Amountx100 = Thing.Math.CThing_Angle.mDirection_Amount * 100;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mRadsToDirection = Thing.Math.CThing_Angle.PI * 2 / Thing.Math.CThing_Angle.mDirection_Amount;
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_Deltas = [new Thing.Math.CThing_Position(1,0,0),new Thing.Math.CThing_Position(1,1,0),new Thing.Math.CThing_Position(0,1,0),new Thing.Math.CThing_Position(-1,1,0),new Thing.Math.CThing_Position(-1,0,0),new Thing.Math.CThing_Position(-1,-1,0),new Thing.Math.CThing_Position(0,-1,0),new Thing.Math.CThing_Position(1,-1,0)];
    Thing.Math.CThing_Angle = function(a)
    {
        this.mRadians = Thing.Math.CThing_Angle.Correct(a);
    }.mDirection_Angles = [Thing.Math.CThing_Angle.PI * 0,Thing.Math.CThing_Angle.PI * 0.25,Thing.Math.CThing_Angle.PI * 0.5,Thing.Math.CThing_Angle.PI * 0.75,Thing.Math.CThing_Angle.PI * 1,Thing.Math.CThing_Angle.PI * 1.25,Thing.Math.CThing_Angle.PI * 1.5,Thing.Math.CThing_Angle.PI * 1.75];
    §§push(_loc2_.addProperty("mAngle",_loc2_.__get__mAngle,_loc2_.__set__mAngle));
    §§push(_loc2_.addProperty("mDelta",_loc2_.__get__mDelta,_loc2_.__set__mDelta));
    §§push(_loc2_.addProperty("mDirection",_loc2_.__get__mDirection,_loc2_.__set__mDirection));
    §§push(_loc2_.addProperty("mDirectionDelta",_loc2_.__get__mDirectionDelta,_loc2_.__set__mDirectionDelta));
    §§push(_loc2_.addProperty("mDirectionDeltaOpposite",_loc2_.__get__mDirectionDeltaOpposite,0));
    §§push(_loc2_.addProperty("mDirectionOpposite",_loc2_.__get__mDirectionOpposite,0));
    §§push(_loc2_.addProperty("mRotation",_loc2_.__get__mRotation,_loc2_.__set__mRotation));
    §§push(ASSetPropFlags(Thing.Math.CThing_Angle.prototype,null,1));
}
§§pop();
