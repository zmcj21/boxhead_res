if(!_global.CContextMenu)
{
    _global.CContextMenu = 0;
    var _loc2_ = 0.prototype;
    0.Loading = function()
    {
        var _loc2_ = undefined;
        var _loc4_ = function(obj, item)
        {
            getUrl("http://www.games.seantcooper.com", "_blank");
        };
        0;
        _loc2_ = new ContextMenu(0);
        _loc2_.hideBuiltInItems();
        _loc2_.customItems.push(new ContextMenuItem("© Sean Cooper 2006",_loc4_));
        _root.menu = _loc2_;
        return _loc2_;
    };
    0.InGame = function()
    {
        var _loc2_ = CContextMenu.Loading();
        var _loc7_ = function(obj, item)
        {
            CSaveData._this.__set__mSoundActive(!CSaveData._this.__get__mSoundActive());
            var _loc1_ = !CSaveData._this.__get__mSoundActive() ? "OFF" : "ON";
            item.caption = "Sound: " + _loc1_;
        };
        var _loc4_ = function(obj, item)
        {
            CSaveData._this.__set__mMusicActive(!CSaveData._this.__get__mMusicActive());
            var _loc1_ = !CSaveData._this.__get__mMusicActive() ? "OFF" : "ON";
            item.caption = "Music: " + _loc1_;
        };
        var _loc6_ = function(obj, item)
        {
            CSaveData._this.__set__mDetail(!CSaveData._this.__get__mDetail());
            var _loc1_ = !CSaveData._this.__get__mDetail() ? "LOW" : "BEST";
            item.caption = "Quality: " + _loc1_;
        };
        var _loc10_ = !CSaveData._this.__get__mSoundActive() ? "OFF" : "ON";
        var _loc8_ = !CSaveData._this.__get__mMusicActive() ? "OFF" : "ON";
        var _loc9_ = !CSaveData._this.__get__mDetail() ? "LOW" : "BEST";
        var _loc3_ = new ContextMenuItem("Sound: " + _loc10_,_loc7_);
        _loc3_.separatorBefore = true;
        _loc2_.customItems.push(_loc3_);
        _loc2_.customItems.push(new ContextMenuItem("Music: " + _loc8_,_loc4_));
        _loc2_.customItems.push(new ContextMenuItem("Quality: " + _loc9_,_loc6_));
        _root.menu = _loc2_;
        return _loc2_;
    };
    _loc2_._CLASSID_ = "CContextMenu";
    §§push(ASSetPropFlags(_global.CContextMenu.prototype,null,1));
}
§§pop();
