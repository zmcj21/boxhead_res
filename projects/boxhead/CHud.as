class CHud extends MovieClip
{
    var _CLASSID_ = "CHud";
    function CHud()
    {
        super();
        CHud._this = this;
        this.bmMap = new flash.display.BitmapData(this.mcMap._Contents._width / 2,this.mcMap._Contents._height / 2,false,13056);
        this.mcMap._Contents.attachBitmap(this.bmMap,this.mcMap._Contents.getNextHighestDepth(),"auto",false);
        this._Content._Score.mMultiply._alpha = 0;
        this._Content.cacheAsBitmap = true;
        this.mTick = 0;
        CHud.CivilianKill();
        CHud.CivilianSaved();
        CHud.ZombieKill();
        this.mScore = 0;
        CHud.AddScore(0);
        this._Level._visible = false;
        this._Paused._visible = false;
        this._Paused._Quit.pClass = this;
        this._Paused._Quit.onPress = function()
        {
            CCity._this.mCompleteState = "quit";
        };
    }
    static function Pause(tState)
    {
        CHud._this._Paused._visible = tState;
        if(tState == true)
        {
            CSound.Pause();
            CHud._this.mPauseTime = 2672;
        }
        else
        {
            CSound.unPause();
            CHud._this.mStartTime += 3577 - CHud._this.mPauseTime;
        }
    }
    function Process()
    {
        this.mTick++;
        if(this._Content._Score.mMultiply._alpha > 0)
        {
            this._Content._Score.mMultiply._alpha -= 2;
        }
        if(this._Level._visible)
        {
            if(--this._Level.mShowTime < 0)
            {
                if(this._Level._alpha > 0)
                {
                    this._Level._alpha -= 2;
                    this._Level._visible = this._Level._alpha > 0;
                }
            }
        }
    }
    function Draw()
    {
        var _loc8_ = CThing.mThingList;
        var _loc17_ = CCity._this.mMapwho;
        var _loc9_ = this.bmMap.width / 2 * CMapwho.mCellSize.x;
        var _loc4_ = CThing.mTrackThing.mPosition;
        var _loc10_ = _loc17_.GetCellPosition(_loc4_.mX,_loc4_.mY);
        var _loc7_ = new flash.geom.Point(this.bmMap.width / 2,this.bmMap.height / 2);
        this.bmMap.fillRect(this.bmMap.rectangle,13056);
        for(var _loc12_ in _loc8_)
        {
            var _loc3_ = _loc8_[_loc12_];
            if(_loc3_.mMapColor != undefined)
            {
                var _loc2_ = _loc3_.mPosition;
                if(Math.abs(_loc2_.mX - _loc4_.mX) < _loc9_ && Math.abs(_loc2_.mY - _loc4_.mY) < _loc9_)
                {
                    var _loc6_ = _loc2_.mX >> CMapwho.mCellSizeShift;
                    var _loc5_ = _loc2_.mY >> CMapwho.mCellSizeShift;
                    this.bmMap.setPixel(_loc6_ - _loc10_.x + _loc7_.x,_loc5_ - _loc10_.y + _loc7_.y,_loc3_.mMapColor);
                }
            }
        }
        this.mcMap._Direction._rotation = Math.atan2(this.mcMap._Blip._y - this.mcMap._Direction._y,this.mcMap._Blip._x - this.mcMap._Direction._x) * 180 / 3.141592653589793;
        var _loc14_ = CCity._this.mCivilianDestinationPosition;
        this.mcMap._Blip._x = (_loc14_.mX - _loc4_.mX) / CMapwho.mCellSize.x * 2 + _loc7_.x * 2;
        this.mcMap._Blip._y = (_loc14_.mY - _loc4_.mY) / CMapwho.mCellSize.y * 2 + _loc7_.y * 2;
        var _loc11_ = this.mTotalTime - (7467 - this.mStartTime);
        if(_loc11_ < 0)
        {
            0;
        }
        if(true)
        {
            CScreen_Debriefing.Retry("outoftime");
        }
        var _loc15_ = Math.floor(0);
        var _loc16_ = Math.floor(0);
        var _loc13_ = CHud.Pad0(String(_loc15_),2) + ":" + CHud.Pad0(String(_loc16_),2);
        if(_loc13_ != this._Content._Timer.mAmount.text)
        {
            this._Content._Timer.mAmount.text = _loc13_;
        }
    }
    static function AddScore(tScore)
    {
        CHud._this.mScore = CHud._this.mScore != undefined ? CHud._this.mScore + tScore : 0;
        if(CHud._this.mScore < 0)
        {
            CHud._this.mScore = 0;
        }
        CHud._this._Content._Score.mAmount.text = CHud.Pad0(String(CHud._this.mScore),9);
        CScreen_Debriefing.mLastScore = CHud._this._Content._Score.mAmount.text;
    }
    static function ZombieKill()
    {
        if(CHud._this.mLastScoreTick != CHud._this.mTick)
        {
            CHud._this.mThisKillCount = 0;
        }
        CHud._this.mZombiesKilled = CHud._this.mZombiesKilled != undefined ? CHud._this.mZombiesKilled + 1 : 0;
        CHud._this._Content._ZombiesKilled.mAmount.text = CHud.Pad0(String(CHud._this.mZombiesKilled),6);
        CHud._this.mLastScoreTick = CHud._this.mTick;
        CHud._this.mThisKillCount++;
        var _loc1_ = Math.min(10,CHud._this.mThisKillCount);
        if(_loc1_ > 1)
        {
            CHud._this._Content._Score.mMultiply._alpha = 200;
            CHud._this._Content._Score.mMultiply.text = "x" + _loc1_;
        }
        CHud.AddScore(200 * _loc1_);
    }
    static function CivilianKill()
    {
        CHud._this.mCiviliansKilled = CHud._this.mCiviliansKilled != undefined ? CHud._this.mCiviliansKilled + 1 : 0;
        CHud._this._Content._CiviliansKilled.mAmount.text = CHud.Pad0(String(CHud._this.mCiviliansKilled),6);
        CHud.AddScore(-1000);
    }
    static function CivilianSaved()
    {
        CHud._this.mCiviliansSaved = CHud._this.mCiviliansSaved != undefined ? CHud._this.mCiviliansSaved + 1 : 0;
        CHud._this._Content._CiviliansSaved.mAmount.text = CHud.Pad0(String(CHud._this.mCiviliansSaved),6);
        CHud.AddScore(500);
    }
    static function Pad0(tText, tAmount)
    {
        while(tText.length < tAmount)
        {
            tText = "0" + tText;
        }
        return tText;
    }
    static function SelectWeapon(tWeaponName, tAmmo, tAmmoTotal)
    {
        var _loc1_ = CHud._this.mWeaponCurrent;
        switch(tWeaponName)
        {
            case "pistol":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponPistol;
                break;
            case "uzi":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponUZI;
                break;
            case "shotgun":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponShotgun;
                break;
            case "rocketlauncher":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponRockets;
                break;
            case "grenade":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponGrenades;
                break;
            case "flamethrower":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponFlamer;
        }
        _loc1_._visible = false;
        CHud._this.mWeaponCurrent._visible = true;
        CHud._this.mWeaponCurrent._x = CHud._this._Content._WeaponPistol._x;
        CHud._this.mWeaponCurrent._y = CHud._this._Content._WeaponPistol._y;
        CHud.UpdateAmmo(tAmmo,tAmmoTotal);
    }
    static function UpdateAmmo(tAmmo, tAmmoTotal)
    {
        CHud._this.mWeaponCurrent.mAmmo.text = tAmmo + "/" + tAmmoTotal;
    }
    static function NewLevel(tLevelIndex, tNewWeapon, tRescueCount)
    {
        CHud._this._Level.mLevelName.text = "LEVEL " + (tLevelIndex + 1);
        if(tLevelIndex == 0)
        {
            CHud._this._Level.mNewWeapon.text = tNewWeapon != undefined ? "New weapon:" + tNewWeapon : "";
        }
        else
        {
            CHud._this._Level.mNewWeapon.text = tNewWeapon != undefined ? "New weapon:" + tNewWeapon + " & +1:30 time" : "";
            CHud.AddTime(90000);
        }
        CHud._this._Level.mObjective.text = "Rescue " + tRescueCount + " civilians!";
        CHud._this._Level._visible = true;
        CHud._this._Level._alpha = 100;
        CHud._this._Level.mShowTime = 60;
    }
    static function CiviliansOut(tCount, tTotal)
    {
        CHud._this._Content._CiviliansSaved.mAmountTemp.text = tCount + "/" + tTotal;
    }
    static function StartTimer(tTotalTime)
    {
        CHud._this.mTotalTime = tTotalTime;
        CHud._this.mStartTime = 4697;
    }
    static function AddTime(tTime)
    {
        CHud._this.mTotalTime += tTime;
    }
}
