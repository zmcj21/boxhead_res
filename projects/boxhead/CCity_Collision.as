class CCity_Collision extends MovieClip
{
    var _CLASSID_ = "CCity_Collision";
    function CCity_Collision()
    {
        super();
        if(this.mType == undefined)
        {
            this.mType = CMapwho.mCollide_Solid;
        }
        CCity._this.AddCollideMC(this);
    }
}
