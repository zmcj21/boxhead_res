package World
{
    import Game.CGame;
    import Game.CGlobalData;
    import Game.CHUD;
    import STC9.IO.CKeyboard;
    import STC9.System.Profiler.CFPS;
    import Thing.CDevil;
    import Thing.CMummy;
    import Thing.CPeepPlayer;
    import Thing.CRunner;
    import Thing.CThingAngle;
    import Thing.CThingPeep;
    import Thing.CVampire;
    import Thing.CZombie;
    
    public class CLevel
    {
        
        public static const MAXLEVEL:Number = 250;
        
        public static const MUMMYRATIO:Number = 0.1;
        
        public static var LEVELINITCOUNT:int = 5;
        
        public static const DEVILRATIO:Number = 0.01;
        
        public static var MAXSCORE:Number = 0;
        
        public static const RUNNERRATIO:Number = 0.2;
        
        public static const VAMPIRERATIO:Number = 0.05;
        
        public static const ZOMBIERATIO:Number = 1 - (RUNNERRATIO + MUMMYRATIO + VAMPIRERATIO + DEVILRATIO);
         
        
        private var mEdgeSpawnIndex:int;
        
        private var mEdgeSpawnPositions:Array;
        
        public var mWorld:CWorld;
        
        private var mLevelInitCounter:int;
        
        private var mLevelObject:Object;
        
        private var mLevels:Array;
        
        private var mOpenSpawnIndex:int;
        
        public var mLevelStats:CLevelStats;
        
        private var mSpawnIndex:int;
        
        private var mOpenSpawnPositions:Array;
        
        private var _LevelIndex:int;
        
        public var mUpgradePeep:CPeepPlayer;
        
        public var mWorldMap:CWorldMap;
        
        public function CLevel(param1:CWorld)
        {
            super();
            mWorld = param1;
            mWorldMap = param1.mMap;
            CreateSpawnPositions();
            SetupLevels();
            mLevelStats = new CLevelStats(this);
            LEVELINITCOUNT = CGame.mLevelData.mMode == "DEFENCE" ? 0 : int(CGame.SECONDS);
            mLevelInitCounter = LEVELINITCOUNT;
        }
        
        private function EnemyKilled(param1:CThingPeep) : void
        {
            --mActiveCount;
        }
        
        private function AddEdgeSpawnPosition(param1:CWMCell) : void
        {
            var _loc2_:* = null;
            var _loc3_:* = null;
            _loc2_ = CWMCNeighbours.mNeighboursDirections4;
            for each(_loc3_ in _loc2_)
            {
                if(!(param1.mNeighbours[_loc3_].mCollide & 0))
                {
                    mEdgeSpawnPositions.push(new CSpawnPosition(param1,_loc3_));
                    return;
                }
            }
        }
        
        private function EnemyScore(param1:CThingPeep) : void
        {
            CGlobalData.AddStat(param1.mName + " kills",1,"ADD");
            CGlobalData.AddStat("Total kills",1,"ADD");
            mLevelStats.AddKillScore(param1);
        }
        
        private function GetSpawnPositionEdge() : CSpawnPosition
        {
            var _loc1_:int = 0;
            var _loc2_:* = null;
            _loc1_ = 20;
            while(_loc1_)
            {
                mEdgeSpawnIndex = (mEdgeSpawnIndex + 1) % 0;
                _loc2_ = mEdgeSpawnPositions[mEdgeSpawnIndex];
                if(_loc2_.mCell.mNeighbours[_loc2_.mDirection].mCollide <= eWMCCollideType.EDGE)
                {
                    return _loc2_;
                }
                _loc1_--;
            }
            return null;
        }
        
        private function RandomInt(param1:int) : Number
        {
            return mWorld.mThingContainer.RandomInt(param1);
        }
        
        private function Levelup_CreateEnemy(param1:int, param2:Number, param3:Number, param4:Number, param5:Class, param6:Function) : Object
        {
            return {
                "mRatio":param2,
                "mSpeed":Math.min(2.5,Math.max(1,param3)),
                "mAttack":Math.min(5,Math.max(1,param4)),
                "mCount":0,
                "mTotal":Math.round(param1 * param2),
                "cInitClass":param5,
                "InitPosition":param6,
                "mSpawnCount":0
            };
        }
        
        private function GetSpawnPositionOpen() : CSpawnPosition
        {
            var _loc1_:int = 0;
            var _loc2_:* = null;
            _loc1_ = 20;
            while(_loc1_)
            {
                mOpenSpawnIndex = (mOpenSpawnIndex + 1) % 0;
                _loc2_ = mOpenSpawnPositions[mOpenSpawnIndex];
                if(_loc2_.mCell.mCollide == eWMCCollideType.NONE)
                {
                    return _loc2_;
                }
                _loc1_--;
            }
            return null;
        }
        
        private function AddOpenSpawnPosition(param1:CWMCell) : void
        {
            mOpenSpawnPositions.push(new CSpawnPosition(param1,"ANY"));
        }
        
        private function get mSpawnCount() : int
        {
            return mLevelObject.mSpawnCount;
        }
        
        public function get _CLASSID_() : String
        {
            return "CLevel";
        }
        
        private function SetupLevels() : void
        {
            var _loc1_:int = 0;
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            var _loc4_:Number = NaN;
            var _loc5_:Number = NaN;
            var _loc6_:Number = NaN;
            var _loc7_:int = 0;
            var _loc8_:int = 0;
            var _loc9_:* = null;
            var _loc10_:* = null;
            var _loc11_:Number = NaN;
            var _loc12_:Number = NaN;
            var _loc13_:Boolean = false;
            var _loc14_:* = null;
            mLevels = new Array();
            mLevelIndex = 0;
            MAXSCORE = 0;
            _loc7_ = CGlobalData.GetData("Quality") == "low" ? 250 : 500;
            _loc8_ = 1;
            while(_loc8_ <= MAXLEVEL)
            {
                _loc9_ = null;
                (_loc10_ = new Object()).mSpawnCount = 0;
                _loc10_.mActiveCount = 0;
                _loc10_.mEnemys = new Array();
                _loc11_ = (_loc8_ - 1) * 0.05 + 1;
                _loc12_ = (_loc8_ - 1) * 0.05 + 1;
                if(_loc8_ >= 5)
                {
                    _loc13_ = _loc8_ >= 50 && _loc8_ % 5 == 0 || _loc8_ >= 60 && _loc8_ % 3 == 0 || _loc8_ >= 70 && _loc8_ % 2 == 0 || _loc8_ >= 80;
                    _loc10_.mEnemyTotal = _loc8_ * 25;
                    _loc10_.mSpecialLevel = _loc13_;
                    _loc10_.mTotalActive = Math.max(100,Math.min(_loc7_,_loc10_.mEnemyTotal));
                    _loc3_ = GetRatio("RUNNER",RUNNERRATIO);
                    _loc4_ = GetRatio("VAMPIRE",VAMPIRERATIO);
                    _loc5_ = GetRatio("MUMMY",MUMMYRATIO);
                    _loc6_ = GetRatio("DEVIL",!!_loc13_ ? Number(DEVILRATIO * 10) : Number(DEVILRATIO));
                    _loc2_ = GetRatio("ZOMBIE",1 - (_loc3_ + _loc5_ + _loc4_ + _loc6_));
                    if(_loc3_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc3_,_loc11_,_loc12_,CRunner,GetSpawnPositionEdge));
                    }
                    if(_loc5_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc5_,_loc11_,_loc12_,CMummy,GetSpawnPositionOpen));
                    }
                    if(_loc4_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc4_,_loc11_,_loc12_,CVampire,GetSpawnPositionEdge));
                    }
                    if(_loc6_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc6_,_loc11_,_loc12_,CDevil,GetSpawnPositionEdge));
                    }
                    if(_loc2_)
                    {
                        _loc10_.mEnemys.push(_loc9_ = Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc2_,_loc11_,_loc12_,CZombie,GetSpawnPositionEdge));
                    }
                }
                else if(_loc8_ == 1)
                {
                    _loc10_.mEnemyTotal = 20;
                    _loc10_.mTotalActive = _loc10_.mEnemyTotal;
                    _loc2_ = GetRatio("ZOMBIE",1);
                    if(_loc2_)
                    {
                        _loc10_.mEnemys.push(_loc9_ = Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc2_,_loc11_,_loc12_,CZombie,GetSpawnPositionEdge));
                    }
                }
                else if(_loc8_ == 2)
                {
                    _loc10_.mEnemyTotal = 50;
                    _loc10_.mTotalActive = _loc10_.mEnemyTotal;
                    _loc3_ = GetRatio("RUNNER",RUNNERRATIO);
                    _loc2_ = GetRatio("ZOMBIE",1 - _loc3_);
                    _loc2_ = 1 - _loc3_;
                    if(_loc3_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc3_,_loc11_,_loc12_,CRunner,GetSpawnPositionEdge));
                    }
                    if(_loc2_)
                    {
                        _loc10_.mEnemys.push(_loc9_ = Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc2_,_loc11_,_loc12_,CZombie,GetSpawnPositionEdge));
                    }
                }
                else if(_loc8_ == 3)
                {
                    _loc10_.mEnemyTotal = 75;
                    _loc10_.mTotalActive = _loc10_.mEnemyTotal;
                    _loc3_ = GetRatio("RUNNER",RUNNERRATIO);
                    _loc5_ = GetRatio("MUMMY",MUMMYRATIO);
                    _loc2_ = GetRatio("ZOMBIE",1 - (_loc3_ + _loc5_));
                    if(_loc3_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc3_,_loc11_,_loc12_,CRunner,GetSpawnPositionEdge));
                    }
                    if(_loc5_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc5_,_loc11_,_loc12_,CMummy,GetSpawnPositionOpen));
                    }
                    if(_loc2_)
                    {
                        _loc10_.mEnemys.push(_loc9_ = Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc2_,_loc11_,_loc12_,CZombie,GetSpawnPositionEdge));
                    }
                }
                else if(_loc8_ == 4)
                {
                    _loc10_.mEnemyTotal = 100;
                    _loc10_.mTotalActive = _loc10_.mEnemyTotal;
                    _loc3_ = GetRatio("RUNNER",RUNNERRATIO);
                    _loc4_ = GetRatio("VAMPIRE",VAMPIRERATIO);
                    _loc5_ = GetRatio("MUMMY",MUMMYRATIO);
                    _loc2_ = GetRatio("ZOMBIE",1 - (_loc3_ + _loc5_ + _loc4_));
                    if(_loc3_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc3_,_loc11_,_loc12_,CRunner,GetSpawnPositionEdge));
                    }
                    if(_loc5_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc5_,_loc11_,_loc12_,CMummy,GetSpawnPositionOpen));
                    }
                    if(_loc4_)
                    {
                        _loc10_.mEnemys.push(Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc4_,_loc11_,_loc12_,CVampire,GetSpawnPositionEdge));
                    }
                    if(_loc2_)
                    {
                        _loc10_.mEnemys.push(_loc9_ = Levelup_CreateEnemy(_loc10_.mEnemyTotal,_loc2_,_loc11_,_loc12_,CZombie,GetSpawnPositionEdge));
                    }
                }
                if(_loc9_)
                {
                    _loc1_ = 0;
                    for each(_loc14_ in _loc10_.mEnemys)
                    {
                        _loc1_ += _loc14_.mTotal;
                    }
                    _loc9_.mTotal += _loc10_.mEnemyTotal - _loc1_;
                }
                mLevels[_loc8_] = _loc10_;
                MAXSCORE += _loc10_.mEnemyTotal * 1000 * 999;
                _loc8_++;
            }
        }
        
        private function get mTotalActive() : int
        {
            return mLevelObject.mTotalActive;
        }
        
        public function Start(param1:int = 1, param2:int = 1) : void
        {
            CHUD.mSilentMessages = true;
            switch(CGlobalData.GetData("Difficulty"))
            {
                case 0:
                default:
                    param1 = 0;
                    param2 = CGame.mLevelData.mMode == "DEFENCE" ? 5 : 1;
                    break;
                case 1:
                    param1 = 30;
                    param2 = CGame.mLevelData.mMode == "DEFENCE" ? 10 : 5;
                    break;
                case 2:
                    param1 = 80;
                    param2 = CGame.mLevelData.mMode == "DEFENCE" ? 20 : 10;
                    break;
                case 3:
                    param1 = 150;
                    param2 = CGame.mLevelData.mMode == "DEFENCE" ? 40 : 20;
            }
            mLevelStats.mMultiplier = 0;
            mLevelIndex = 0;
            while(param1)
            {
                ++0;
                param1--;
            }
            param2--;
            while(param2)
            {
                ++mLevelIndex;
                param2--;
            }
            if(mLevelIndex == 0)
            {
                mLevelInitCounter = 1;
            }
            CHUD.mSilentMessages = false;
        }
        
        private function set mSpawnCount(param1:int) : void
        {
            if(mLevelObject.mSpawnCount == param1)
            {
                return;
            }
            mLevelObject.mSpawnCount = param1;
        }
        
        public function Process() : void
        {
            var _loc1_:* = null;
            if(false)
            {
                if(CKeyboard.IsDown("D"))
                {
                    CFPS.AddDebug("LEV_mActiveCount",mActiveCount.toString());
                    CFPS.AddDebug("LEV_mTotalActive",mTotalActive.toString());
                    CFPS.AddDebug("LEV_mSpawnCount",mSpawnCount.toString());
                    CFPS.AddDebug("LEV_mEnemyTotal",mEnemyTotal.toString());
                    CFPS.AddDebug("LEV_mLevelInitCounter",mLevelInitCounter.toString());
                    for each(_loc1_ in ["Zombie","Mummy","Runner","Vampire","Devil"])
                    {
                        CFPS.AddDebug("LEV_" + _loc1_ + "Count",mWorld.mThingContainer.CountChildren("C" + _loc1_,true).toString());
                    }
                }
            }
            if(mLevelIndex)
            {
                SpawnEnemy();
                mLevelStats.Process();
            }
            if(--mLevelInitCounter == 0)
            {
                mUpgradePeep.PlaySound("GONG");
                ++mLevelIndex;
            }
        }
        
        private function set mEnemyTotal(param1:int) : void
        {
            if(mLevelObject.mEnemyTotal == param1)
            {
                return;
            }
            mLevelObject.mEnemyTotal = param1;
        }
        
        private function RandomizePositions(param1:Array) : Array
        {
            var _loc2_:* = null;
            for each(_loc2_ in param1)
            {
                _loc2_.mRandomizer = Random();
            }
            param1.sort(SortOnRandomizer);
            return param1;
        }
        
        private function Random() : Number
        {
            return mWorld.mThingContainer.Random();
        }
        
        private function get mEnemyTotal() : int
        {
            return mLevelObject.mEnemyTotal;
        }
        
        public function CreateSpawnPositions() : *
        {
            var _loc1_:int = 0;
            var _loc2_:int = 0;
            var _loc3_:* = null;
            var _loc4_:* = null;
            mEdgeSpawnPositions = new Array();
            mOpenSpawnPositions = new Array();
            _loc2_ = -1;
            while(_loc2_ >= 0)
            {
                _loc1_ = -1;
                _loc3_ = mWorldMap.mCells[_loc2_];
                while(_loc1_ >= 0)
                {
                    if((_loc4_ = _loc3_[_loc1_]).mCollide == (0 | 0))
                    {
                        AddEdgeSpawnPosition(_loc4_);
                    }
                    else if(_loc4_.mCollide == eWMCCollideType.NONE)
                    {
                        AddOpenSpawnPosition(_loc4_);
                    }
                    _loc1_--;
                }
                _loc2_--;
            }
            RandomizePositions(mEdgeSpawnPositions);
            RandomizePositions(mOpenSpawnPositions);
            mOpenSpawnIndex = 0;
            mEdgeSpawnIndex = 0;
        }
        
        private function SpawnEnemy() : Boolean
        {
            var _loc1_:Boolean = false;
            var _loc2_:* = null;
            var _loc3_:* = null;
            var _loc4_:* = null;
            var _loc5_:* = null;
            if(mLevelInitCounter >= 0)
            {
                return false;
            }
            if(mLevelObject == null)
            {
                return false;
            }
            if(mLevelObject.mEnemys.length == 0)
            {
                return false;
            }
            if(mActiveCount >= mTotalActive)
            {
                return false;
            }
            if(mSpawnCount > mEnemyTotal)
            {
                return false;
            }
            if(mSpawnCount == mEnemyTotal)
            {
                if(mActiveCount <= 0 && mLevelInitCounter < 0)
                {
                    mLevelInitCounter = LEVELINITCOUNT;
                    CGame.mHUD.AddMessage(mUpgradePeep.mRenderPosition,"...LEVEL CLEAR...","level",1.25);
                }
                return false;
            }
            _loc1_ = false;
            _loc2_ = CThingAngle.mDirectionNames;
            for each(_loc3_ in mLevelObject.mEnemys)
            {
                if(_loc3_.mCount < _loc3_.mTotal)
                {
                    _loc3_.mSpawnCount = Math.min(_loc3_.mTotal,_loc3_.mSpawnCount + _loc3_.mRatio);
                    if(_loc3_.mCount < Math.floor(_loc3_.mSpawnCount))
                    {
                        if((_loc4_ = _loc3_.InitPosition()) != null)
                        {
                            (_loc5_ = mWorld.AddThing(new _loc3_.cInitClass({
                                "mInitCell":_loc4_.mCell,
                                "mSpeedScale":_loc3_.mSpeed,
                                "mAttackScale":_loc3_.mAttack
                            }))).OnDeath = EnemyScore;
                            _loc5_.OnDispose = EnemyKilled;
                            _loc5_.mAngle.mDirectionName = _loc4_.mDirection == "ANY" ? _loc2_[RandomInt(_loc2_.length)] : _loc4_.mDirection;
                            ++_loc3_.mCount;
                            ++mSpawnCount;
                            ++mActiveCount;
                            _loc1_ = true;
                            if(mActiveCount >= mTotalActive)
                            {
                                break;
                            }
                        }
                    }
                }
            }
            return !!_loc1_ ? true : false;
        }
        
        private function GetRatio(param1:String, param2:Number = 0) : Number
        {
            switch(param1)
            {
                case "ZOMBIE":
                    if(CGlobalData.GetData("Zombies") == "on")
                    {
                        return param2;
                    }
                    return 0;
                    break;
                case "MUMMY":
                    if(CGlobalData.GetData("Mummies") == "on")
                    {
                        return param2;
                    }
                    return 0;
                    break;
                case "VAMPIRE":
                    if(CGlobalData.GetData("Vampires") == "on")
                    {
                        return param2;
                    }
                    return 0;
                    break;
                case "DEVIL":
                    if(CGlobalData.GetData("Devils") == "on")
                    {
                        return param2;
                    }
                    return 0;
                    break;
                case "RUNNER":
                    if(CGlobalData.GetData("Runners") == "on")
                    {
                        return param2;
                    }
                    return 0;
                    break;
                default:
                    return 0;
            }
        }
        
        private function set mLevelIndex(param1:int) : void
        {
            if(_LevelIndex == param1)
            {
                return;
            }
            if(_LevelIndex == MAXLEVEL)
            {
                mWorld.mState = "CLOSE";
                return;
            }
            _LevelIndex = param1;
            CGame.mHUD.AddMessage(mUpgradePeep.mRenderPosition,"LEVEL " + mLevelIndex,"level",1.25);
            mLevelObject = mLevels[_LevelIndex];
            if(false)
            {
                CGame.mHUD.AddMessage(mUpgradePeep.mRenderPosition,"WELCOME TO HELL","level",1.25);
            }
            CGlobalData.AddStat("Highest Level",_LevelIndex);
        }
        
        private function get mLevelIndex() : int
        {
            return _LevelIndex;
        }
        
        private function get mActiveCount() : int
        {
            return mLevelObject.mActiveCount;
        }
        
        private function SortOnRandomizer(param1:CSpawnPosition, param2:CSpawnPosition) : Number
        {
            return param1.mRandomizer > param2.mRandomizer ? 1 : (param1.mRandomizer < param2.mRandomizer ? -1 : Number(0));
        }
        
        private function set mActiveCount(param1:int) : void
        {
            if(mLevelObject.mActiveCount == param1)
            {
                return;
            }
            mLevelObject.mActiveCount = param1;
        }
    }
}
