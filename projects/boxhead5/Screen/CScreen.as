package Screen
{
    import Game.CGlobalData;
    import IO.CMochiBot;
    import flash.display.MovieClip;
    import flash.events.MouseEvent;
    import flash.media.SoundTransform;
    import flash.utils.getTimer;
    
    public class CScreen extends MovieClip
    {
         
        
        private var mAudioContainer:Object;
        
        public var TransitionProcess:Function;
        
        public var mScreenCollection:CScreenCollection;
        
        private var mTransitionStart:int;
        
        public function CScreen()
        {
            super();
            AddSound("Click",Click);
            AddSound("ClickShort",ClickShort);
            stop();
        }
        
        public function AddSound(param1:String, param2:Class, param3:int = 1) : Object
        {
            if(!mAudioContainer)
            {
                mAudioContainer = new Object();
            }
            mAudioContainer[param1] = {
                "mSound":new param2(),
                "mID":param1
            };
            return mAudioContainer[param1];
        }
        
        public function Activate(param1:String = "FADEIN") : void
        {
            visible = true;
            this["Transition_" + param1]();
        }
        
        public function PlaySound(param1:String, param2:Number = 0, param3:int = 0, param4:Number = 1) : void
        {
            if(CGlobalData.GetData("Sound","on") == "on")
            {
                mAudioContainer[param1].mSound.play(param2,param3,new SoundTransform(param4,0));
            }
        }
        
        public function me_DUMB(param1:MouseEvent) : void
        {
        }
        
        public function me_MOREGAMES_CLICK(param1:MouseEvent) : void
        {
            CGlobalData.OpenURL_SponsorWebsite();
            CMochiBot.Track(CMochiBot.BXH_ZW_SPONSORCLICK_MOREGAMES);
        }
        
        public function PlaySound_Click() : void
        {
            PlaySound("Click");
        }
        
        public function TRANSITIONCOMPLETE() : void
        {
            mScreenCollection.ClearBackground();
        }
        
        public function PlaySound_ClickShort() : void
        {
            PlaySound("ClickShort",0,0,0.2);
        }
        
        public function Deactivate(param1:String = "FADEOUT") : void
        {
            visible = false;
        }
        
        public function get _CLASSID_() : String
        {
            return "CScreen";
        }
        
        private function Transition_FADEIN_Process() : Boolean
        {
            var _loc1_:Number = NaN;
            var _loc2_:* = false;
            _loc1_ = Math.min(1,(getTimer() - mTransitionStart) / 500);
            alpha = _loc1_;
            _loc2_ = _loc1_ >= 1;
            if(_loc2_)
            {
                cacheAsBitmap = false;
                TransitionProcess = null;
                TRANSITIONCOMPLETE();
            }
            return _loc2_;
        }
        
        private function Transition_FADEIN() : void
        {
            TransitionProcess = Transition_FADEIN_Process;
            mTransitionStart = getTimer();
            cacheAsBitmap = true;
            alpha = 0;
        }
        
        public function me_LOGO_CLICK(param1:MouseEvent) : void
        {
            CGlobalData.OpenURL_BoxheadWebsite();
        }
    }
}
