class CSound
{
    var InitAtmosphere = 0;
    var _CLASSID_ = "CSound";
    static var mSFXActive = true;
    static var mMUSICActive = true;
    function CSound(tParent)
    {
        CSound.mSound = this;
        var _loc2_ = new Sound();
        CSound.mSoundList = new Array();
        CSound.mProcessList = new Array();
        this.mcParent = tParent;
        CSound.mSamples = new Object();
        CSound.mSamples.Creature_HitFloor_wav = this.RegisterSound("sfx","Creature.HitFloor.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Creature_Player_Scream_1_wav = this.RegisterSound("sfx","Creature.Player.Scream.1.wav",0.7,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Creature_Player_Scream_2_wav = this.RegisterSound("sfx","Creature.Player.Scream.2.wav",0.7,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Creature_Zombie_Hit_1_wav = this.RegisterSound("sfx","Creature.Zombie.Ambience.1.wav",0.4,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Creature_Zombie_Hit_2_wav = this.RegisterSound("sfx","Creature.Zombie.Ambience.2.wav",0.4,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Creature_Zombie_Hit_3_wav = this.RegisterSound("sfx","Creature.Zombie.Ambience.3.wav",0.4,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Creature_Zombie_Hit_4_wav = this.RegisterSound("sfx","Creature.Zombie.Ambience.4.wav",0.4,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Creature_Zombie_Attack_wav = this.RegisterSound("sfx","Creature.Zombie.Attack.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Creature_Zombie_Hit_wav = this.RegisterSound("sfx","Creature.Zombie.Hit.wav",0.3,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Effect_Explosion_wav = this.RegisterSound("sfx","Effect.Explosion.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Object_Barrel_Place_wav = this.RegisterSound("sfx","Object.Barrel.Place.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Object_Mine_Detonate_wav = this.RegisterSound("sfx","Object.Mine.Detonate.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Object_Pickup_wav = this.RegisterSound("sfx","Object.Pickup.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Shot_Grenade_Bounce_wav = this.RegisterSound("sfx","Shot.Grenade.Bounce.wav",0.4,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Shot_HitWall_1_wav = this.RegisterSound("sfx","Shot.HitWall.1.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Shot_HitWall_2_wav = this.RegisterSound("sfx","Shot.HitWall.2.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Shot_HitWall_3_wav = this.RegisterSound("sfx","Shot.HitWall.3.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Shot_Rocket_Fire_wav = this.RegisterSound("sfx","Shot.Rocket.Fire.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Weapon_Mine_Place_wav = this.RegisterSound("sfx","Weapon.Mine.Place.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Weapon_Pistol_Fire_wav = this.RegisterSound("sfx","Weapon.Pistol.Fire.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Weapon_Railgun_Fire_wav = this.RegisterSound("sfx","Weapon.Railgun.Fire.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Weapon_Rocket_Fire_wav = this.RegisterSound("sfx","Weapon.Rocket.Fire.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Weapon_Shotgun_Fire_wav = this.RegisterSound("sfx","Weapon.ShotGun.Fire.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.Weapon_UZI_Fire_wav = this.RegisterSound("sfx","Weapon.UZI.Fire.wav",1,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mSamples.World_End_wav = this.RegisterSound("sfx","World.End.wav",1,this.PlaySound_Normal,this.StopSound_Normal);
        CSound.mSamples.Click = this.RegisterSound("sfx","World.End.wav",1,this.PlaySound_Normal,this.StopSound_Normal);
        CSound.mSamples.Click2 = this.RegisterSound("sfx","CLICK.wav",1,this.PlaySound_Normal,this.StopSound_Normal);
        CSound.mAmbience = new Object();
        CSound.mAmbience.Creature_Zombie_Ambience_1_wav = this.RegisterSound("sfx","Creature.Zombie.Ambience.1.wav",0.4,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mAmbience.Creature_Zombie_Ambience_2_wav = this.RegisterSound("sfx","Creature.Zombie.Ambience.2.wav",0.4,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mAmbience.Creature_Zombie_Ambience_3_wav = this.RegisterSound("sfx","Creature.Zombie.Ambience.3.wav",0.4,this.PlaySound_Positional,this.StopSound_Normal);
        CSound.mAmbience.Creature_Zombie_Ambience_4_wav = this.RegisterSound("sfx","Creature.Zombie.Ambience.4.wav",0.4,this.PlaySound_Positional,this.StopSound_Normal);
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
        _loc2_._visible = false;
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
        CSound.mCurrentAtmosphere.mTimeStamp = 4884;
        CSound.mCurrentAtmosphere.mChannels = new Array(2);
        0;
        while(0 < CSound.mCurrentAtmosphere.mChannels.length)
        {
            CSound.mCurrentAtmosphere.mChannels[0] = new Object();
            CSound.mCurrentAtmosphere.mChannels[0].mCurrentSound = undefined;
            CSound.mCurrentAtmosphere.mChannels[0].mStartTS = undefined;
            CSound.mCurrentAtmosphere.mChannels[0].mStopTS = undefined;
            CSound.mCurrentAtmosphere.mChannels[0].mDelayTS = 3750 + (random(10) + 10) * 1000;
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
                    if(2290 > _loc1_.mDelayTS)
                    {
                        _loc1_.mCurrentSound = CSound.mCurrentAtmosphere.mSFX[random(CSound.mCurrentAtmosphere.mSFX.length)];
                        _loc1_.mCurrentSound.mSound.PlaySound();
                        _loc1_.mCurrentSound.mSound.oSound.setPan(random(200) - 100);
                        _loc1_.mDelayTS = undefined;
                        _loc1_.mStartTS = 3181;
                        _loc1_.mTimeOut = 6302 + (5 + random(20)) * 1000;
                    }
                }
            }
            else if(_loc1_.mCurrentSound.mSound.mPlaying == false)
            {
                _loc1_.mCurrentSound = undefined;
                _loc1_.mStopTS = 10250;
                _loc1_.mDelayTS = 4610 + random(15000);
            }
            else if(_loc1_.mTimeOut != undefined && 9522 > _loc1_.mTimeOut)
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
