if(!_global.World)
{
    _global.World = new Object();
}
§§pop();
if(!_global.World.CHud)
{
    var _loc1_ = null;
    World.CHud = function(tWorld)
    {
        this.mWorld = tWorld;
        this.bmDraw = this.mWorld.bmDraw;
        this.mScores = new Array();
        this.mMessages = new Array();
        this.nTotalScore = 0;
        this.mTotalScore = 0;
        this.mPlayers = new Object();
        if(World.CHud.mcMessage == undefined)
        {
            World.CHud.mcMessage = _root.attachMovie("Hud.Message","_HUD_02",_root.getNextHighestDepth(),{_visible:false});
            World.CHud.mcScore = _root.attachMovie("Hud.Score","_HUD_03",_root.getNextHighestDepth(),{_visible:false});
        }
        World.CHud.mcScoreTotal = this.mWorld.attachMovie("Hud.ScoreTotal","_HUD_04",this.mWorld.getNextHighestDepth(),{_visible:false});
        World.CHud.mcPlayer = this.mWorld.attachMovie("Hud.Player","_HUD_05",this.mWorld.getNextHighestDepth(),{_visible:false});
    };
    var _loc2_ = World.CHud = function(tWorld)
    {
        this.mWorld = tWorld;
        this.bmDraw = this.mWorld.bmDraw;
        this.mScores = new Array();
        this.mMessages = new Array();
        this.nTotalScore = 0;
        this.mTotalScore = 0;
        this.mPlayers = new Object();
        if(World.CHud.mcMessage == undefined)
        {
            World.CHud.mcMessage = _root.attachMovie("Hud.Message","_HUD_02",_root.getNextHighestDepth(),{_visible:false});
            World.CHud.mcScore = _root.attachMovie("Hud.Score","_HUD_03",_root.getNextHighestDepth(),{_visible:false});
        }
        World.CHud.mcScoreTotal = this.mWorld.attachMovie("Hud.ScoreTotal","_HUD_04",this.mWorld.getNextHighestDepth(),{_visible:false});
        World.CHud.mcPlayer = this.mWorld.attachMovie("Hud.Player","_HUD_05",this.mWorld.getNextHighestDepth(),{_visible:false});
    }.prototype;
    _loc2_.toString = function toString()
    {
        return this._CLASSID_;
    };
    _loc2_.Dispose = 0;
    _loc2_.Pause = function Pause(tState)
    {
        if(tState)
        {
            this.mcScreenPause = this.mWorld.attachMovie("HUD.Paused","_PauseScreen",this.mWorld.getNextHighestDepth());
            var _loc4_ = this.mWorld.mUpgrades.__get__mMultiplierList();
            var _loc10_ = Math.ceil(_loc4_.length / 3);
            0;
            0;
            1;
            while(0 < _loc4_.length)
            {
                var _loc5_ = this.mcScreenPause["_Upgrade_C1"];
                var _loc3_ = _loc5_.duplicateMovieClip("upgrade_0",this.mcScreenPause.getNextHighestDepth(),{_x:_loc5_._x,_y:_loc5_._y + 0});
                _loc3_.txtUpgrade.text = _loc4_[0].mName;
                _loc3_.txtMultiple.text = _loc4_[0].mIndex;
                _loc3_.txtUpgrade.textColor = _loc4_[0].mName.substr(0,3) != "New" ? 16777215 : 65280;
                _loc3_._alpha = _loc4_[0].mActive != true ? 25 : 100;
                if(1 > _loc10_)
                {
                    2;
                    0;
                }
                1;
            }
            this.mcScreenPause._Upgrade_C1._visible = false;
            this.mcScreenPause._Upgrade_C2._visible = false;
            this.mcScreenPause._Upgrade_C3._visible = false;
            this.mcScreenPause.cacheAsBitmap = true;
            this.mcScreenPause._Quit.pClass = this.mWorld;
            this.mcScreenPause._Quit.onRelease = function()
            {
                this.pClass.mCompleteState = "quit";
            };
        }
        else
        {
            this.mcScreenPause.removeMovieClip();
            delete this.mcScreenPause;
        }
    };
    _loc2_.Process = 0;
    _loc2_.Draw = function Draw()
    {
        for(var _loc6_ in this.mScores)
        {
            var _loc2_ = this.mScores[_loc6_];
            _loc2_.mPosition = _loc2_.mPosition.add(_loc2_.mDelta);
            _loc2_.mDelta.x *= 1.05;
            _loc2_.mDelta.y *= 1.05;
            this.DrawBMObject(_loc2_.bmObject,_loc2_.mPosition,_loc2_.mPosition.y < 140 ? _loc2_.mPosition.y - 40 : 100);
            if(_loc2_.mPosition.y <= 0)
            {
                this.mScores.splice(Number(_loc6_),1);
            }
        }
        for(_loc6_ in this.mMessages)
        {
            var _loc3_ = this.mMessages[_loc6_];
            var _loc4_ = 1702 - _loc3_.mTimeStamp;
            if(_loc4_ >= 3000)
            {
                this.mMessages.splice(Number(_loc6_),1);
                return undefined;
            }
            if(_loc3_.mMoveCount > 0)
            {
                var _loc5_ = _loc3_.mMoveCount * 0.25;
                _loc3_.mPosition.y -= _loc5_;
                _loc3_.mMoveCount -= _loc5_;
            }
            this.DrawBMObject(_loc3_.bmObject,_loc3_.mPosition,_loc4_ < 2500 ? 100 : 100 - (_loc4_ - 2500) / 5);
        }
        World.CHud.mcScoreTotal._visible = true;
        this.mTotalScore = this.nTotalScore;
        World.CHud.mcScoreTotal.tfScore.text = this.PadScore(String(this.mTotalScore));
        World.CHud.mcScoreTotal.mcTimer.gotoAndStop(1 + Math.floor(this.mWorld.mUpgrades.__get__mMultiplierTickRatio() * World.CHud.mcScoreTotal.mcTimer._totalframes));
        World.CHud.mcScoreTotal.tfMultiple.text = "x" + this.mWorld.mUpgrades.__get__mMultiplier();
        World.CHud.mcScoreTotal._x = this.mWorld.mScreenSize.x / 2;
        World.CHud.mcScoreTotal._y = 0;
    };
    _loc2_.PadScore = function PadScore(s)
    {
        while(s.length < 12)
        {
            s = "0" + s;
        }
        return s;
    };
    _loc2_.__get__mScore = function get mScore()
    {
        return World.CHud.mcScoreTotal.tfScore.text;
    };
    _loc2_.DrawPlayer = function DrawPlayer(tPlayer, pDraw)
    {
        var _loc1_ = tPlayer.mWeapon_Current.mAmmo;
        var _loc2_ = tPlayer.mLife / tPlayer.mMaxLife;
        World.CHud.mcPlayer.mcAmmo.gotoAndStop(_loc1_ != Thing.Weapon.CThing_Weapon.mInfinateAmmo ? 1 : 2);
        World.CHud.mcPlayer.mcAmmo.tfAmount.text = _loc1_;
        var _loc4_ = Math.min(Math.max(1,World.CHud.mcPlayer.mcLife._totalframes * _loc2_ + 1),World.CHud.mcPlayer.mcLife._totalframes);
        World.CHud.mcPlayer.mcLife.gotoAndStop(Math.floor(_loc4_));
        World.CHud.mcPlayer._visible = true;
        World.CHud.mcPlayer._x = pDraw.x;
        World.CHud.mcPlayer._y = pDraw.y;
    };
    _loc2_.AddMessage_Info = function AddMessage_Info(tText)
    {
        this.AddMessage(tText,16777215);
    };
    _loc2_.AddMessage_Level = function AddMessage_Level(tText)
    {
        this.AddMessage(tText,16777215);
    };
    _loc2_.AddMessage_Upgrade = function AddMessage_Upgrade(tText)
    {
        this.AddMessage(tText,65280);
    };
    _loc2_.AddMessage_Critical = function AddMessage_Critical(tText)
    {
        this.AddMessage(tText,16711680);
    };
    _loc2_.AddMessage = function AddMessage(tText, tColor)
    {
        if(this.mSilentMessages)
        {
            return undefined;
        }
        World.CHud.mcMessage.tfMessage.text = tText;
        World.CHud.mcMessage.tfMessage.textColor = tColor;
        var _loc3_ = new flash.geom.Point(this.mWorld.mScreenSize.x / 2,this.mWorld.mScreenSize.y);
        for(var _loc2_ in this.mMessages)
        {
            this.mMessages[_loc2_].mMoveCount += 19;
        }
        this.mMessages.push({mPosition:_loc3_,mMoveCount:100,mTimeStamp:3058,bmObject:World.CHud.RenderMovieClipAsBitmapObject(World.CHud.mcMessage)});
    };
    _loc2_.AddScore = function AddScore(p, tScore)
    {
        this.nTotalScore += tScore;
        World.CHud.mcScore.tfAmount.text = "+" + tScore;
        var _loc3_ = new flash.geom.Point(World.CHud.mcScoreTotal._x - p.x,World.CHud.mcScoreTotal._y - p.y);
        _loc3_.normalize(5);
        if(_root._quality != "LOW")
        {
            this.mScores.push({mPosition:p,mDelta:_loc3_,bmObject:World.CHud.RenderMovieClipAsBitmapObject(World.CHud.mcScore)});
        }
    };
    _loc2_.DrawBMObject = function DrawBMObject(bmObject, p, tAlpha)
    {
        var _loc3_ = bmObject.mDisp;
        if(tAlpha >= 100 || _root._quality == "LOW")
        {
            var _loc5_ = bmObject.sBMD;
            World.CHud.dPoint.x = p.x + _loc3_.x;
            World.CHud.dPoint.y = p.y + _loc3_.y;
            this.bmDraw.copyPixels(_loc5_,_loc5_.rectangle,World.CHud.dPoint,undefined,undefined,true);
        }
        else
        {
            World.CHud.dMatrix.tx = p.x + _loc3_.x;
            World.CHud.dMatrix.ty = p.y + _loc3_.y;
            World.CHud.dColorTransform.alphaMultiplier = tAlpha / 100;
            this.bmDraw.draw(bmObject.sBMD,World.CHud.dMatrix,World.CHud.dColorTransform);
        }
        return true;
    };
    World.CHud = function(tWorld)
    {
        this.mWorld = tWorld;
        this.bmDraw = this.mWorld.bmDraw;
        this.mScores = new Array();
        this.mMessages = new Array();
        this.nTotalScore = 0;
        this.mTotalScore = 0;
        this.mPlayers = new Object();
        if(World.CHud.mcMessage == undefined)
        {
            World.CHud.mcMessage = _root.attachMovie("Hud.Message","_HUD_02",_root.getNextHighestDepth(),{_visible:false});
            World.CHud.mcScore = _root.attachMovie("Hud.Score","_HUD_03",_root.getNextHighestDepth(),{_visible:false});
        }
        World.CHud.mcScoreTotal = this.mWorld.attachMovie("Hud.ScoreTotal","_HUD_04",this.mWorld.getNextHighestDepth(),{_visible:false});
        World.CHud.mcPlayer = this.mWorld.attachMovie("Hud.Player","_HUD_05",this.mWorld.getNextHighestDepth(),{_visible:false});
    }.RenderMovieClipAsBitmapObject = function RenderMovieClipAsBitmapObject(mc, bmObject)
    {
        World.CHud.StartRender();
        if(bmObject == undefined)
        {
            var _loc1_ = mc.getBounds(mc);
            var _loc5_ = new flash.geom.Rectangle(Math.floor(_loc1_.xMin),Math.floor(_loc1_.yMin),Math.ceil(_loc1_.xMax) - Math.floor(_loc1_.xMin),Math.ceil(_loc1_.yMax) - Math.floor(_loc1_.yMin));
            var _loc6_ = new flash.display.BitmapData(Math.ceil(_loc5_.width),Math.ceil(_loc5_.height),true,16711680);
            var _loc3_ = new flash.geom.Point(_loc5_.x,_loc5_.y);
            World.CHud.rm.tx = 0 - _loc3_.x;
            World.CHud.rm.ty = 0 - _loc3_.y;
            _loc6_.draw(mc,World.CHud.rm,undefined,"normal",undefined,false);
            World.CHud.EndRender();
            return {sBMD:_loc6_,mDisp:_loc3_,mBounds:_loc5_};
        }
        bmObject.sBMD.fillRect(bmObject.sBMD.rectangle,0);
        _loc5_ = bmObject.mBounds;
        World.CHud.rm.tx = 0 - _loc5_.x;
        World.CHud.rm.ty = 0 - _loc5_.y;
        bmObject.sBMD.draw(mc,World.CHud.rm,undefined,"normal",undefined,false);
        World.CHud.EndRender();
        return bmObject;
    };
    World.CHud = function(tWorld)
    {
        this.mWorld = tWorld;
        this.bmDraw = this.mWorld.bmDraw;
        this.mScores = new Array();
        this.mMessages = new Array();
        this.nTotalScore = 0;
        this.mTotalScore = 0;
        this.mPlayers = new Object();
        if(World.CHud.mcMessage == undefined)
        {
            World.CHud.mcMessage = _root.attachMovie("Hud.Message","_HUD_02",_root.getNextHighestDepth(),{_visible:false});
            World.CHud.mcScore = _root.attachMovie("Hud.Score","_HUD_03",_root.getNextHighestDepth(),{_visible:false});
        }
        World.CHud.mcScoreTotal = this.mWorld.attachMovie("Hud.ScoreTotal","_HUD_04",this.mWorld.getNextHighestDepth(),{_visible:false});
        World.CHud.mcPlayer = this.mWorld.attachMovie("Hud.Player","_HUD_05",this.mWorld.getNextHighestDepth(),{_visible:false});
    }.StartRender = function StartRender(tScale)
    {
        World.CHud.mBackQuality = World.CHud.mBackQuality != undefined ? World.CHud.mBackQuality : _root._quality;
        _root._quality = "BEST";
    };
    World.CHud = function(tWorld)
    {
        this.mWorld = tWorld;
        this.bmDraw = this.mWorld.bmDraw;
        this.mScores = new Array();
        this.mMessages = new Array();
        this.nTotalScore = 0;
        this.mTotalScore = 0;
        this.mPlayers = new Object();
        if(World.CHud.mcMessage == undefined)
        {
            World.CHud.mcMessage = _root.attachMovie("Hud.Message","_HUD_02",_root.getNextHighestDepth(),{_visible:false});
            World.CHud.mcScore = _root.attachMovie("Hud.Score","_HUD_03",_root.getNextHighestDepth(),{_visible:false});
        }
        World.CHud.mcScoreTotal = this.mWorld.attachMovie("Hud.ScoreTotal","_HUD_04",this.mWorld.getNextHighestDepth(),{_visible:false});
        World.CHud.mcPlayer = this.mWorld.attachMovie("Hud.Player","_HUD_05",this.mWorld.getNextHighestDepth(),{_visible:false});
    }.EndRender = function EndRender()
    {
        _root._quality = World.CHud.mBackQuality;
        delete World.CHud.mBackQuality;
    };
    _loc2_._CLASSID_ = "CHud";
    _loc2_._BASECLASSID_ = "CHud";
    _loc2_.mSilentMessages = false;
    World.CHud = function(tWorld)
    {
        this.mWorld = tWorld;
        this.bmDraw = this.mWorld.bmDraw;
        this.mScores = new Array();
        this.mMessages = new Array();
        this.nTotalScore = 0;
        this.mTotalScore = 0;
        this.mPlayers = new Object();
        if(World.CHud.mcMessage == undefined)
        {
            World.CHud.mcMessage = _root.attachMovie("Hud.Message","_HUD_02",_root.getNextHighestDepth(),{_visible:false});
            World.CHud.mcScore = _root.attachMovie("Hud.Score","_HUD_03",_root.getNextHighestDepth(),{_visible:false});
        }
        World.CHud.mcScoreTotal = this.mWorld.attachMovie("Hud.ScoreTotal","_HUD_04",this.mWorld.getNextHighestDepth(),{_visible:false});
        World.CHud.mcPlayer = this.mWorld.attachMovie("Hud.Player","_HUD_05",this.mWorld.getNextHighestDepth(),{_visible:false});
    }.dPoint = new flash.geom.Point();
    World.CHud = function(tWorld)
    {
        this.mWorld = tWorld;
        this.bmDraw = this.mWorld.bmDraw;
        this.mScores = new Array();
        this.mMessages = new Array();
        this.nTotalScore = 0;
        this.mTotalScore = 0;
        this.mPlayers = new Object();
        if(World.CHud.mcMessage == undefined)
        {
            World.CHud.mcMessage = _root.attachMovie("Hud.Message","_HUD_02",_root.getNextHighestDepth(),{_visible:false});
            World.CHud.mcScore = _root.attachMovie("Hud.Score","_HUD_03",_root.getNextHighestDepth(),{_visible:false});
        }
        World.CHud.mcScoreTotal = this.mWorld.attachMovie("Hud.ScoreTotal","_HUD_04",this.mWorld.getNextHighestDepth(),{_visible:false});
        World.CHud.mcPlayer = this.mWorld.attachMovie("Hud.Player","_HUD_05",this.mWorld.getNextHighestDepth(),{_visible:false});
    }.dMatrix = new flash.geom.Matrix();
    World.CHud = function(tWorld)
    {
        this.mWorld = tWorld;
        this.bmDraw = this.mWorld.bmDraw;
        this.mScores = new Array();
        this.mMessages = new Array();
        this.nTotalScore = 0;
        this.mTotalScore = 0;
        this.mPlayers = new Object();
        if(World.CHud.mcMessage == undefined)
        {
            World.CHud.mcMessage = _root.attachMovie("Hud.Message","_HUD_02",_root.getNextHighestDepth(),{_visible:false});
            World.CHud.mcScore = _root.attachMovie("Hud.Score","_HUD_03",_root.getNextHighestDepth(),{_visible:false});
        }
        World.CHud.mcScoreTotal = this.mWorld.attachMovie("Hud.ScoreTotal","_HUD_04",this.mWorld.getNextHighestDepth(),{_visible:false});
        World.CHud.mcPlayer = this.mWorld.attachMovie("Hud.Player","_HUD_05",this.mWorld.getNextHighestDepth(),{_visible:false});
    }.dColorTransform = new flash.geom.ColorTransform(1,1,1,1,0,0,0,0);
    World.CHud = function(tWorld)
    {
        this.mWorld = tWorld;
        this.bmDraw = this.mWorld.bmDraw;
        this.mScores = new Array();
        this.mMessages = new Array();
        this.nTotalScore = 0;
        this.mTotalScore = 0;
        this.mPlayers = new Object();
        if(World.CHud.mcMessage == undefined)
        {
            World.CHud.mcMessage = _root.attachMovie("Hud.Message","_HUD_02",_root.getNextHighestDepth(),{_visible:false});
            World.CHud.mcScore = _root.attachMovie("Hud.Score","_HUD_03",_root.getNextHighestDepth(),{_visible:false});
        }
        World.CHud.mcScoreTotal = this.mWorld.attachMovie("Hud.ScoreTotal","_HUD_04",this.mWorld.getNextHighestDepth(),{_visible:false});
        World.CHud.mcPlayer = this.mWorld.attachMovie("Hud.Player","_HUD_05",this.mWorld.getNextHighestDepth(),{_visible:false});
    }.rm = new flash.geom.Matrix();
    §§push(_loc2_.addProperty("mScore",_loc2_.__get__mScore,0));
    §§push(ASSetPropFlags(World.CHud.prototype,null,1));
}
§§pop();
