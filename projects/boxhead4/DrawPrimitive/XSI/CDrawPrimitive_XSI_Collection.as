class DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection
{
    var _CLASSID_ = "CDrawPrimitive_XSI_Collection";
    static var mRenderQuality = "MEDIUM";
    function CDrawPrimitive_XSI_Collection()
    {
        this.mItems = new Object();
    }
    function AddItem(tItem)
    {
        this.mItems[tItem.mID] = tItem;
    }
    function MimicItem(tID, tMimicItemID)
    {
        this.mItems[tID] = this.mItems[tMimicItemID];
    }
    static function StartRender(tScale)
    {
        DrawPrimitive.XSI.CDrawPrimitive_XSI.mGlobalScale = tScale != undefined ? tScale : 0.35;
        DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection.mBackQuality = DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection.mBackQuality != undefined ? DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection.mBackQuality : _root._quality;
        if(_root._quality != CSaveData.mDefaultQuality)
        {
            _root._quality = CSaveData.mDefaultQuality;
        }
    }
    static function EndRender()
    {
        if(DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection.mBackQuality != _root._quality)
        {
            _root._quality = DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection.mBackQuality;
        }
        delete DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection.mBackQuality;
    }
}
