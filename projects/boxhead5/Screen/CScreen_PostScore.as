package Screen
{
    import CMG_AS3.ScoreSubmitter;
    import CMG_AS3.ServerResponseEvent;
    import Game.CGlobalData;
    import IO.CMochiBot;
    import IO.CProtection;
    import STC9.Security.CSecureNumber;
    import flash.display.MovieClip;
    import flash.display.SimpleButton;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    
    public class CScreen_PostScore extends CScreen
    {
        
        public static const GAMEVERSION:String = "1.0";
        
        public static const PSCANCELLED:String = "PSCANCELLED";
         
        
        public var mcProgress:MovieClip;
        
        private var SScore:CSecureNumber;
        
        public var tfResult:TextField;
        
        private var mPlayerID:String;
        
        private var mCancel:Boolean;
        
        public var bCancel:SimpleButton;
        
        public var bClose:SimpleButton;
        
        public var tfError:TextField;
        
        public var mcLock:MovieClip;
        
        public function CScreen_PostScore()
        {
            super();
            bClose.addEventListener(MouseEvent.MOUSE_UP,me_CLOSE_CLICK);
            bCancel.addEventListener(MouseEvent.MOUSE_UP,me_CANCEL_CLICK);
            tfError.visible = false;
            tfResult.visible = false;
            bClose.visible = false;
            mcProgress.visible = true;
            bCancel.visible = true;
            mcLock.addEventListener(MouseEvent.MOUSE_UP,me_DUMB);
            SetError("Unable to connect the server. Please check your connection and try again!",true);
            SetSuccess("");
        }
        
        public static function GetGameID(param1:int) : Object
        {
            switch(param1)
            {
                case 0:
                    return {
                        "mGameVersion":GAMEVERSION,
                        "mGameID":328,
                        "mGameKey":"boxhdbe3cc81a55b1437578d86c956ab2a2b"
                    };
                case 1:
                    return {
                        "mGameVersion":GAMEVERSION,
                        "mGameID":329,
                        "mGameKey":"boxh9dadeaea58c2cd08380bb072536dfd61"
                    };
                case 2:
                    return {
                        "mGameVersion":GAMEVERSION,
                        "mGameID":330,
                        "mGameKey":"boxhb8389756e76505ebafeb05a519497d4e"
                    };
                case 3:
                    return {
                        "mGameVersion":GAMEVERSION,
                        "mGameID":331,
                        "mGameKey":"boxh7fb139fe5361bfd4d6229ea5ffa638e2"
                    };
                case 4:
                    return {
                        "mGameVersion":GAMEVERSION,
                        "mGameID":332,
                        "mGameKey":"boxh9f0ecf09d12b2daadb57f4e6a10aece2"
                    };
                case 5:
                    return {
                        "mGameVersion":GAMEVERSION,
                        "mGameID":333,
                        "mGameKey":"boxh5ecddbc9ecc33be0dba2c1c47847c2f1"
                    };
                case 6:
                    return {
                        "mGameVersion":GAMEVERSION,
                        "mGameID":334,
                        "mGameKey":"boxh887fb340bf32985eb59316eada6dec64"
                    };
                case 7:
                    return {
                        "mGameVersion":GAMEVERSION,
                        "mGameID":335,
                        "mGameKey":"boxh18423e6ceb4d643b055ade9030f100a5"
                    };
                default:
                    return null;
            }
        }
        
        public static function ViewHiscoreTable(param1:int) : void
        {
            CProtection.NavigateToURL(CGlobalData.mCMGScoreURL + GetGameID(param1).mGameID);
            CMochiBot.Track(CMochiBot.BXH_ZW_HISCOREVIEWS);
            CMochiBot.Track(CMochiBot.BXH_ZW_TOTALSPONSORCLICKS);
        }
        
        private function me_CLOSE_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            if(mCancel)
            {
                dispatchEvent(new Event(PSCANCELLED));
            }
            visible = false;
        }
        
        private function SetSuccess(param1:String) : void
        {
            bCancel.visible = false;
            mcProgress.visible = false;
            tfError.visible = false;
            tfResult.visible = true;
            tfResult.text = param1;
            bClose.visible = true;
            mCancel = false;
        }
        
        private function e_SCORERESPONSE(param1:ServerResponseEvent) : void
        {
            switch(param1.returnCode)
            {
                case ScoreSubmitter.RETURNCODE_WORKING:
                    break;
                case ScoreSubmitter.RETURNCODE_SUCCESS:
                    SetSuccess("Your score has been posted!!! \nThe score table will open shortly.");
                    ViewHiscoreTable(CScreen_SelectLevel.mLevelIndex);
                    break;
                case ScoreSubmitter.RETURNCODE_REJECTED:
                    SetError("The server rejected your score!",false);
                    break;
                case ScoreSubmitter.RETURNCODE_WRONGVERSION:
                    SetError("This is the wrong version of the game. Check for the newest version at CrazyMonkeyGames.com",false);
                    ScoreSubmitter.loadUpdatePage();
                    break;
                case ScoreSubmitter.RETURNCODE_NETWORKERROR:
                    SetError("Your score could not reach the server at this time.",true);
            }
        }
        
        private function me_CANCEL_CLICK(param1:MouseEvent) : void
        {
            PlaySound_ClickShort();
            visible = false;
            dispatchEvent(new Event(PSCANCELLED));
        }
        
        override public function get _CLASSID_() : String
        {
            return "CScreen_PostScore";
        }
        
        public function SendScore(param1:CSecureNumber, param2:String) : void
        {
            var _loc3_:* = null;
            var _loc4_:* = null;
            SScore = param1;
            mPlayerID = param2;
            this.visible = true;
            mcProgress.visible = true;
            tfError.visible = false;
            tfResult.visible = false;
            bClose.visible = false;
            bCancel.visible = true;
            _loc3_ = GetGameID(CScreen_SelectLevel.mLevelIndex);
            ScoreSubmitter.gameId = _loc3_.mGameID;
            ScoreSubmitter.gameVersion = _loc3_.mGameVersion;
            ScoreSubmitter.gameValidationCode = _loc3_.mGameKey;
            (_loc4_ = new ScoreSubmitter()).addEventListener(ScoreSubmitter.SCORE_RESPONSE,e_SCORERESPONSE);
            _loc4_.submitScore(mPlayerID,Number(SScore.mNumber));
        }
        
        private function SetError(param1:String, param2:Boolean) : void
        {
            bCancel.visible = false;
            mcProgress.visible = false;
            tfResult.visible = false;
            tfError.visible = true;
            tfError.text = param1;
            bClose.visible = true;
            mCancel = param2;
        }
    }
}
