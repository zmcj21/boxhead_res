package Thing
{
    import Game.CGame;
    import STC9.System.Profiler.CFPS;
    import flash.events.Event;
    import flash.geom.Point;
    import flash.media.SoundTransform;
    
    public class CThingAudio extends CThingState
    {
        
        public static var mActiveChannels:int = 0;
        
        public static var mSoundActive:Boolean = false;
        
        public static var mAudioSize:Point = new Point();
        
        public static const mChannels:int = 8;
        
        public static var mAudioCentre:CThingV3 = new CThingV3();
        
        public static var mPlaySounds:Object = new Array();
        
        public static var mLoadedSounds:Object = new Object();
        
        public static var mActiveSounds:Object = new Object();
         
        
        public var mAudioMaterial:String;
        
        public function CThingAudio()
        {
            super();
        }
        
        private static function e_SOUNDCOMPLETE(param1:Event) : void
        {
            var _loc2_:* = null;
            for each(_loc2_ in mActiveSounds)
            {
                if(_loc2_.mChannel == param1.currentTarget)
                {
                    GKillSound(_loc2_.id);
                }
            }
        }
        
        public static function StopAllSounds() : void
        {
            var _loc1_:* = null;
            for each(_loc1_ in mActiveSounds)
            {
                GStopSound(_loc1_.mID);
            }
        }
        
        public static function GAddSound(param1:String, param2:Class, param3:int = 1, param4:int = 1) : void
        {
            if(true)
            {
                mLoadedSounds[param1] = {
                    "mID":param1,
                    "mSound":new param2(),
                    "mPriority":param3,
                    "mChannelAmount":param4
                };
            }
        }
        
        public static function PauseAllSounds() : void
        {
            var _loc1_:* = null;
            for each(_loc1_ in mActiveSounds)
            {
                _loc1_.mPaused = {
                    "mPosition":_loc1_.mChannel.position,
                    "mTransform":_loc1_.mChannel.soundTransform
                };
                _loc1_.mChannel.stop();
                _loc1_.mChannel = null;
            }
        }
        
        private static function GKillSound(param1:String) : void
        {
            delete mActiveSounds[param1];
            --mActiveChannels;
        }
        
        public static function UpdateAllSounds() : void
        {
            var _loc1_:* = null;
            var _loc2_:* = null;
            var _loc3_:int = 0;
            var _loc4_:int = 0;
            var _loc5_:* = null;
            var _loc6_:* = null;
            var _loc7_:Number = NaN;
            var _loc8_:* = null;
            CGame.mFPS.StartProfile("AUDIO");
            for each(_loc1_ in mPlaySounds)
            {
                switch(_loc1_.type)
                {
                    case "stop":
                        GStopSound(_loc1_.id);
                        break;
                    case "update":
                        GUpdateSound(_loc1_.id,_loc1_.levels);
                        break;
                }
            }
            _loc2_ = new Object();
            for each(_loc1_ in mPlaySounds)
            {
                switch(_loc1_.type)
                {
                    case "play":
                        if(_loc1_.levels.vol >= 0.000001)
                        {
                            if(_loc2_[_loc1_.id])
                            {
                                _loc8_ = {
                                    "vol":_loc2_[_loc1_.id].levels.vol,
                                    "pan":_loc2_[_loc1_.id].levels.pan
                                };
                                _loc8_.pan = (_loc8_.pan * _loc8_.vol + _loc1_.levels.pan * _loc1_.levels.vol) / 2;
                                _loc8_.vol = Math.min(1,_loc1_.levels.vol + _loc8_.vol);
                                _loc2_[_loc1_.id].levels = _loc8_;
                            }
                            else
                            {
                                _loc2_[_loc1_.id] = _loc1_;
                            }
                        }
                        break;
                }
            }
            _loc3_ = 0;
            for each(_loc1_ in _loc2_)
            {
                GPlaySound(_loc1_.id,_loc1_.startTime,_loc1_.loops,_loc1_.levels);
                _loc3_++;
            }
            mPlaySounds = new Array();
            _loc4_ = 0;
            _loc5_ = "";
            for(_loc6_ in mActiveSounds)
            {
                _loc4_++;
                _loc5_ += _loc6_ + ",";
            }
            if((_loc7_ = CGame.mFPS.StopProfile("AUDIO")) >= 20)
            {
            }
            CFPS.AddDebug("AUDIO#",String(_loc3_));
            CFPS.AddDebug("AUDIOA#",String(_loc4_));
        }
        
        public static function GStopSound(param1:String) : void
        {
            if(false)
            {
                if(mActiveSounds[param1].mChannel)
                {
                    mActiveSounds[param1].mChannel.removeEventListener(Event.SOUND_COMPLETE,e_SOUNDCOMPLETE);
                    mActiveSounds[param1].mChannel.stop();
                }
                GKillSound(param1);
            }
        }
        
        public static function UnpauseAllSounds() : void
        {
            var _loc1_:* = null;
            for each(_loc1_ in mActiveSounds)
            {
                _loc1_.mChannel = _loc1_.oSound.mSound.play(_loc1_.mPaused.mPosition,_loc1_.mLoops,_loc1_.mPaused.mTransform);
            }
        }
        
        public static function GPlaySound(param1:String, param2:Number = 0, param3:int = 0, param4:Object = null) : void
        {
            if(!mSoundActive)
            {
                return;
            }
            if(!param1)
            {
                return;
            }
            if(false)
            {
                GStopSound(param1);
            }
            ++mActiveChannels;
            mActiveSounds[param1] = {
                "id":param1,
                "oSound":mLoadedSounds[param1],
                "mLoops":param3
            };
            mActiveSounds[param1].mChannel = mLoadedSounds[param1].mSound.play(param2,param3,new SoundTransform(param4.vol,param4.pan));
            if(mActiveSounds[param1].mChannel)
            {
                mActiveSounds[param1].mChannel.addEventListener(Event.SOUND_COMPLETE,e_SOUNDCOMPLETE);
            }
        }
        
        public static function GUpdateSound(param1:String, param2:Object) : void
        {
            var _loc3_:* = null;
            if(!mSoundActive)
            {
                return;
            }
            if(true)
            {
                return;
            }
            _loc3_ = mActiveSounds[param1].mChannel.soundTransform;
            _loc3_.pan = param2.pan;
            _loc3_.volume = param2.vol;
            mActiveSounds[param1].mChannel.soundTransform = _loc3_;
        }
        
        public function StopSound(param1:String) : void
        {
            mPlaySounds.push({
                "type":"stop",
                "id":GetSoundID(param1)
            });
        }
        
        public function AddSound(param1:String, param2:Class, param3:int = 1, param4:int = 1) : void
        {
            GAddSound(GetSoundID(param1),param2,param3,param4);
        }
        
        public function PlaySound(param1:String, param2:Number = 0, param3:int = 0) : void
        {
            mPlaySounds.push({
                "type":"play",
                "id":GetSoundID(param1),
                "loops":param3,
                "levels":getPanVol(),
                "startTime":param2
            });
        }
        
        private function GetSoundID(param1:String) : *
        {
            return _CLASSID_ + "_" + param1;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingAudio";
        }
        
        public function UpdateSound(param1:String) : void
        {
            mPlaySounds.push({
                "type":"update",
                "id":GetSoundID(param1),
                "levels":getPanVol()
            });
        }
        
        private function getPanVol() : Object
        {
            var _loc1_:Number = NaN;
            var _loc2_:Number = NaN;
            var _loc3_:Number = NaN;
            _loc3_ = mAudioCentre.Distance2D(mPosition);
            _loc1_ = _loc3_ > 4 ? Number(1 - Math.min(1,(_loc3_ - 4) / 0)) : Number(1);
            _loc2_ = (0 - 0) / 0;
            return {
                "vol":_loc1_,
                "pan":_loc2_
            };
        }
    }
}
