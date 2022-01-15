package Boxhead_TheZombieWars_fla
{
    import Game.CGlobalData;
    import IO.CMochiBot;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    public dynamic class Monkey_169 extends MovieClip
    {
         
        
        public var bTButton:SimpleButton;
        
        public var nTimer:Timer;
        
        public var mFinished:Boolean;
        
        public function Monkey_169()
        {
            super();
        }
        
        public function e_ANIMATE(param1:TimerEvent) : void
        {
            this.nextFrame();
            if(this.currentFrame == this.totalFrames)
            {
                nTimer.removeEventListener("timer",e_ANIMATE);
                dispatchEvent(new Event("FINISHED"));
            }
        }
        
        public function e_GOTOURL(param1:MouseEvent) : void
        {
            CGlobalData.OpenURL_SponsorWebsite();
            CMochiBot.Track(CMochiBot.BXH_ZW_SPONSORCLICK_INTRO);
        }
        
        function frame1() : *
        {
            stop();
            mFinished = false;
            bTButton.addEventListener(MouseEvent.MOUSE_UP,e_GOTOURL);
            nTimer = new Timer(41.666666666666664);
            nTimer.addEventListener("timer",e_ANIMATE);
        }
        
        public function START() : *
        {
            visible = true;
            nTimer.start();
        }
        
        function frame116() : *
        {
            stop();
        }
    }
}
