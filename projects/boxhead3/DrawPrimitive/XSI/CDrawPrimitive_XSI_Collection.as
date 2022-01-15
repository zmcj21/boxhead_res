class DrawPrimitive.XSI.CDrawPrimitive_XSI_Collection
{
    var _CLASSID_ = "CDrawPrimitive_XSI_Collection";
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
    function StartRender(tScale)
    {
        DrawPrimitive.XSI.CDrawPrimitive_XSI.mGlobalScale = tScale != undefined ? tScale : 0.35;
        this.mBackQuality = this.mBackQuality != undefined ? this.mBackQuality : _root._quality;
        _root._quality = "BEST";
    }
    function EndRender()
    {
        _root._quality = this.mBackQuality;
        delete this.mBackQuality;
    }
}
