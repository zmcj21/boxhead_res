class CSaveData
{
    var Dispose = 0;
    var _CLASSID_ = "CSaveData";
    var _MusicActive = true;
    var _SoundActive = true;
    var _Detail = true;
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
    }
    function get mMusicActive()
    {
        return CSaveData.mSharedObject.data.mMusicActive != undefined ? CSaveData.mSharedObject.data.mMusicActive : this._MusicActive;
    }
    function set mSoundActive(a)
    {
        CSaveData.mSharedObject.data.mSoundActive = this._SoundActive = a;
        this.SaveData();
    }
    function get mSoundActive()
    {
        return CSaveData.mSharedObject.data.mSoundActive != undefined ? CSaveData.mSharedObject.data.mSoundActive : this._SoundActive;
    }
    function set mDetail(a)
    {
        CSaveData.mSharedObject.data.mDetail = this._Detail = a;
        this.SaveData();
    }
    function get mDetail()
    {
        return CSaveData.mSharedObject.data.mDetail != undefined ? CSaveData.mSharedObject.data.mDetail : this._Detail;
    }
    function SaveData()
    {
        CSaveData.mSharedObject.flush();
        return "success";
    }
    function LoadData(tUsername)
    {
        CSaveData.mSharedObject = SharedObject.getLocal("Boxhead" + tUsername);
        for(var _loc1_ in CSaveData.mSharedObject.data)
        {
        }
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
