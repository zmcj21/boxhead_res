class CSound
{
    var InitAtmosphere = 0;
    var _CLASSID_ = "CSound";
    static var mSFXActive = true;
    static var mMUSICActive = true;
    function CSound(tParent)
    {
        CSound.mSound = this;
        var _loc3_ = new Sound();
        CSound.mSoundList = new Array();
        CSound.mProcessList = new Array();
        this.mcParent = tParent;
        var _loc2_ = this.mcParent.getNextHighestDepth() + 100;
        var _loc4_ = this.mcParent.createEmptyMovieClip("DUMMYMC",_loc2_);
        CSound.mClick = this.RegisterSound("sfx","Scream.1.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mCombot_Destroyed = this.RegisterSound("sfx","Combot_Destroyed.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mCombot_Fire2 = this.RegisterSound("sfx","Combot.Fire.2.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mCombot_Fire = this.RegisterSound("sfx","Combot.Fire.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mCombot_Move = this.RegisterSound("sfx","Combot.Move.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mCombot_Rotate = this.RegisterSound("sfx","Combot.Rotate.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mCombot_Shot = this.RegisterSound("sfx","Combot.Shot.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mCombot_Turret_Rotate = this.RegisterSound("sfx","Combot.Turret.Rotate.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mDroid_Destroyed = this.RegisterSound("sfx","Droid.Destroyed.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mShot_Impact2 = this.RegisterSound("sfx","Shot.Impact.2.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mShot_Impact = this.RegisterSound("sfx","Shot.Impact.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mPickup = this.RegisterSound("sfx","Pickup.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mStart_Arena = this.RegisterSound("sfx","Start.Arena.wav",1,this.PlaySound_Normal,this.StopSound_Normal);
        CSound.mEnd_Arena = this.RegisterSound("sfx","End.Arena.wav",1,this.PlaySound_Normal,this.StopSound_Normal);
        CSound.mDebrief_Score = this.RegisterSound("sfx","Debrief.Score.wav",1,this.PlaySound_Normal,this.StopSound_Normal);
        CSound.mRunningOutOfTime = this.RegisterSound("sfx","RunningOutOfTime.wav",1,this.PlaySound_VolumeAndLoop,this.StopSound_Normal);
        CSound.mSong1_Track1 = this.RegisterSound("music","Song1.Track1.wav",1,this.PlaySound_FadeInAndLoop,this.StopSound_FadeInAndLoop);
        CSound.mSong1_Track2 = this.RegisterSound("music","Song1.Track2.wav",0.9,this.PlaySound_FadeInAndLoop,this.StopSound_FadeInAndLoop);
        CSound.mSong1_Track3 = this.RegisterSound("music","Song1.Track3.wav",0.9,this.PlaySound_FadeInAndLoop,this.StopSound_FadeInAndLoop);
        CSound.mBodyHit1 = this.RegisterSound("sfx","BodyHit.1.wav",0.2,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mBodyHit2 = this.RegisterSound("sfx","BodyHit.2.wav",0.2,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mShotHit1 = this.RegisterSound("sfx","ShotHit.1.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mShotHit2 = this.RegisterSound("sfx","ShotHit.2.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mShotHit3 = this.RegisterSound("sfx","ShotHit.3.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mUZIShot = this.RegisterSound("sfx","UZI.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mShotGunShot = this.RegisterSound("sfx","ShotGun.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mRocketLauncherShot = this.RegisterSound("sfx","RocketLauncher.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mFlameThrowerShot = this.RegisterSound("sfx","FlameThrower.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mPistolShot = this.RegisterSound("sfx","Pistol.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mExplosion1 = this.RegisterSound("sfx","Explosion.1.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mGrenadeBounce = this.RegisterSound("sfx","Grenade.Bounce.wav",0.3,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mPickupWeapon = this.RegisterSound("sfx","PickupWeapon.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mGameOver = this.RegisterSound("sfx","Slow Hit 02.wav",1,this.PlaySound_Normal,this.StopSound_Normal);
        CSound.mCityTraffic1 = this.RegisterSound("sfx","City.Ambience.1.wav",1,this.PlaySound_Loop,this.StopSound_Normal);
        CSound.mZombieAmbience = new Array();
        CSound.mZombieAmbience[0] = this.RegisterSound("sfx","Zombie.Ambience.1.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mZombieAmbience[1] = this.RegisterSound("sfx","Zombie.Ambience.2.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mZombieAmbience[2] = this.RegisterSound("sfx","Zombie.Ambience.3.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mZombieAmbience[3] = this.RegisterSound("sfx","Zombie.Ambience.4.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mZombieHit = new Array();
        CSound.mZombieHit[0] = this.RegisterSound("sfx","Zombie.Ambience.1.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mZombieHit[1] = this.RegisterSound("sfx","Zombie.Ambience.2.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mZombieHit[2] = this.RegisterSound("sfx","Zombie.Ambience.3.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mZombieHit[3] = this.RegisterSound("sfx","Zombie.Ambience.4.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mZombieHit[4] = this.RegisterSound("sfx","Zombie.Hit.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mCivilianHit = new Array();
        CSound.mCivilianHit[0] = this.RegisterSound("sfx","Scream.1.wav",0.7,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mCivilianHit[1] = this.RegisterSound("sfx","Scream.2.wav",0.7,this.PlaySound_Positional,this.StopSound_Normal);
    }
    function StopAll(tType)
    {
        CSound.mProcessList = new Array();
        for(var _loc3_ in CSound.mSoundList)
        {
            if(CSound.mSoundList[_loc3_].mType == tType || tType == undefined)
            {
                this.StopSound(CSound.mSoundList[_loc3_]);
            }
        }
    }
    static function Pause()
    {
        for(var _loc1_ in CSound.mSoundList)
        {
            CSound.mSoundList[_loc1_].mPaused = CSound.mSoundList[_loc1_].mPlaying;
            if(CSound.mSoundList[_loc1_].mPaused)
            {
                CSound.mSoundList[_loc1_].mPosition = CSound.mSoundList[_loc1_].oSound.position;
                CSound.mSoundList[_loc1_].oSound.stop();
            }
        }
    }
    static function unPause()
    {
        for(var _loc1_ in CSound.mSoundList)
        {
            if(CSound.mSoundList[_loc1_].mPaused)
            {
                CSound.mSoundList[_loc1_].oSound.start(CSound.mSoundList[_loc1_].mLoops <= 1 ? CSound.mSoundList[_loc1_].mPosition / 1000 : 0,CSound.mSoundList[_loc1_].mLoops);
            }
        }
    }
    static function SoundActive(tState)
    {
        CSound.mSFXActive = tState;
        if(!CSound.mSFXActive)
        {
            CSound.mSound.StopAll("sfx");
        }
    }
    static function MusicActive(tState)
    {
        CSound.mMUSICActive = tState;
        if(!CSound.mMUSICActive)
        {
            CSound.mSound.StopAll("music");
        }
    }
    function RegisterSound(tType, tLinkID, tVolLevel, fPlay, fStop)
    {
        var _loc3_ = this.mcParent.getNextHighestDepth();
        var _loc2_ = this.mcParent.createEmptyMovieClip("Sound" + _loc3_,_loc3_);
        _loc2_.oSound = new Sound(_loc2_);
        _loc2_.oSound.attachSound(tLinkID);
        _loc2_.oSound.pClass = _loc2_;
        _loc2_.oSound.onSoundComplete = function()
        {
            this.pClass.mPlaying = false;
        };
        _loc2_.mVolumeLevel = tVolLevel;
        _loc2_.mLinkID = tLinkID;
        _loc2_.PlaySound = fPlay;
        _loc2_.StopSound = fStop;
        _loc2_.mPlaying = false;
        _loc2_.pClass = this;
        _loc2_._visible = false;
        _loc2_.mType = tType;
        CSound.mSoundList[CSound.mSoundList.length] = _loc2_;
        return _loc2_;
    }
    function PlaySound(tItem, secOffset, nLoop)
    {
        if(tItem.mType == "sfx" && !CSound.mSFXActive || tItem.mType == "music" && !CSound.mMUSICActive)
        {
            return undefined;
        }
        tItem.mPlaying = true;
        tItem.mLoops = nLoop != undefined ? nLoop : 1;
        tItem.oSound.start(secOffset != undefined ? secOffset : 0,tItem.mLoops);
    }
    function StopSound(tItem)
    {
        tItem.mPlaying = false;
        tItem.oSound.stop();
        tItem.mPaused = false;
        this.RemoveFromProcessList(tItem);
    }
    function SetVolume(tItem, vol)
    {
        tItem.oSound.setVolume(vol * tItem.mVolumeLevel);
    }
    function SetPan(tItem, pan)
    {
        tItem.oSound.setPan(pan);
    }
    static function GetPlayhead(tItem)
    {
        return tItem.oSound.position / tItem.oSound.duration;
    }
    function PlaySound_Normal(tVolume)
    {
        tVolume = tVolume != undefined ? int(scidd.Math.CMath.Range(tVolume,0,100)) : 100;
        var _loc2_ = this;
        if(_loc2_.mPlaying)
        {
            _loc2_.pClass.StopSound(_loc2_);
        }
        _loc2_.pClass.SetVolume(_loc2_,tVolume);
        _loc2_.pClass.PlaySound(_loc2_);
    }
    function StopSound_Normal()
    {
        var _loc2_ = this;
        _loc2_.pClass.StopSound(_loc2_);
    }
    function PlaySound_Positional(p)
    {
        var _loc2_ = this;
        p = p != undefined ? p : new flash.geom.Point(0,0);
        var _loc5_ = scidd.Math.CMath.Range(p.x * 100,-100,100);
        var _loc3_ = scidd.Math.CMath.Range((2 - p.length) / 2 * 100,0,100);
        _loc3_ = _loc3_ != undefined ? int(scidd.Math.CMath.Range(_loc3_,0,100)) : 100;
        if(_loc2_.mPlaying)
        {
            _loc2_.pClass.StopSound(_loc2_);
        }
        _loc2_.pClass.SetPan(_loc2_,_loc5_);
        _loc2_.pClass.SetVolume(_loc2_,_loc3_);
        _loc2_.pClass.PlaySound(_loc2_);
    }
    function PlaySound_Velocity(tVelocity)
    {
        tVelocity = tVelocity != undefined ? scidd.Math.CMath.Range(tVelocity,0,1) : 1;
        if(tVelocity <= 0.1)
        {
            return undefined;
        }
        var _loc2_ = this;
        var _loc4_ = _loc2_.oSound.duration / 1000 * (1 - tVelocity);
        _loc2_.pClass.SetVolume(_loc2_,100);
        _loc2_.pClass.PlaySound(_loc2_,_loc4_);
    }
    function PlaySound_Loop()
    {
        var _loc2_ = this;
        if(!_loc2_.mPlaying)
        {
            _loc2_.pClass.PlaySound(_loc2_,0,100000);
        }
    }
    function PlaySound_VolumeAndLoop(tVolume)
    {
        var _loc2_ = this;
        _loc2_.pClass.SetVolume(_loc2_,tVolume != undefined ? tVolume : 100);
        if(!_loc2_.mPlaying)
        {
            _loc2_.pClass.PlaySound(_loc2_,0,100000);
        }
    }
    function PlaySound_FadeInAndLoop()
    {
        var _loc2_ = this;
        if(_loc2_.mType == "sfx" && !CSound.mSFXActive || _loc2_.mType == "music" && !CSound.mMUSICActive)
        {
            return undefined;
        }
        if(!_loc2_.mPlaying)
        {
            _loc2_.pClass.AddToProcessList(_loc2_);
            _loc2_.pClass.SetVolume(_loc2_,0);
            _loc2_.pClass.PlaySound(_loc2_,0,100000);
        }
        _loc2_.mAction = "fadein";
    }
    function StopSound_FadeInAndLoop()
    {
        var _loc2_ = this;
        _loc2_.mAction = "fadeout";
    }
    static function ProcessAll()
    {
        for(var _loc1_ in CSound.mProcessList)
        {
            CSound.Process(CSound.mProcessList[_loc1_]);
        }
    }
    static function Process(tItem)
    {
        5;
        5;
        switch(tItem.mAction)
        {
            case "fadeout":
                var _loc4_ = tItem.oSound.getVolume() - 5 >= 0 ? tItem.oSound.getVolume() - 5 : 0;
                tItem.pClass.SetVolume(tItem,_loc4_);
                if(_loc4_ == 0)
                {
                    tItem.pClass.StopSound(tItem);
                }
                break;
            case "fadein":
                _loc4_ = tItem.oSound.getVolume() + 5 <= 100 ? tItem.oSound.getVolume() + 5 : 100;
                tItem.pClass.SetVolume(tItem,_loc4_);
                if(_loc4_ == 100)
                {
                    tItem.mAction = "none";
                    break;
                }
        }
    }
    function AddToProcessList(tItem)
    {
        for(var _loc2_ in CSound.mProcessList)
        {
            if(CSound.mProcessList[_loc2_] == tItem)
            {
                return undefined;
            }
        }
        CSound.mProcessList[CSound.mProcessList.length] = tItem;
    }
    function RemoveFromProcessList(tItem)
    {
        for(var _loc2_ in CSound.mProcessList)
        {
            if(CSound.mProcessList[_loc2_] == tItem)
            {
                CSound.mProcessList.splice(_loc2_,1);
                return undefined;
            }
        }
    }
    static function Atmosphere_Start(tIndex)
    {
        if(!CSound.mSFXActive)
        {
            return undefined;
        }
        if(CSound.mCurrentAtmosphere != undefined)
        {
            return undefined;
        }
        CSound.mCurrentAtmosphere = CSound.mAtmosphere[tIndex];
        CSound.mCurrentAtmosphere.mLoop.mSound.PlaySound();
        CSound.mCurrentAtmosphere.mTimeStamp = 1470;
        CSound.mCurrentAtmosphere.mChannels = new Array(2);
        0;
        while(0 < CSound.mCurrentAtmosphere.mChannels.length)
        {
            CSound.mCurrentAtmosphere.mChannels[0] = new Object();
            CSound.mCurrentAtmosphere.mChannels[0].mCurrentSound = undefined;
            CSound.mCurrentAtmosphere.mChannels[0].mStartTS = undefined;
            CSound.mCurrentAtmosphere.mChannels[0].mStopTS = undefined;
            CSound.mCurrentAtmosphere.mChannels[0].mDelayTS = 2591 + (random(10) + 10) * 1000;
            1;
        }
    }
    static function Atmosphere_Stop()
    {
        if(CSound.mCurrentAtmosphere == undefined)
        {
            return undefined;
        }
        CSound.mCurrentAtmosphere.mPaused = false;
        CSound.mCurrentAtmosphere.mLoop.mSound.StopSound();
        0;
        while(0 < CSound.mCurrentAtmosphere.mChannels.length)
        {
            if(CSound.mCurrentAtmosphere.mChannels[0].mCurrentSound != undefined)
            {
                CSound.mCurrentAtmosphere.mChannels[0].mCurrentSound.mSound.StopSound();
                CSound.mCurrentAtmosphere.mChannels[0].mCurrentSound = undefined;
            }
            1;
        }
        CSound.mCurrentAtmosphere = undefined;
    }
    static function Atmosphere_Process()
    {
        if(CSound.mCurrentAtmosphere == undefined || CSound.mCurrentAtmosphere.mPaused == true)
        {
            return undefined;
        }
        if(CSound.mCurrentAtmosphere.mLoop.mSound.mPlaying == false)
        {
            CSound.mCurrentAtmosphere.mLoop.mSound.PlaySound();
        }
        var _loc4_ = CSound.mCurrentAtmosphere.mSFX;
        0;
        0;
        while(0 < CSound.mCurrentAtmosphere.mChannels.length)
        {
            var _loc1_ = CSound.mCurrentAtmosphere.mChannels[0];
            if(_loc1_.mCurrentSound == undefined)
            {
                if(_loc1_.mDelayTS != undefined)
                {
                    if(9196 > _loc1_.mDelayTS)
                    {
                        _loc1_.mCurrentSound = CSound.mCurrentAtmosphere.mSFX[random(CSound.mCurrentAtmosphere.mSFX.length)];
                        _loc1_.mCurrentSound.mSound.PlaySound();
                        _loc1_.mCurrentSound.mSound.oSound.setPan(random(200) - 100);
                        _loc1_.mDelayTS = undefined;
                        _loc1_.mStartTS = 7065;
                        _loc1_.mTimeOut = 6093 + (5 + random(20)) * 1000;
                    }
                }
            }
            else if(_loc1_.mCurrentSound.mSound.mPlaying == false)
            {
                _loc1_.mCurrentSound = undefined;
                _loc1_.mStopTS = 10800;
                _loc1_.mDelayTS = 9733 + random(15000);
            }
            else if(_loc1_.mTimeOut != undefined && 4209 > _loc1_.mTimeOut)
            {
                _loc1_.mTimeOut = undefined;
                _loc1_.mCurrentSound.mSound.StopSound();
            }
            1;
        }
    }
    static function Atmosphere_Pause()
    {
        CSound.mCurrentAtmosphere.mPaused = true;
    }
    static function Atmosphere_unPause()
    {
        CSound.mCurrentAtmosphere.mPaused = false;
    }
}
