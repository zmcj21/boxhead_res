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
            this.mZombie.mSpeed += 0.05;
            this.mCivilian.mMaxCount++;
        }
        else
        {
            this.mCivilian.mSpawnSpeed = 10;
            this.mCivilian.mMaxCount = 5;
            this.mCivilian.mTargetOutCount = 5;
            this.mZombie.mSpeed = 0.5;
            this.mZombie.mMaxCount = 15;
            this.mZombie.mSpawnSpeed = 60;
        }
        this.mCivilian.mOutCount = 0;
        this.mTick = 0;
        this.mCivilian.mMaxCount = Math.min(this.mCivilian.mMaxCount,10);
        this.mZombie.mMaxCount = Math.min(this.mZombie.mMaxCount,35);
        this.mCivilian.mSpawnSpeed = Math.max(this.mCivilian.mSpawnSpeed,1);
        this.mZombie.mSpawnSpeed = Math.max(this.mZombie.mSpawnSpeed,1);
        this.mZombie.mSpeed = Math.min(this.mZombie.mSpeed,2.5);
        this.mCivilian.mTargetOutCount = this.mCivilian.mMaxCount;
        CHud.CiviliansOut(0,this.mCivilian.mTargetOutCount);
        CCity_Level.mLastLevelIndex = this.mIndex;
        return this.mIndex;
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
        else if(this.mTick % this.mZombie.mSpawnSpeed == 0 && CThing_Zombie.mSpawnCount < this.mZombie.mMaxCount)
        {
            var _loc4_ = CCity._this.mMapwho;
            var _loc3_ = CCity._this.mZombieSpawnPosition[random(CCity._this.mZombieSpawnPosition.length)].mPosition;
            if(_loc4_.GetCellXYZ(_loc3_).mCell.mChildCount)
            {
                _loc3_ = undefined;
                for(var _loc5_ in CCity._this.mZombieSpawnPosition)
                {
                    var _loc2_ = CCity._this.mZombieSpawnPosition[_loc5_].mPosition;
                    if(_loc4_.GetCellXYZ(_loc2_).mCell.mChildCount == 0)
                    {
                        _loc3_ = _loc2_;
                        break;
                    }
                }
            }
            if(_loc3_ != undefined)
            {
                var _loc6_ = CThing.AddThing(new CThing_Zombie(_loc3_,0,this.mZombie.mSpeed));
            }
        }
    }
    static function CivilianOut()
    {
        CCity_Level._this.mCivilian.mOutCount++;
        CHud.CiviliansOut(CCity_Level._this.mCivilian.mOutCount,CCity_Level._this.mCivilian.mTargetOutCount);
    }
}
