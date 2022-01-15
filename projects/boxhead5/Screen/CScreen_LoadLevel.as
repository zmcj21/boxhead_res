package Screen
{
    import Game.CGame;
    import flash.display.MovieClip;
    import flash.events.Event;
    
    public class CScreen_LoadLevel extends CScreen
    {
         
        
        public var mcTitleImage:MovieClip;
        
        private var mGame:CGame;
        
        public function CScreen_LoadLevel()
        {
            super();
        }
        
        private function e_GAME_DISPOSED(param1:Event) : void
        {
            mGame.removeEventListener(CGame.DISPOSED,e_GAME_DISPOSED);
            mScreenCollection.Unpause();
            mScreenCollection.parent.removeChild(mGame);
            mGame = null;
            mScreenCollection.Activate("DEBRIEF");
        }
        
        override public function TRANSITIONCOMPLETE() : void
        {
            super.TRANSITIONCOMPLETE();
            addEventListener(Event.ENTER_FRAME,e_GAME_LOAD);
        }
        
        private function e_GAME_LOAD(param1:Event) : void
        {
            removeEventListener(Event.ENTER_FRAME,e_GAME_LOAD);
            mGame = new CGame();
            mScreenCollection.parent.addChild(mGame);
            mGame.Activate(CScreen_SelectLevel.mLevelIndex);
            mGame.addEventListener(CGame.DISPOSED,e_GAME_DISPOSED);
            mGame.addEventListener(CGame.START,e_GAME_START);
        }
        
        override public function get _CLASSID_() : String
        {
            return "CScreen_LoadLevel";
        }
        
        private function e_GAME_START(param1:Event) : void
        {
            mGame.removeEventListener(CGame.START,e_GAME_START);
            mScreenCollection.Pause();
            mScreenCollection.SetIDefaults(mGame);
        }
    }
}
