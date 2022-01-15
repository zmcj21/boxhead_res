class CSaveData
{
    var Dispose = 0;
    var _CLASSID_ = "CSaveData";
    var _MusicActive = true;
    var _SoundActive = true;
    var _Detail = true;
    var mQualityActive = false;
    var _Difficulty = 0;
    var _PlayCount = 0;
    function CSaveData()
    {
        CSaveData.obj = this;
        CSaveData._this = this;
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
        _root._quality = !(this._Detail || !this.mQualityActive) ? "LOW" : "HIGH";
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
        trace("DATA SAVED");
        return "success";
    }
    function LoadData(tUsername)
    {
        trace("Load game for " + tUsername);
        CSaveData.mSharedObject = SharedObject.getLocal(tUsername);
        for(var _loc2_ in CSaveData.mSharedObject.data)
        {
            trace(_loc2_ + " = " + CSaveData.mSharedObject.data[_loc2_]);
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
