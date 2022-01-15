package Screen
{
    import Game.CGlobalData;
    import IO.CMochiBot;
    import STC9.Security.CSecureNumber;
    import STC9.String.CString;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    
    public class CScreen_Debrief extends CScreen
    {
        
        public static var mDefUsername:String = "<enter your name>";
        
        public static var SScore:CSecureNumber;
         
        
        public var bViewHiscoreTable:SimpleButton;
        
        public var mcPostScore:Screen_PostScore;
        
        public var mcTitleImage:MovieClip;
        
        public var bMoreGames:SimpleButton;
        
        public var bRetry:SimpleButton;
        
        public var bBack:SimpleButton;
        
        public var tfScore:TextField;
        
        public var mcLogo:SimpleButton;
        
        public var tfUsername:TextField;
        
        public var bSendScore:SimpleButton;
        
        public var mcDisableCover:MovieClip;
        
        public function CScreen_Debrief()
        {
            super();
            bBack.addEventListener(MouseEvent.MOUSE_UP,me_BACK_CLICK);
            bRetry.addEventListener(MouseEvent.MOUSE_UP,me_RETRY_CLICK);
            bSendScore.addEventListener(MouseEvent.MOUSE_UP,me_SENDSCORE_CLICK);
            mcPostScore.addEventListener(CScreen_PostScore.PSCANCELLED,me_POSTSCORE_CANCELLED);
            bViewHiscoreTable.addEventListener(MouseEvent.MOUSE_UP,me_VIEWHISCORES_CLICK);
            mcLogo.addEventListener(MouseEvent.MOUSE_UP,me_LOGO_CLICK);
            mcLogo.useHandCursor = true;
            bMoreGames.addEventListener(MouseEvent.MOUSE_UP,me_MOREGAMES_CLICK);
            mcPostScore.visible = false;
            mcDisableCover.addEventListener(MouseEvent.MOUSE_UP,me_DUMB);
            mcDisableCover.mcConfigChanged.enabled = false;
            mcDisableCover.mcConfigChanged.visible = false;
        }
        
        override public function Activate(param1:String = "FADEIN") : void
        {
            super.Activate(param1);
            tfScore.text = CString.Pad(SScore.toString(),"0",8);
            tfUsername.text = CGlobalData.GetData("username",mDefUsername);
            mcDisableCover.visible = CGlobalData.GetData("SendScore","on") == "on" ? false : true;
            mcDisableCover.mcConfigChanged.visible = mcDisableCover.visible;
            if(true)
            {
                CGlobalData.PostKongregateStats();
            }
        }
        
        private function me_BACK_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            mScreenCollection.Activate("MAIN");
        }
        
        private function me_SENDSCORE_CLICK(param1:MouseEvent) : void
        {
            if(tfUsername.text == mDefUsername)
            {
                return;
            }
            CGlobalData.SetData("username",tfUsername.text);
            PlaySound_ClickShort();
            mcPostScore.mScreenCollection = mScreenCollection;
            mcDisableCover.visible = true;
            mcPostScore.SendScore(SScore,tfUsername.text);
            CMochiBot.Track(CMochiBot.BXH_ZW_SCOREPOSTED);
            CMochiBot.Track(CMochiBot.BXH_ZW_HISCOREVIEWS_POSTSCORE);
        }
        
        private function me_VIEWHISCORES_CLICK(param1:MouseEvent) : void
        {
            CScreen_PostScore.ViewHiscoreTable(CScreen_SelectLevel.mLevelIndex);
            CMochiBot.Track(CMochiBot.BXH_ZW_HISCOREVIEWS_DEBRIEF);
        }
        
        override public function Deactivate(param1:String = "FADEOUT") : void
        {
            super.Deactivate(param1);
            CGlobalData.Flush();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CScreen_Debrief";
        }
        
        private function me_RETRY_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            mScreenCollection.Activate("SELECTLEVEL");
        }
        
        public function me_POSTSCORE_CANCELLED(param1:Event) : void
        {
            mcDisableCover.visible = false;
        }
    }
}
