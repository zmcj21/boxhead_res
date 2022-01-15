package Screen
{
    import Game.CGlobalData;
    import IO.CMochiBot;
    import IO.CProtection;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    
    public class CScreen_MoreGames extends CScreen
    {
         
        
        public var bBoxheadHalloween:SimpleButton;
        
        public var mcTitleImage:MovieClip;
        
        public var bMoreGames:SimpleButton;
        
        public var bBoxhead2PlayRooms:SimpleButton;
        
        public var bBack:SimpleButton;
        
        public var mcLogo:SimpleButton;
        
        public var bBoxheadTheRooms:SimpleButton;
        
        public var bBoxheadMoreRooms:SimpleButton;
        
        public var bCrazyMonkeyGames:SimpleButton;
        
        public function CScreen_MoreGames()
        {
            super();
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
        
        override public function Deactivate(param1:String = "FADEOUT") : void
        {
            super.Deactivate(param1);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CScreen_MoreGames";
        }
        
        private function me_CMG_CLICK(param1:MouseEvent) : void
        {
            CProtection.NavigateToURL(CGlobalData.mCMGURL);
            CMochiBot.Track(CMochiBot.BXH_ZW_SPONSORCLICK_MOREBOXHEAD);
            CMochiBot.Track(CMochiBot.BXH_ZW_TOTALSPONSORCLICKS);
        }
    }
}
