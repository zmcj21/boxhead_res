package World
{
    import Game.CGame;
    import Game.CGlobalData;
    import Landscape.CLSDraw;
    import STC9.Security.CSecureNumber;
    import Thing.CPickup_Ammo;
    
    public class CLevelStats
    {
         
        
        private var _Multiplier:int;
        
        private var _MultipleKills:int;
        
        private var mMultiplierTick:int;
        
        private var mMultipleKillsTickTotal:int;
        
        private var mUpgradeMultiplierLevel:int = 0;
        
        private var mLevel:CLevel;
        
        private var _MultipleKillsValid:int;
        
        private var mMultipleKillsValid:int;
        
        private var _Score:CSecureNumber;
        
        private var mMultipleKillsTick:int;
        
        private var mMultiplierTickTotal:int;
        
        private var mMultipleKillsScore:int;
        
        private var mUpgradeMultipleKillsLevel:int = 0;
        
        public function CLevelStats(param1:CLevel)
        {
            mUpgradeMultipleKillsLevel = 0;
            mUpgradeMultiplierLevel = 0;
            super();
            mLevel = param1;
            mMultiplier = 0;
            mMultipleKills = 0;
            mMultipleKillsValid = 0;
            _Score = new CSecureNumber();
        }
        
        public function set mScore(param1:Number) : void
        {
            if(param1 == _Score.mNumber)
            {
                return;
            }
            _Score.mNumber = param1;
            CGame.mHUD.mScore = param1;
        }
        
        public function get mMultiplier() : int
        {
            return _Multiplier;
        }
        
        private function ApplyMultipleKillsUpgrades() : void
        {
            if(mMultipleKills > mUpgradeMultipleKillsLevel)
            {
                mUpgradeMultipleKillsLevel = mMultipleKills;
                if(false)
                {
                    mLevel.mUpgradePeep.ApplyMultipleKillsUpgrade(mMultipleKills);
                }
            }
        }
        
        public function AddScore(param1:Number, param2:Boolean = true) : void
        {
            mScore += param1;
        }
        
        public function get mScore() : Number
        {
            return _Score.mNumber;
        }
        
        public function AddKillScore(param1:*) : void
        {
            var _loc2_:Number = NaN;
            var _loc3_:Boolean = false;
            _loc2_ = param1.mScore * mMultiplier;
            mMultipleKillsScore += _loc2_;
            mScore += _loc2_;
            ++mMultipleKills;
            ++mMultiplier;
            CGlobalData.AddStat("Highest consecutive score",mMultipleKillsScore);
            CGlobalData.AddStat("Highest score",mScore);
            CGame.mHUD.AddScore(CLSDraw.ProjectionThing_Screen(param1.mPosition),_loc2_);
            if(param1.mKilledBy)
            {
                if(param1.mKilledBy._CLASSID_.indexOf("CTurret") == -1)
                {
                    ++mMultipleKillsValid;
                }
            }
            _loc3_ = false;
            if(param1._CLASSID_ == "CDevil")
            {
                _loc3_ = true;
            }
            else if(mMultipleKillsValid < 10)
            {
                if(mMultipleKillsValid == 2 || mMultipleKillsValid == 5)
                {
                    _loc3_ = true;
                }
            }
            else if(mMultipleKillsValid < 40)
            {
                if(mMultipleKillsValid % 10 == 0)
                {
                    _loc3_ = true;
                }
            }
            else if(mMultipleKillsValid % 15 == 0)
            {
                _loc3_ = true;
            }
            if(_loc3_)
            {
                AddPickup(param1);
            }
        }
        
        private function _getTicks(param1:Number) : int
        {
            return Math.pow(100 - Math.min(100,param1),2.5) / Math.pow(100,2.5) * -1 + 1;
        }
        
        private function get mMultiplierTickRatio() : Number
        {
            return mMultiplier == 1 ? 0 : Number(mMultiplierTick / mMultiplierTickTotal);
        }
        
        public function AddPickup(param1:*) : void
        {
            if((param1.mCellCurrent.mCollide & -1) == 0)
            {
                mLevel.mWorld.AddThing(new CPickup_Ammo({"mPosition":param1.mPosition.Clone().AddXY(0,0.05)}));
            }
        }
        
        public function Process() : void
        {
            if(mMultipleKillsTick-- < 0)
            {
                mMultipleKills = 0;
                mMultipleKillsValid = 0;
            }
            if(mMultiplierTick-- < 0)
            {
                --mMultiplier;
            }
            CGame.mHUD.mMultiplierCounter = mMultiplier > 1 ? Number(mMultiplierTick / mMultiplierTickTotal) : Number(0);
        }
        
        public function get _CLASSID_() : String
        {
            return "CLevelStats";
        }
        
        private function ApplyMultiplierUpgrades() : void
        {
            if(mMultiplier > mUpgradeMultiplierLevel)
            {
                mUpgradeMultiplierLevel = mMultiplier;
                if(false)
                {
                    mLevel.mUpgradePeep.ApplyMultiplierUpgrade(mMultiplier);
                }
            }
        }
        
        private function set mMultipleKills(param1:int) : void
        {
            _MultipleKills = param1 < 0 ? 0 : int(param1);
            if(_MultipleKills)
            {
                CGlobalData.AddStat("Highest consecutive kills",_MultipleKills);
                var _loc2_:* = _getTicks(_MultipleKills) / 6;
                mMultipleKillsTick = _getTicks(_MultipleKills) / 6;
                mMultipleKillsTickTotal = _loc2_;
                ApplyMultipleKillsUpgrades();
            }
            else
            {
                mMultipleKillsTickTotal = mMultipleKillsTick = 100000;
                mMultipleKillsScore = 0;
            }
        }
        
        private function get mMultipleKillRatio() : Number
        {
            return mMultipleKills == 0 ? 0 : Number(mMultipleKillsTick / mMultipleKillsTickTotal);
        }
        
        private function get mMultipleKills() : int
        {
            return _MultipleKills;
        }
        
        public function set mMultiplier(param1:int) : void
        {
            _Multiplier = Math.max(1,Math.min(999,param1));
            mMultiplierTickTotal = mMultiplierTick = _getTicks(_Multiplier);
            CGlobalData.AddStat("Highest score multiplier",_Multiplier);
            CGame.mHUD.mMultiplier = _Multiplier;
            if(param1 > 1)
            {
                ApplyMultiplierUpgrades();
            }
        }
        
        public function get SScore() : CSecureNumber
        {
            return _Score;
        }
    }
}
