package Screen
{
    import Game.CGlobalData;
    import IO.CMochiBot;
    import IO.CProtection;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    
    public class CScreen_Main extends CScreen
    {
         
        
        public var bCredits:SimpleButton;
        
        public var bBoxheadHalloween:SimpleButton;
        
        public var mcCredits:Screen_Credits;
        
        public var bMoreGames:SimpleButton;
        
        public var bInstructions:SimpleButton;
        
        public var bBoxhead2PlayRooms:SimpleButton;
        
        public var mcLogo:SimpleButton;
        
        public var bBoxheadTheRooms:SimpleButton;
        
        public var bBoxheadMoreRooms:SimpleButton;
        
        public var bPlay:SimpleButton;
        
        public function CScreen_Main()
        {
            super();
            bCredits.addEventListener(MouseEvent.MOUSE_UP,me_CREDITS_CLICK);
            bPlay.addEventListener(MouseEvent.MOUSE_UP,me_PLAY_CLICK);
            bMoreGames.addEventListener(MouseEvent.MOUSE_UP,lme_MOREGAMES_CLICK);
            bInstructions.addEventListener(MouseEvent.MOUSE_UP,me_INSTRUCTIONS_CLICK);
            mcLogo.addEventListener(MouseEvent.MOUSE_UP,me_LOGO_CLICK);
            mcLogo.useHandCursor = true;
            mcCredits.visible = false;
            mcCredits.bMochibot.addEventListener(MouseEvent.MOUSE_UP,me_MOCHIBOT_CLICK);
            mcCredits.bFGL.addEventListener(MouseEvent.MOUSE_UP,me_FGL_CLICK);
            mcCredits.bMoreGames.addEventListener(MouseEvent.MOUSE_UP,lme_MOREGAMES_CREDITS_CLICK);
            bBoxheadHalloween.addEventListener(MouseEvent.MOUSE_UP,me_BOXHEADHALLOWEEN_CLICK);
            bBoxheadTheRooms.addEventListener(MouseEvent.MOUSE_UP,me_BOXHEADTHEROOMS_CLICK);
            bBoxheadMoreRooms.addEventListener(MouseEvent.MOUSE_UP,me_BOXHEADMOREROOMS_CLICK);
            bBoxhead2PlayRooms.addEventListener(MouseEvent.MOUSE_UP,me_BOXHEAD2PLAYROOMS_CLICK);
        }
        
        private function me_MOCHIBOT_CLICK(param1:MouseEvent) : void
        {
            CProtection.NavigateToURL(CGlobalData.mMochiBotURL);
        }
        
        private function me_CREDITS_CLICK(param1:MouseEvent) : void
        {
            PlaySound_Click();
            mcCredits.visible = true;
        }
        
        override public function Activate(param1:String = "FADEIN") : void
        {
            super.Activate(param1);
        }
        
        private function me_INSTRUCTIONS_CLICK(param1:MouseEvent) : void
        {
            PlaySound_Click();
            CProtection.NavigateToURL(CGlobalData.mInstructionsURL);
            CMochiBot.Track(CMochiBot.BXH_ZW_GAMEGUIDECLICKS);
        }
        
        private function me_BOXHEAD2PLAYROOMS_CLICK(param1:MouseEvent) : void
        {
            CProtection.NavigateToURL(CGlobalData.mCMGBoxhead2PlayRoomsURL);
            CMochiBot.Track(CMochiBot.BXH_ZW_BOXHEAD2PLAYROOMSCLICKS);
            CMochiBot.Track(CMochiBot.BXH_ZW_TOTALSPONSORCLICKS);
        }
        
        public function lme_MOREGAMES_CLICK(param1:MouseEvent) : void
        {
            CGlobalData.OpenURL_SponsorWebsite();
            CMochiBot.Track(CMochiBot.BXH_ZW_SPONSORCLICK_MAIN);
        }
        
        override public function Deactivate(param1:String = "FADEOUT") : void
        {
            super.Deactivate(param1);
        }
        
        public function lme_MOREGAMES_CREDITS_CLICK(param1:MouseEvent) : void
        {
            CGlobalData.OpenURL_SponsorWebsite();
            CMochiBot.Track(CMochiBot.BXH_ZW_SPONSORCLICK_CREDITS);
        }
        
        private function me_PLAY_CLICK(param1:MouseEvent) : void
        {
            PlaySound_Click();
            mScreenCollection.Activate("SELECTLEVEL");
        }
        
        override public function get _CLASSID_() : String
        {
            return "CScreen_Main";
        }
        
        private function me_BOXHEADTHEROOMS_CLICK(param1:MouseEvent) : void
        {
            CProtection.NavigateToURL(CGlobalData.mCMGBoxheadTheRoomsURL);
            CMochiBot.Track(CMochiBot.BXH_ZW_BOXHEADTHEROOMSCLICKS);
            CMochiBot.Track(CMochiBot.BXH_ZW_TOTALSPONSORCLICKS);
        }
        
        private function me_BOXHEADMOREROOMS_CLICK(param1:MouseEvent) : void
        {
            CProtection.NavigateToURL(CGlobalData.mCMGBoxheadMoreRoomsURL);
            CMochiBot.Track(CMochiBot.BXH_ZW_BOXHEADMOREROOMSCLICKS);
            CMochiBot.Track(CMochiBot.BXH_ZW_TOTALSPONSORCLICKS);
        }
        
        private function me_FGL_CLICK(param1:MouseEvent) : void
        {
            CProtection.NavigateToURL(CGlobalData.mFGLURL);
        }
        
        private function me_BOXHEADHALLOWEEN_CLICK(param1:MouseEvent) : void
        {
            CProtection.NavigateToURL(CGlobalData.mCMGBoxheadHalloweenURL);
            CMochiBot.Track(CMochiBot.BXH_ZW_BOXHEADHALLOWEENCLICKS);
            CMochiBot.Track(CMochiBot.BXH_ZW_TOTALSPONSORCLICKS);
        }
    }
}
