class CHud extends MovieClip
{
    var Draw = 0;
    var _CLASSID_ = "CHud";
    static var mVisible = true;
    var cMultiple = 1;
    function CHud()
    {
        super();
        CHud._this = this;
        this.bmMap = new flash.display.BitmapData(this.mcMap._Contents._width / 2,this.mcMap._Contents._height / 2,false,13056);
        this.mcMap._Contents.attachBitmap(this.bmMap,this.mcMap._Contents.getNextHighestDepth(),"auto",false);
        this._Content._Score.mMultiply._alpha = 0;
        this.mTick = 0;
        CHud.CivilianKill();
        CHud.CivilianSaved();
        CHud.ZombieKill();
        this.mScore = 0;
        this.mScores = new Array();
        CHud.AddScore(0);
        this.DefineProgression();
        this._Level._visible = false;
        this._MessageContainer._Message._visible = false;
        this._MessageContainer._Score_Floating._visible = false;
        this._Paused._visible = false;
        this._Paused._Quit.pClass = this;
        this._Paused._Quit.onPress = function()
        {
            CCity._this.mCompleteState = "quit";
        };
        this._Paused._Upgrade._visible = false;
        this._visible = CHud.mVisible;
    }
    function DrawAmmo(tAmmo, p)
    {
        this._MessageContainer._Ammo.gotoAndStop(tAmmo != 100000000 ? 1 : 2);
        this._MessageContainer._Ammo.txtAmount.text = tAmmo;
        this._MessageContainer._Ammo._x = p.x;
        this._MessageContainer._Ammo._y = p.y;
    }
    static function Pause(tState)
    {
        CHud._this._Paused._visible = tState;
        if(tState == true)
        {
            CSound.Pause();
            CHud._this.mPauseTime = 3447;
        }
        else
        {
            CSound.unPause();
            CHud._this.mStartTime += 2384 - CHud._this.mPauseTime;
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
        this.ProcessScores();
        this.ProcessMessages();
        if(CMain.mInput.Pressed(CMain.mInput.mKEY_HUD))
        {
            this._visible = CHud.mVisible = !CHud.mVisible;
        }
    }
    static function AddScore(tScore, p)
    {
        CHud._this.mScore = CHud._this.mScore != undefined ? CHud._this.mScore + tScore : 0;
        if(CHud._this.mScore < 0)
        {
            CHud._this.mScore = 0;
        }
        CHud._this._Score.txtScore.text = CHud.Pad0(String(CHud._this.mScore),12);
        CScreen_Debriefing.mLastScore = CHud._this._Score.txtScore.text;
        if(tScore != 0 && p != undefined)
        {
            var _loc1_ = CHud._this._MessageContainer._Score_Floating.duplicateMovieClip("Score" + CHud._this.mZombiesKilled,CHud._this._MessageContainer.getNextHighestDepth(),{_x:p.x,_y:p.y});
            _loc1_.txtAmount.text = "+" + tScore;
            _loc1_.mDeltaY = 0;
            _loc1_.cacheAsBitmap = false;
            _loc1_.mAlpha = 100;
            CHud._this.mScores[CHud._this.mScores.length] = _loc1_;
            CHud._this.cMultiple = Math.min(CHud._this.cMultiple + 1,100);
            CHud._this.ProcessProgression(CHud._this.cMultiple);
            CHud._this._Score._Timer.mTick = undefined;
        }
    }
    function ProcessScores()
    {
        for(var _loc4_ in this.mScores)
        {
            var _loc3_ = this.mScores[_loc4_];
            _loc3_._y -= _loc3_.mDeltaY;
            _loc3_.mAlpha -= _loc3_.mDeltaY;
            if(_root._quality != "LOW")
            {
                _loc3_._alpha = _loc3_.mAlpha;
            }
            _loc3_.mDeltaY += 0.5;
            if(_loc3_.mAlpha <= 10)
            {
                this.mScores.splice(_loc4_,1);
                _loc3_.removeMovieClip();
            }
        }
        this._Score._Timer.mTick = this._Score._Timer.mTick != undefined ? this._Score._Timer.mTick - this._TickSpeed(this.cMultiple) : 100;
        this._Score._Timer.gotoAndStop(Math.round(this.cMultiple != 1 ? this._Score._Timer.mTick + 1 : 1));
        if(this._Score._Timer.mTick <= 0)
        {
            this.cMultiple = Math.max(this.cMultiple - 1,1);
            this._Score._Timer.mTick = undefined;
        }
        this._Score.txtMultiple.text = "x" + this.cMultiple;
    }
    function _TickSpeed(tMultiple)
    {
        return 1 + Math.pow((tMultiple - 1) / 99,2) * 10;
    }
    function ProcessMessages()
    {
        for(var _loc5_ in this.mMessages)
        {
            var _loc3_ = this.mMessages[_loc5_];
            if(_loc3_.mMoveCount > 0)
            {
                var _loc4_ = _loc3_.mMoveCount * 0.25;
                _loc3_.mActualY -= _loc4_;
                _loc3_.mMoveCount -= _loc4_;
                _loc3_._y = _loc3_.mActualY;
            }
            if(--_loc3_.mLifeCount < 33)
            {
                if(_root._quality != "LOW")
                {
                    _loc3_._alpha -= 3;
                }
            }
            if(_loc3_.mLifeCount == 0)
            {
                _loc3_.removeMovieClip();
                this.mMessages.splice(_loc5_,1);
            }
        }
    }
    function AddMessage(tText, tType)
    {
        this.mMessages = this.mMessages != undefined ? this.mMessages : new Array();
        var _loc4_ = this.mMessages.length;
        var _loc3_ = CHud._this._MessageContainer.createEmptyMovieClip("Message" + _loc4_,CHud._this._MessageContainer.getNextHighestDepth());
        var _loc5_ = _loc3_.attachMovie("Effect.Message","Text",_loc3_.getNextHighestDepth());
        _loc3_._x = CHud._this._MessageContainer._Message._x;
        _loc3_._y = CHud._this._MessageContainer._Message._y;
        _loc5_.txtAmount.text = tText;
        var _loc6_ = _loc3_.getBounds(CHud._this._MessageContainer);
        _loc3_.mMoveCount = 100;
        _loc3_.mLifeCount = 120;
        _loc3_.mActualY = _loc3_._y;
        switch(tType)
        {
            case "vital":
                _loc5_.txtAmount.textColor = 16711680;
                break;
            case "new":
                _loc5_.txtAmount.textColor = 65280;
                break;
            case "info":
                _loc5_.txtAmount.textColor = 16777215;
        }
        0;
        while(0 < _loc4_)
        {
            this.mMessages[0].mMoveCount += 21;
            1;
        }
        this.mMessages[_loc4_] = _loc3_;
        _loc5_.cacheAsBitmap = true;
    }
    function DefineProgression()
    {
        CHud.mProgressionDefinitions = new Object();
        this.mProgressions = new Array();
        this.mProgressions[5] = {mUpgrade:"uzi",mText:"New Weapon: UZI 9mm (Key 2)"};
        this.mProgressions[10] = {mUpgrade:"shotgun",mText:"New Weapon: Shotgun (Key 3)"};
        this.mProgressions[15] = {mUpgrade:"barrel",mText:"New Weapon: Barrel placement (Key 4)"};
        this.mProgressions[20] = {mUpgrade:"grenade",mText:"New Weapon: Grenades (Key 5)"};
        this.mProgressions[25] = {mUpgrade:"rapiduzi",mText:"Upgrade: Rapid-fire UZI"};
        this.mProgressions[30] = {mUpgrade:"bigshotgun",mText:"Upgrade: Shotgun Big shot"};
        this.mProgressions[40] = {mUpgrade:"unlimituzi",mText:"Upgrade: UZI unlimited"};
        this.mProgressions[50] = {mUpgrade:"claymore",mText:"New Weapon: Mines (Key 6)"};
        this.mProgressions[55] = {mUpgrade:"rocketlauncher",mText:"New Weapon: Rocket Launcher (Key 7)"};
        this.mProgressions[60] = {mUpgrade:"bigbarrels",mText:"Upgrade: Bigger bang Barrels"};
        this.mProgressions[65] = {mUpgrade:"biggrenades",mText:"Upgrade: Bigger bang Grenades"};
        this.mProgressions[70] = {mUpgrade:"rapidshotgun",mText:"Upgrade: Rapid-fire Shotgun"};
        this.mProgressions[75] = {mUpgrade:"railgun",mText:"New Weapon: Railgun (Key 8)"};
        this.mProgressions[80] = {mUpgrade:"rapidrailgun",mText:"Upgrade: Rapid-fire Railgun"};
        this.mProgressions[85] = {mUpgrade:"rapidrockets",mText:"Upgrade: Rapid-fire Rocket Launcher"};
        CThing_Player.mActualValidWeapons = ["pistol","uzi","shotgun","barrel","grenade","claymore","rocketlauncher","railgun"];
        CThing_RocketLauncher.UpdateDefaults();
        CThing_ShotGun.UpdateDefaults();
        CThing_Railgun.UpdateDefaults();
        CThing_Grenade.UpdateDefaults();
        CThing_RocketLauncher.UpdateDefaults();
        0;
        0;
        while(0 < this.mProgressions.length)
        {
            if(this.mProgressions[0] != undefined)
            {
                var _loc2_ = this._Paused._Upgrade.duplicateMovieClip("_Upgrade0",this._Paused.getNextHighestDepth(),{_y:this._Paused._Upgrade._y + 0});
                this.mProgressions[0].mc = _loc2_;
                _loc2_._visible = true;
                _loc2_.txtUpgrade.text = this.mProgressions[0].mText;
                _loc2_.txtMultiple.text = "x0";
                _loc2_._alpha = 30;
                _loc2_._Tick._visible = false;
                1;
            }
            1;
        }
    }
    function ProcessProgression(tMultiple)
    {
        if(this.mProgressions[tMultiple] == undefined)
        {
            return undefined;
        }
        if(this.mProgressions[tMultiple].mActive == true)
        {
            return undefined;
        }
        switch(this.mProgressions[tMultiple].mUpgrade)
        {
            case "uzi":
            case "shotgun":
            case "grenade":
            case "barrel":
            case "rocketlauncher":
            case "claymore":
            case "railgun":
                CThing.mTrackThing.NewWeapon(this.mProgressions[tMultiple].mUpgrade);
                break;
            case "rapidrockets":
                CThing_RocketLauncher.UpdateDefaults({mRapidFire:true});
                break;
            case "rapidshotgun":
                CThing_ShotGun.UpdateDefaults({mRapidFire:true});
                break;
            case "bigshotgun":
                CThing_ShotGun.UpdateDefaults({mBig:true});
                break;
            case "rapidrailgun":
                CThing_Railgun.UpdateDefaults({mRapidFire:true});
                break;
            case "unlimituzi":
                CThing_UZI.UpdateDefaults({mUnlimited:true});
                break;
            case "biggrenades":
                CThing_Grenade.UpdateDefaults({mBigBang:true});
                break;
            case "unlimitedgrenades":
                CThing_Grenade.UpdateDefaults({mUnlimited:true});
        }
        this.mProgressions[tMultiple].mActive = true;
        this.AddMessage(this.mProgressions[tMultiple].mText,"new");
        var _loc3_ = this.mProgressions[tMultiple].mc;
        _loc3_._alpha = 100;
        _loc3_._Tick._visible = true;
    }
    static function ZombieKill(p)
    {
        if(Math.abs(CHud._this.mLastScoreTick - CHud._this.mTick) > 3)
        {
            CHud._this.mThisKillCount = 0;
        }
        var _loc2_ = Math.floor(CHud._this.mZombiesKilled / 20);
        CHud._this.mZombiesKilled = CHud._this.mZombiesKilled != undefined ? CHud._this.mZombiesKilled + 1 : 0;
        CHud._this._Content._ZombiesKilled.mAmount.text = CHud.Pad0(String(CHud._this.mZombiesKilled),6);
        var _loc3_ = Math.floor(CHud._this.mZombiesKilled / 20);
        if(_loc2_ != _loc3_)
        {
            var _loc4_ = undefined;
            var _loc1_ = _loc2_;
            while(_loc1_ < _loc3_)
            {
                _loc4_ = CCity_Level._this.NextLevel();
                _loc1_ = _loc1_ + 1;
            }
            if(_loc4_ > 0)
            {
                CHud._this.AddMessage("Level +" + (_loc3_ - _loc2_) + " (" + _loc4_ + ")","info");
            }
        }
        CHud._this.mThisKillCount++;
        CHud.AddScore(100 * CHud._this.cMultiple,p);
        CHud._this.mLastScoreTick = CHud._this.mTick;
        return 100 * CHud._this.cMultiple;
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
                break;
            case "railgun":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponRailgun;
                break;
            case "claymore":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponClaymore;
                break;
            case "barrel":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponBarrel;
                break;
            case "lightning":
                CHud._this.mWeaponCurrent = CHud._this._Content._WeaponLightning;
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
        CHud._this.mStartTime = 2127;
    }
    static function AddTime(tTime)
    {
        CHud._this.mTotalTime += tTime;
    }
}
