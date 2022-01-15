package Screen
{
    import Game.CGlobalData;
    import IO.CMochiBot;
    import IO.CProtection;
    import World.CLevelData;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.geom.ColorTransform;
    
    public class CScreen_SelectLevel extends CScreen
    {
        
        public static var mDifficulty:int = 0;
        
        public static var mLevelIndex:int = 0;
         
        
        public var bLIcon_04:LIcon;
        
        public var bLIcon_05:LIcon;
        
        public var bLIcon_07:LIcon;
        
        public var bLIcon_08:LIcon;
        
        public var bLIcon_06:LIcon;
        
        public var mcTitleImage:MovieClip;
        
        public var bMoreGames:SimpleButton;
        
        public var mcLevelSelected:MovieClip;
        
        private var bDifficultys:Array;
        
        public var mcLogo:SimpleButton;
        
        public var bBack:SimpleButton;
        
        public var bConfig:SimpleButton;
        
        public var bIntermediate:SimpleButton;
        
        public var mcConfig:Screen_Config;
        
        private var bLevels:Array;
        
        public var bNightmare:SimpleButton;
        
        public var bBeginner:SimpleButton;
        
        public var bViewHiscores_1:SimpleButton;
        
        public var bViewHiscores_2:SimpleButton;
        
        public var bViewHiscores_4:SimpleButton;
        
        public var bViewHiscores_5:SimpleButton;
        
        public var bViewHiscores_6:SimpleButton;
        
        public var bViewHiscores_8:SimpleButton;
        
        public var bViewHiscores_3:SimpleButton;
        
        public var bExpert:SimpleButton;
        
        public var mcLIcon_01:MovieClip;
        
        public var mcLIcon_02:MovieClip;
        
        public var mcLIcon_03:MovieClip;
        
        public var mcLIcon_05:MovieClip;
        
        public var mcLIcon_06:MovieClip;
        
        public var mcLIcon_08:MovieClip;
        
        public var bViewHiscores_7:SimpleButton;
        
        public var mcLIcon_04:MovieClip;
        
        public var mcLIcon_07:MovieClip;
        
        public var mcLevelExclusive1:SimpleButton;
        
        public var mcLevelExclusive2:SimpleButton;
        
        public var bEnterHell:SimpleButton;
        
        public var bLIcon_01:LIcon;
        
        public var bLIcon_02:LIcon;
        
        public var bLIcon_03:LIcon;
        
        public function CScreen_SelectLevel()
        {
            super();
            bDifficultys = [bBeginner,bIntermediate,bExpert,bNightmare];
            bBack.addEventListener(MouseEvent.MOUSE_UP,me_BACK_CLICK);
            bConfig.addEventListener(MouseEvent.MOUSE_UP,me_CONFIG_CLICK);
            bExpert.addEventListener(MouseEvent.MOUSE_UP,me_EXPERT_CLICK);
            bIntermediate.addEventListener(MouseEvent.MOUSE_UP,me_INTERMEDIATE_CLICK);
            bNightmare.addEventListener(MouseEvent.MOUSE_UP,me_NIGHTMARE_CLICK);
            bBeginner.addEventListener(MouseEvent.MOUSE_UP,me_BEGINNER_CLICK);
            bEnterHell.addEventListener(MouseEvent.MOUSE_UP,me_ENTERHELL_CLICK);
            if(CProtection.isCMG() || false)
            {
                mcLevelExclusive2.visible = false;
                mcLevelExclusive1.visible = false;
            }
            mcLevelExclusive1.addEventListener(MouseEvent.MOUSE_UP,me_EXCLUSIVELEVEL_CLICK);
            mcLevelExclusive2.addEventListener(MouseEvent.MOUSE_UP,me_EXCLUSIVELEVEL_CLICK);
            mcLogo.addEventListener(MouseEvent.MOUSE_UP,me_LOGO_CLICK);
            mcLogo.useHandCursor = true;
            bMoreGames.addEventListener(MouseEvent.MOUSE_UP,me_MOREGAMES_CLICK);
            SelectDifficulty(CGlobalData.GetData("Difficulty",mDifficulty),true);
            SelectLevelIndex(CGlobalData.GetData("LevelIndex",mLevelIndex),true);
            bViewHiscores_1.addEventListener(MouseEvent.MOUSE_UP,me_VIEWHISCORES1_CLICK);
            bViewHiscores_2.addEventListener(MouseEvent.MOUSE_UP,me_VIEWHISCORES2_CLICK);
            bViewHiscores_3.addEventListener(MouseEvent.MOUSE_UP,me_VIEWHISCORES3_CLICK);
            bViewHiscores_4.addEventListener(MouseEvent.MOUSE_UP,me_VIEWHISCORES4_CLICK);
            bViewHiscores_5.addEventListener(MouseEvent.MOUSE_UP,me_VIEWHISCORES5_CLICK);
            bViewHiscores_6.addEventListener(MouseEvent.MOUSE_UP,me_VIEWHISCORES6_CLICK);
            bViewHiscores_7.addEventListener(MouseEvent.MOUSE_UP,me_VIEWHISCORES7_CLICK);
            bViewHiscores_8.addEventListener(MouseEvent.MOUSE_UP,me_VIEWHISCORES8_CLICK);
            mcConfig.visible = false;
        }
        
        private function me_VIEWHISCORES2_CLICK(param1:MouseEvent) : void
        {
            me_VIEWHISCORES(param1,1);
        }
        
        private function SelectDifficulty(param1:int, param2:Boolean = false) : void
        {
            var _loc3_:* = undefined;
            if(mDifficulty == param1 && param2 == false)
            {
                return;
            }
            mDifficulty = param1;
            CGlobalData.SetData("Difficulty",mDifficulty);
            for each(_loc3_ in bDifficultys)
            {
                _loc3_.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
            }
            bDifficultys[param1].transform.colorTransform = new ColorTransform(1,0,0,1,255,0,0,0);
        }
        
        private function e_LICON_OVER(param1:MouseEvent) : void
        {
            if(param1.currentTarget.mSelected)
            {
                return;
            }
            param1.currentTarget.partner.mcName.visible = true;
        }
        
        private function me_VIEWHISCORES7_CLICK(param1:MouseEvent) : void
        {
            me_VIEWHISCORES(param1,6);
        }
        
        private function me_EXPERT_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            SelectDifficulty(2);
        }
        
        override public function Deactivate(param1:String = "FADEOUT") : void
        {
            super.Deactivate(param1);
            CGlobalData.Flush();
        }
        
        private function me_VIEWHISCORES4_CLICK(param1:MouseEvent) : void
        {
            me_VIEWHISCORES(param1,3);
        }
        
        private function me_INTERMEDIATE_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            SelectDifficulty(1);
        }
        
        private function me_BEGINNER_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            SelectDifficulty(0);
        }
        
        private function me_VIEWHISCORES1_CLICK(param1:MouseEvent) : void
        {
            me_VIEWHISCORES(param1,0);
        }
        
        private function e_LICON_UP(param1:MouseEvent) : void
        {
            SelectLevelIndex(param1.currentTarget.mIndex);
            PlaySound_ClickShort();
        }
        
        override public function Activate(param1:String = "FADEIN") : void
        {
            super.Activate(param1);
        }
        
        private function me_BACK_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            mScreenCollection.Activate("MAIN");
        }
        
        private function SetChildrenField(param1:*, param2:String, param3:*) : void
        {
            var _loc4_:int = 0;
            _loc4_ = param1.numChildren - 1;
            while(_loc4_ >= 0)
            {
                param1.getChildAt(_loc4_)[param2] = param3;
                _loc4_--;
            }
        }
        
        private function me_VIEWHISCORES6_CLICK(param1:MouseEvent) : void
        {
            me_VIEWHISCORES(param1,5);
        }
        
        private function me_NIGHTMARE_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            SelectDifficulty(3);
        }
        
        private function me_VIEWHISCORES(param1:MouseEvent, param2:int) : void
        {
            CScreen_PostScore.ViewHiscoreTable(param2);
            CMochiBot.Track(CMochiBot.BXH_ZW_HISCOREVIEWS_LEVELSELECTION);
        }
        
        private function me_VIEWHISCORES3_CLICK(param1:MouseEvent) : void
        {
            me_VIEWHISCORES(param1,2);
        }
        
        private function e_LICON_OUT(param1:MouseEvent) : void
        {
            if(param1.currentTarget.mSelected)
            {
                return;
            }
            param1.currentTarget.partner.mcName.visible = false;
        }
        
        private function me_CONFIG_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            mcConfig.mScreenCollection = mScreenCollection;
            mcConfig.Activate();
        }
        
        private function me_VIEWHISCORES8_CLICK(param1:MouseEvent) : void
        {
            me_VIEWHISCORES(param1,7);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CScreen_SelectLevel";
        }
        
        private function me_VIEWHISCORES5_CLICK(param1:MouseEvent) : void
        {
            me_VIEWHISCORES(param1,4);
        }
        
        private function me_EXCLUSIVELEVEL_CLICK(param1:MouseEvent) : void
        {
            CGlobalData.OpenSponsorURL(CGlobalData.mCMGBoxheadTheZombieWarsURL);
            CMochiBot.Track(CMochiBot.BXH_ZW_SPONSORCLICK_EXCLUSIVELEVEL);
        }
        
        private function SelectLevelIndex(param1:int, param2:Boolean = false) : void
        {
            var _loc3_:* = null;
            var _loc4_:int = 0;
            var _loc5_:* = undefined;
            if(bLevels == null)
            {
                _loc3_ = [mcLIcon_01,mcLIcon_02,mcLIcon_03,mcLIcon_04,mcLIcon_05,mcLIcon_06,mcLIcon_07,mcLIcon_08];
                bLevels = [bLIcon_01,bLIcon_02,bLIcon_03,bLIcon_04,bLIcon_05,bLIcon_06,bLIcon_07,bLIcon_08];
                _loc4_ = 0;
                while(_loc4_ < bLevels.length)
                {
                    (_loc5_ = bLevels[_loc4_]).partner = _loc3_[_loc4_];
                    _loc5_.mIndex = _loc4_;
                    _loc5_.mSelected = false;
                    _loc5_.mNameStartY = _loc5_.partner.mcName.y;
                    _loc5_.partner.mcName.visible = false;
                    _loc5_.partner.mcName.tfName.text = CLevelData.GetData(_loc5_.mIndex).mName;
                    _loc5_.addEventListener(MouseEvent.MOUSE_UP,e_LICON_UP);
                    _loc5_.addEventListener(MouseEvent.MOUSE_OVER,e_LICON_OVER);
                    _loc5_.addEventListener(MouseEvent.MOUSE_OUT,e_LICON_OUT);
                    _loc4_++;
                }
            }
            if(mLevelIndex == param1 && param2 == false)
            {
                return;
            }
            bLevels[mLevelIndex].mSelected = false;
            bLevels[mLevelIndex].partner.mcName.visible = false;
            mLevelIndex = param1;
            CGlobalData.SetData("LevelIndex",mLevelIndex);
            mcLevelSelected.x = bLevels[mLevelIndex].x;
            mcLevelSelected.y = bLevels[mLevelIndex].y;
            bLevels[mLevelIndex].mSelected = true;
            bLevels[mLevelIndex].partner.mcName.visible = true;
        }
        
        private function me_ENTERHELL_CLICK(param1:MouseEvent) : void
        {
            PlaySound_Click();
            CGlobalData.StartLocalStats(mLevelIndex,mDifficulty,CGlobalData.GetData("SendScore","on") == "on");
            mScreenCollection.Activate("LOADLEVEL");
        }
    }
}
