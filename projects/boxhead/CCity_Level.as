class CCity_Level extends MovieClip
{
    var _CLASSID_ = "CCity_Level";
    function CCity_Level()
    {
        super();
        CCity_Level._this = this;
        this.mZombie = new Object();
        this.mCivilian = new Object();
    }
    function NextLevel()
    {
        this.mIndex = this.mIndex != undefined ? this.mIndex + 1 : 0;
        var _loc0_ = null;
        if((_loc0_ = this.mIndex) !== 0)
        {
            this.mZombie.mMaxCount += 5;
            this.mZombie.mSpawnSpeed -= 5;
            if(this.mIndex % 2 == 0)
            {
                this.mZombie.mSpeed += 0.05;
            }
            if(this.mIndex % 5 == 0)
            {
                this.mCivilian.mMaxCount += 5;
            }
        }
        else
        {
            this.mCivilian.mSpawnSpeed = 10;
            this.mCivilian.mMaxCount = 5;
            this.mCivilian.mTargetOutCount = 5;
            this.mZombie.mSpeed = 0.5;
            this.mZombie.mMaxCount = 10;
            this.mZombie.mSpawnSpeed = 120;
        }
        this.mCivilian.mOutCount = 0;
        this.mTick = 0;
        var _loc2_ = undefined;
        switch(this.mIndex)
        {
            case 0:
                CThing.mTrackThing.NewWeapon("pistol");
                "Pistol";
                break;
            case 1:
                CThing.mTrackThing.NewWeapon("uzi");
                "UZI";
                break;
            case 3:
                CThing.mTrackThing.NewWeapon("shotgun");
                "Shotgun";
                break;
            case 5:
                CThing.mTrackThing.NewWeapon("grenade");
                "Grenades";
        }
        this.mCivilian.mMaxCount = Math.min(this.mCivilian.mMaxCount,10);
        this.mZombie.mMaxCount = Math.min(this.mZombie.mMaxCount,40);
        this.mCivilian.mSpawnSpeed = Math.max(this.mCivilian.mSpawnSpeed,1);
        this.mZombie.mSpawnSpeed = Math.max(this.mZombie.mSpawnSpeed,1);
        this.mZombie.mSpeed = Math.min(this.mZombie.mSpeed,1.5);
        this.mCivilian.mTargetOutCount = this.mCivilian.mMaxCount;
        CHud.NewLevel(this.mIndex,"Grenades",this.mCivilian.mTargetOutCount);
        CHud.CiviliansOut(0,this.mCivilian.mTargetOutCount);
        CCity_Level.mLastLevelIndex = this.mIndex;
    }
    function RetryLastLevel()
    {
        var _loc2_ = CCity_Level.mLastLevelIndex;
        while(_loc2_ >= 0)
        {
            this.NextLevel();
            _loc2_ = _loc2_ - 1;
        }
    }
    function Process()
    {
        this.mTick++;
        if(this.mCivilian.mOutCount == this.mCivilian.mTargetOutCount)
        {
            this.NextLevel();
        }
        else
        {
            if(this.mTick % this.mCivilian.mSpawnSpeed == 0 && CThing_Civilian.mSpawnCount < this.mCivilian.mMaxCount - this.mCivilian.mOutCount)
            {
                var _loc2_ = CCity._this.mCivilianSpawnPosition[random(CCity._this.mCivilianSpawnPosition.length)].mPosition;
                CThing.AddThing(new CThing_Civilian(_loc2_,0));
            }
            if(this.mTick % this.mZombie.mSpawnSpeed == 0 && CThing_Zombie.mSpawnCount < this.mZombie.mMaxCount)
            {
                _loc2_ = CCity._this.mZombieSpawnPosition[random(CCity._this.mZombieSpawnPosition.length)].mPosition;
                var _loc3_ = CThing.AddThing(new CThing_Zombie(_loc2_,0,this.mZombie.mSpeed));
            }
        }
    }
    static function CivilianOut()
    {
        CCity_Level._this.mCivilian.mOutCount++;
        CHud.CiviliansOut(CCity_Level._this.mCivilian.mOutCount,CCity_Level._this.mCivilian.mTargetOutCount);
    }
}
