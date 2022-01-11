class CSaveData
{
    var Dispose = 0;
    var _CLASSID_ = "CSaveData";
    static var mDefaultQuality = "HIGH";
    var _MusicActive = true;
    var _SoundActive = true;
    var _Detail = true;
    var mQualityActive = false;
    var _Difficulty = 0;
    var _GameSpeed = 1;
    var _DevilsActive = 1;
    var _CollisionsActive = 1;
    var _DamageActive = 1;
    var _GameAmount = 1;
    var _LevelIndex_Single = 8;
    var _LevelIndex_Coop = 0;
    var _LevelIndex_DeathMatch = 0;
    var _Player1_CharacterIndex = 3;
    var _Player2_CharacterIndex = 0;
    var _ViewSide_DeathMatch = 1;
    var _PlayCount = 0;
    function CSaveData()
    {
        CSaveData.obj = this;
        CSaveData._this = this;
        this._Player1_KeyMoveUp = 38;
        this._Player1_KeyMoveDown = 40;
        this._Player1_KeyMoveLeft = 37;
        this._Player1_KeyMoveRight = 39;
        this._Player1_KeyShoot = 191;
        this._Player1_KeyNextWeapon = 190;
        this._Player1_KeyPrevWeapon = 188;
        this._Player2_KeyMoveUp = CInput.ToAscii("W");
        this._Player2_KeyMoveDown = CInput.ToAscii("S");
        this._Player2_KeyMoveLeft = CInput.ToAscii("A");
        this._Player2_KeyMoveRight = CInput.ToAscii("D");
        this._Player2_KeyShoot = CInput.ToAscii(" ");
        this._Player2_KeyNextWeapon = CInput.ToAscii("E");
        this._Player2_KeyPrevWeapon = CInput.ToAscii("Q");
    }
    function set mUsername(a)
    {
        CSaveData.mSharedObject.data.mUsername = this._Username = a;
        this.SaveData();
    }
    function get mUsername()
    {
        return CSaveData.mSharedObject.data.mUsername != undefined ? CSaveData.mSharedObject.data.mUsername : this._Username;
    }
    function set mMusicActive(a)
    {
        CSaveData.mSharedObject.data.mMusicActive = this._MusicActive = a;
        this.SaveData();
        CSound.MusicActive(this._MusicActive);
    }
    function get mMusicActive()
    {
        return CSaveData.mSharedObject.data.mMusicActive != undefined ? CSaveData.mSharedObject.data.mMusicActive : this._MusicActive;
    }
    function set mSoundActive(a)
    {
        CSaveData.mSharedObject.data.mSoundActive = this._SoundActive = a;
        this.SaveData();
        CSound.SoundActive(this._SoundActive);
    }
    function get mSoundActive()
    {
        return CSaveData.mSharedObject.data.mSoundActive != undefined ? CSaveData.mSharedObject.data.mSoundActive : this._SoundActive;
    }
    function set mDetail(a)
    {
        CSaveData.mSharedObject.data.mDetail = this._Detail = a;
        this.SaveData();
        _root._quality = !(this._Detail || !this.mQualityActive) ? "LOW" : CSaveData.mDefaultQuality;
    }
    function get mDetail()
    {
        return CSaveData.mSharedObject.data.mDetail != undefined ? CSaveData.mSharedObject.data.mDetail : this._Detail;
    }
    static function UpdateDetail()
    {
        CSaveData._this.__set__mDetail(CSaveData._this._Detail);
    }
    static function QualityActive(a)
    {
        CSaveData._this.mQualityActive = a;
        CSaveData._this.__set__mDetail(CSaveData._this._Detail);
    }
    function set mDifficulty(a)
    {
        CSaveData.mSharedObject.data.mDifficulty = this._Difficulty = a;
        this.SaveData();
    }
    function get mDifficulty()
    {
        return CSaveData.mSharedObject.data.mDifficulty != undefined ? CSaveData.mSharedObject.data.mDifficulty : this._Difficulty;
    }
    function set mGameSpeed(a)
    {
        CSaveData.mSharedObject.data.mGameSpeed = this._GameSpeed = a;
        this.SaveData();
    }
    function get mGameSpeed()
    {
        return CSaveData.mSharedObject.data.mGameSpeed != undefined ? CSaveData.mSharedObject.data.mGameSpeed : this._GameSpeed;
    }
    function set mDevilsActive(a)
    {
        CSaveData.mSharedObject.data.mDevilsActive = this._DevilsActive = a;
        this.SaveData();
    }
    function get mDevilsActive()
    {
        return CSaveData.mSharedObject.data.mDevilsActive != undefined ? CSaveData.mSharedObject.data.mDevilsActive : this._DevilsActive;
    }
    function set mCollisionsActive(a)
    {
        CSaveData.mSharedObject.data.mCollisionsActive = this._CollisionsActive = a;
        this.SaveData();
    }
    function get mCollisionsActive()
    {
        return CSaveData.mSharedObject.data.mCollisionsActive != undefined ? CSaveData.mSharedObject.data.mCollisionsActive : this._CollisionsActive;
    }
    function set mDamageActive(a)
    {
        CSaveData.mSharedObject.data.mDamageActive = this._DamageActive = a;
        this.SaveData();
    }
    function get mDamageActive()
    {
        return CSaveData.mSharedObject.data.mDamageActive != undefined ? CSaveData.mSharedObject.data.mDamageActive : this._DamageActive;
    }
    function set mGameAmount(a)
    {
        CSaveData.mSharedObject.data.mGameAmount = this._GameAmount = a;
        this.SaveData();
    }
    function get mGameAmount()
    {
        return CSaveData.mSharedObject.data.mGameAmount != undefined ? CSaveData.mSharedObject.data.mGameAmount : this._GameAmount;
    }
    function set mLevelIndex_Single(a)
    {
        CSaveData.mSharedObject.data.mLevelIndex_Single = this._LevelIndex_Single = a;
        this.SaveData();
    }
    function get mLevelIndex_Single()
    {
        return CSaveData.mSharedObject.data.mLevelIndex_Single != undefined ? CSaveData.mSharedObject.data.mLevelIndex_Single : this._LevelIndex_Single;
    }
    function set mLevelIndex_Coop(a)
    {
        CSaveData.mSharedObject.data.mLevelIndex_Coop = this._LevelIndex_Coop = a;
        this.SaveData();
    }
    function get mLevelIndex_Coop()
    {
        return CSaveData.mSharedObject.data.mLevelIndex_Coop != undefined ? CSaveData.mSharedObject.data.mLevelIndex_Coop : this._LevelIndex_Coop;
    }
    function set mLevelIndex_DeathMatch(a)
    {
        CSaveData.mSharedObject.data.mLevelIndex_DeathMatch = this._LevelIndex_DeathMatch = a;
        this.SaveData();
    }
    function get mLevelIndex_DeathMatch()
    {
        return CSaveData.mSharedObject.data.mLevelIndex_DeathMatch != undefined ? CSaveData.mSharedObject.data.mLevelIndex_DeathMatch : this._LevelIndex_DeathMatch;
    }
    function set mPlayer1_CharacterIndex(a)
    {
        CSaveData.mSharedObject.data.mPlayer1_CharacterIndex = this._Player1_CharacterIndex = a;
        this.SaveData();
    }
    function get mPlayer1_CharacterIndex()
    {
        return CSaveData.mSharedObject.data.mPlayer1_CharacterIndex != undefined ? CSaveData.mSharedObject.data.mPlayer1_CharacterIndex : this._Player1_CharacterIndex;
    }
    function set mPlayer2_CharacterIndex(a)
    {
        CSaveData.mSharedObject.data.mPlayer2_CharacterIndex = this._Player2_CharacterIndex = a;
        this.SaveData();
    }
    function get mPlayer2_CharacterIndex()
    {
        return CSaveData.mSharedObject.data.mPlayer2_CharacterIndex != undefined ? CSaveData.mSharedObject.data.mPlayer2_CharacterIndex : this._Player2_CharacterIndex;
    }
    function set mViewSide_DeathMatch(a)
    {
        CSaveData.mSharedObject.data.mViewSide_DeathMatch = this._ViewSide_DeathMatch = a;
        this.SaveData();
    }
    function get mViewSide_DeathMatch()
    {
        return CSaveData.mSharedObject.data.mViewSide_DeathMatch != undefined ? CSaveData.mSharedObject.data.mViewSide_DeathMatch : this._ViewSide_DeathMatch;
    }
    function set mPlayer1_KeyMoveUp(a)
    {
        CSaveData.mSharedObject.data.mPlayer1_KeyMoveUp = this._Player1_KeyMoveUp = a;
        this.SaveData();
    }
    function get mPlayer1_KeyMoveUp()
    {
        return CSaveData.mSharedObject.data.mPlayer1_KeyMoveUp != undefined ? CSaveData.mSharedObject.data.mPlayer1_KeyMoveUp : this._Player1_KeyMoveUp;
    }
    function set mPlayer1_KeyMoveDown(a)
    {
        CSaveData.mSharedObject.data.mPlayer1_KeyMoveDown = this._Player1_KeyMoveDown = a;
        this.SaveData();
    }
    function get mPlayer1_KeyMoveDown()
    {
        return CSaveData.mSharedObject.data.mPlayer1_KeyMoveDown != undefined ? CSaveData.mSharedObject.data.mPlayer1_KeyMoveDown : this._Player1_KeyMoveDown;
    }
    function set mPlayer1_KeyMoveLeft(a)
    {
        CSaveData.mSharedObject.data.mPlayer1_KeyMoveLeft = this._Player1_KeyMoveLeft = a;
        this.SaveData();
    }
    function get mPlayer1_KeyMoveLeft()
    {
        return CSaveData.mSharedObject.data.mPlayer1_KeyMoveLeft != undefined ? CSaveData.mSharedObject.data.mPlayer1_KeyMoveLeft : this._Player1_KeyMoveLeft;
    }
    function set mPlayer1_KeyMoveRight(a)
    {
        CSaveData.mSharedObject.data.mPlayer1_KeyMoveRight = this._Player1_KeyMoveRight = a;
        this.SaveData();
    }
    function get mPlayer1_KeyMoveRight()
    {
        return CSaveData.mSharedObject.data.mPlayer1_KeyMoveRight != undefined ? CSaveData.mSharedObject.data.mPlayer1_KeyMoveRight : this._Player1_KeyMoveRight;
    }
    function set mPlayer1_KeyShoot(a)
    {
        CSaveData.mSharedObject.data.mPlayer1_KeyShoot = this._Player1_KeyShoot = a;
        this.SaveData();
    }
    function get mPlayer1_KeyShoot()
    {
        return CSaveData.mSharedObject.data.mPlayer1_KeyShoot != undefined ? CSaveData.mSharedObject.data.mPlayer1_KeyShoot : this._Player1_KeyShoot;
    }
    function set mPlayer1_KeyNextWeapon(a)
    {
        CSaveData.mSharedObject.data.mPlayer1_KeyNextWeapon = this._Player1_KeyNextWeapon = a;
        this.SaveData();
    }
    function get mPlayer1_KeyNextWeapon()
    {
        return CSaveData.mSharedObject.data.mPlayer1_KeyNextWeapon != undefined ? CSaveData.mSharedObject.data.mPlayer1_KeyNextWeapon : this._Player1_KeyNextWeapon;
    }
    function set mPlayer1_KeyPrevWeapon(a)
    {
        CSaveData.mSharedObject.data.mPlayer1_KeyPrevWeapon = this._Player1_KeyPrevWeapon = a;
        this.SaveData();
    }
    function get mPlayer1_KeyPrevWeapon()
    {
        return CSaveData.mSharedObject.data.mPlayer1_KeyPrevWeapon != undefined ? CSaveData.mSharedObject.data.mPlayer1_KeyPrevWeapon : this._Player1_KeyPrevWeapon;
    }
    function set mPlayer2_KeyMoveUp(a)
    {
        CSaveData.mSharedObject.data.mPlayer2_KeyMoveUp = this._Player2_KeyMoveUp = a;
        this.SaveData();
    }
    function get mPlayer2_KeyMoveUp()
    {
        return CSaveData.mSharedObject.data.mPlayer2_KeyMoveUp != undefined ? CSaveData.mSharedObject.data.mPlayer2_KeyMoveUp : this._Player2_KeyMoveUp;
    }
    function set mPlayer2_KeyMoveDown(a)
    {
        CSaveData.mSharedObject.data.mPlayer2_KeyMoveDown = this._Player2_KeyMoveDown = a;
        this.SaveData();
    }
    function get mPlayer2_KeyMoveDown()
    {
        return CSaveData.mSharedObject.data.mPlayer2_KeyMoveDown != undefined ? CSaveData.mSharedObject.data.mPlayer2_KeyMoveDown : this._Player2_KeyMoveDown;
    }
    function set mPlayer2_KeyMoveLeft(a)
    {
        CSaveData.mSharedObject.data.mPlayer2_KeyMoveLeft = this._Player2_KeyMoveLeft = a;
        this.SaveData();
    }
    function get mPlayer2_KeyMoveLeft()
    {
        return CSaveData.mSharedObject.data.mPlayer2_KeyMoveLeft != undefined ? CSaveData.mSharedObject.data.mPlayer2_KeyMoveLeft : this._Player2_KeyMoveLeft;
    }
    function set mPlayer2_KeyMoveRight(a)
    {
        CSaveData.mSharedObject.data.mPlayer2_KeyMoveRight = this._Player2_KeyMoveRight = a;
        this.SaveData();
    }
    function get mPlayer2_KeyMoveRight()
    {
        return CSaveData.mSharedObject.data.mPlayer2_KeyMoveRight != undefined ? CSaveData.mSharedObject.data.mPlayer2_KeyMoveRight : this._Player2_KeyMoveRight;
    }
    function set mPlayer2_KeyShoot(a)
    {
        CSaveData.mSharedObject.data.mPlayer2_KeyShoot = this._Player2_KeyShoot = a;
        this.SaveData();
    }
    function get mPlayer2_KeyShoot()
    {
        return CSaveData.mSharedObject.data.mPlayer2_KeyShoot != undefined ? CSaveData.mSharedObject.data.mPlayer2_KeyShoot : this._Player2_KeyShoot;
    }
    function set mPlayer2_KeyNextWeapon(a)
    {
        CSaveData.mSharedObject.data.mPlayer2_KeyNextWeapon = this._Player2_KeyNextWeapon = a;
        this.SaveData();
    }
    function get mPlayer2_KeyNextWeapon()
    {
        return CSaveData.mSharedObject.data.mPlayer2_KeyNextWeapon != undefined ? CSaveData.mSharedObject.data.mPlayer2_KeyNextWeapon : this._Player2_KeyNextWeapon;
    }
    function set mPlayer2_KeyPrevWeapon(a)
    {
        CSaveData.mSharedObject.data.mPlayer2_KeyPrevWeapon = this._Player2_KeyPrevWeapon = a;
        this.SaveData();
    }
    function get mPlayer2_KeyPrevWeapon()
    {
        return CSaveData.mSharedObject.data.mPlayer2_KeyPrevWeapon != undefined ? CSaveData.mSharedObject.data.mPlayer2_KeyPrevWeapon : this._Player2_KeyPrevWeapon;
    }
    function set mPlayCount(a)
    {
        CSaveData.mSharedObject.data.mPlayCount = this._PlayCount = a;
        this.SaveData();
    }
    function get mPlayCount()
    {
        return CSaveData.mSharedObject.data.mPlayCount != undefined ? CSaveData.mSharedObject.data.mPlayCount : this._PlayCount;
    }
    function SaveData()
    {
        CSaveData.mSharedObject.flush();
        return "success";
    }
    function LoadData(tUsername)
    {
        CSaveData.mSharedObject = SharedObject.getLocal("BXHD_2PLAY_6");
        for(var _loc2_ in CSaveData.mSharedObject.data)
        {
        }
        this.__set__mMusicActive(CSaveData.mSharedObject.data.mMusicActive != undefined ? CSaveData.mSharedObject.data.mMusicActive : true);
        this.__set__mSoundActive(CSaveData.mSharedObject.data.mSoundActive != undefined ? CSaveData.mSharedObject.data.mSoundActive : true);
        this.__set__mDetail(CSaveData.mSharedObject.data.mDetail != undefined ? CSaveData.mSharedObject.data.mDetail : true);
        return "success";
    }
    function ResetData()
    {
        CSaveData.mSharedObject.clear();
        for(var _loc2_ in CSaveData.mSharedObject.data)
        {
            delete CSaveData.mSharedObject.data[_loc2_];
            CSaveData.mSharedObject.data[_loc2_] = undefined;
        }
        this.SaveData();
    }
}
