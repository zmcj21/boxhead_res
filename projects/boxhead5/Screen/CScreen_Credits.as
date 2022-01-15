package Screen
{
    import Game.CGlobalData;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.MouseEvent;
    import flash.system.Capabilities;
    import flash.text.TextField;
    
    public class CScreen_Credits extends CScreen
    {
         
        
        public var tfVersion:TextField;
        
        public var bFGL:SimpleButton;
        
        public var bMoreGames:SimpleButton;
        
        public var bMochibot:SimpleButton;
        
        public var bClose:SimpleButton;
        
        public var mcLock:MovieClip;
        
        public function CScreen_Credits()
        {
            super();
            bClose.addEventListener(MouseEvent.MOUSE_UP,me_CLOSE_CLICK);
            mcLock.addEventListener(MouseEvent.MOUSE_UP,me_DUMB);
            tfVersion.text = "undefined undefined";
            tfVersion.visible = false;
        }
        
        private function me_CLOSE_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            Deactivate();
            CGlobalData.Flush();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CScreen_Credits";
        }
    }
}
