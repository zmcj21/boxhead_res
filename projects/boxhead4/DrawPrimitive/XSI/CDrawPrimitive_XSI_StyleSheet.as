if(!_global.DrawPrimitive)
{
    _global.DrawPrimitive = new Object();
}
§§pop();
if(!_global.DrawPrimitive.XSI)
{
    _global.DrawPrimitive.XSI = new Object();
}
§§pop();
if(!_global.DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet)
{
    DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet = 0;
    var _loc2_ = 0.prototype;
    0.SS_FINALIZE = function(tStyleSheet)
    {
        if(tStyleSheet.mScalarMatrix)
        {
            return undefined;
        }
        tStyleSheet.mScalarMatrix = new flash.geom.Matrix();
        tStyleSheet.mScalarMatrix.scale(tStyleSheet.mScale,tStyleSheet.mScale);
    };
    0.SS_APPLY = function(tStyleSheet)
    {
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.SS_FINALIZE(tStyleSheet);
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mXSI_DI.ApplyStyleSheet(tStyleSheet);
    };
    0.SS_BAMBO = function()
    {
        var _loc1_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mXSI_DI.GetStyleSheet(DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mDefault_AnimID);
        _loc1_.mID = "SS_BAMBO";
        _loc1_.mModels.GunPosition_Right.mVisible = false;
        _loc1_.mModels.Body_Front.mVisible = false;
        _loc1_.mModels.Body_Back.mVisible = false;
        _loc1_.mMaterials.Body_Back.mcLinkID = "Bambo_Body_Back";
        _loc1_.mMaterials.Body_Front.mcLinkID = "Bambo_Body_Front";
        _loc1_.mMaterials.Body_Side.mcLinkID = "Bambo_Body_Side";
        _loc1_.mMaterials.Body_Top.mcLinkID = "Bambo_Body_Top";
        _loc1_.mMaterials.Head_Back.mcLinkID = "Bambo_Head_Back";
        _loc1_.mMaterials.Head_Front.mcLinkID = "Bambo_Head_Front";
        _loc1_.mMaterials.Head_Side.mcLinkID = "Bambo_Head_Side";
        _loc1_.mMaterials.Bandana.mColor = 16711680;
        _loc1_.mMaterials.LowerArm.mColor = 16764057;
        _loc1_.mMaterials.UpperArm.mColor = 16764057;
        _loc1_.mMaterials.Hand.mColor = 0;
        _loc1_.mMaterials.Hair.mColor = 0;
        _loc1_.mScale = 0.35;
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.SS_APPLY(_loc1_);
    };
    0.SS_BOND = function()
    {
        var _loc1_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mXSI_DI.GetStyleSheet(DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mDefault_AnimID);
        _loc1_.mID = "SS_BOND";
        _loc1_.mModels.GunPosition_Right.mVisible = false;
        _loc1_.mModels.Body_Front.mVisible = false;
        _loc1_.mModels.Body_Back.mVisible = false;
        _loc1_.mMaterials.Body_Back.mcLinkID = "Bond_Body_Back";
        _loc1_.mMaterials.Body_Front.mcLinkID = "Bond_Body_Front";
        _loc1_.mMaterials.Body_Side.mcLinkID = "Bond_Body_Side";
        _loc1_.mMaterials.Body_Top.mcLinkID = "Bond_Body_Top";
        _loc1_.mMaterials.Head_Back.mcLinkID = "Bond_Head_Back";
        _loc1_.mMaterials.Head_Front.mcLinkID = "Bond_Head_Front";
        _loc1_.mMaterials.Head_Side.mcLinkID = "Bond_Head_Side";
        _loc1_.mMaterials.Bandana.mColor = 51;
        _loc1_.mMaterials.Cloth.mColor = 51;
        _loc1_.mMaterials.LowerArm.mColor = 51;
        _loc1_.mMaterials.UpperArm.mColor = 51;
        _loc1_.mMaterials.Hand.mColor = 0;
        _loc1_.mMaterials.Hair.mColor = 0;
        _loc1_.mScale = 0.35;
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.SS_APPLY(_loc1_);
    };
    0.SS_GIJOE = function()
    {
        var _loc1_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mXSI_DI.GetStyleSheet(DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mDefault_AnimID);
        _loc1_.mID = "SS_GIJOE";
        _loc1_.mModels.GunPosition_Right.mVisible = false;
        _loc1_.mGroup_Remap = "Player_Alternate1";
        _loc1_.mModels.Head.mGroup_Remap = "Player_Alternate1";
        _loc1_.mModels.Foot_Right.mGroup_Remap = "Player_Alternate1";
        _loc1_.mModels.Foot_Left.mGroup_Remap = "Player_Alternate1";
        _loc1_.mModels.Body_Front.mVisible = false;
        _loc1_.mModels.Body_Back.mVisible = false;
        _loc1_.mMaterials.Body_Back.mcLinkID = "GIJOE_Body_Back";
        _loc1_.mMaterials.Body_Front.mcLinkID = "GIJOE_Body_Front";
        _loc1_.mMaterials.Body_Side.mcLinkID = "GIJOE_Body_Side";
        _loc1_.mMaterials.Body_Top.mcLinkID = "GIJOE_Body_Top";
        _loc1_.mMaterials.Head_Back.mcLinkID = "GIJOE_Head_Back";
        _loc1_.mMaterials.Head_Front.mcLinkID = "GIJOE_Head_Front";
        _loc1_.mMaterials.Head_Side.mcLinkID = "GIJOE_Head_Side";
        _loc1_.mMaterials.Hair.mColor = 0;
        _loc1_.mMaterials.Bandana.mColor = 14601386;
        _loc1_.mMaterials.Cloth.mColor = 14601386;
        _loc1_.mMaterials.LowerArm.mColor = 14601386;
        _loc1_.mMaterials.UpperArm.mColor = 14601386;
        _loc1_.mMaterials.Hand.mColor = 16764057;
        _loc1_.mScale = 0.35;
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.SS_APPLY(_loc1_);
    };
    0.SS_SWAT = function()
    {
        var _loc1_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mXSI_DI.GetStyleSheet(DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mDefault_AnimID);
        _loc1_.mID = "SS_SWAT";
        _loc1_.mModels.GunPosition_Right.mVisible = false;
        _loc1_.mGroup_Remap = "Player_Alternate1";
        _loc1_.mModels.Head.mGroup_Remap = "Player_Alternate1";
        _loc1_.mModels.Foot_Right.mGroup_Remap = "Player_Alternate1";
        _loc1_.mModels.Foot_Left.mGroup_Remap = "Player_Alternate1";
        _loc1_.mModels.Body_Front.mVisible = false;
        _loc1_.mModels.Body_Back.mVisible = false;
        _loc1_.mMaterials.Body_Back.mcLinkID = "Swat_Body_Back";
        _loc1_.mMaterials.Body_Front.mcLinkID = "Swat_Body_Front";
        _loc1_.mMaterials.Body_Side.mcLinkID = "Swat_Body_Side";
        _loc1_.mMaterials.Body_Top.mcLinkID = "Swat_Body_Top";
        _loc1_.mMaterials.Head_Back.mcLinkID = "Swat_Head_Back";
        _loc1_.mMaterials.Head_Front.mcLinkID = "Swat_Head_Front";
        _loc1_.mMaterials.Head_Side.mcLinkID = "Swat_Head_Side";
        _loc1_.mMaterials.Bandana.mColor = 51;
        _loc1_.mMaterials.Cloth.mColor = 51;
        _loc1_.mMaterials.LowerArm.mColor = 51;
        _loc1_.mMaterials.UpperArm.mColor = 51;
        _loc1_.mMaterials.Hand.mColor = 0;
        _loc1_.mScale = 0.35;
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.SS_APPLY(_loc1_);
    };
    0.SS_ZOMBIE = function()
    {
        var _loc1_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mXSI_DI.GetStyleSheet(DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mDefault_AnimID);
        _loc1_.mID = "SS_ZOMBIE";
        _loc1_.mModels.Weapon_Right.mVisible = false;
        _loc1_.mModels.GunPosition_Right.mVisible = false;
        _loc1_.mGroup_Remap = "Zombie";
        _loc1_.mModels.Head.mGroup_Remap = "Zombie";
        _loc1_.mModels.Body_Front.mVisible = false;
        _loc1_.mModels.Body_Back.mVisible = false;
        _loc1_.mMaterials.Body_Back.mcLinkID = "Zombie_Body_Back";
        _loc1_.mMaterials.Body_Front.mcLinkID = "Zombie_Body_Front";
        _loc1_.mMaterials.Body_Side.mcLinkID = "Zombie_Body_Side";
        _loc1_.mMaterials.Body_Top.mcLinkID = "Zombie_Body_Top";
        _loc1_.mMaterials.Bandana.mColor = 11584734;
        _loc1_.mMaterials.LowerArm.mColor = 11584734;
        _loc1_.mMaterials.UpperArm.mColor = 16777215;
        _loc1_.mMaterials.Hand.mColor = 11584734;
        _loc1_.mScale = 0.35;
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.SS_APPLY(_loc1_);
    };
    0.SS_DEVIL = function(tScale)
    {
        var _loc1_ = DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mXSI_DI.GetStyleSheet(DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mDefault_AnimID);
        _loc1_.mID = "SS_DEVIL";
        _loc1_.mModels.Weapon_Right.mVisible = false;
        _loc1_.mModels.GunPosition_Right.mVisible = false;
        _loc1_.mGroup_Remap = "Devil";
        _loc1_.mModels.Head.mGroup_Remap = "Devil";
        _loc1_.mModels.Body_Front.mVisible = false;
        _loc1_.mModels.Body_Back.mVisible = false;
        _loc1_.mMaterials.Body_Back.mcLinkID = "Devil_Body_Back";
        _loc1_.mMaterials.Body_Front.mcLinkID = "Devil_Body_Front";
        _loc1_.mMaterials.Body_Side.mcLinkID = "Devil_Body_Side";
        _loc1_.mMaterials.Body_Top.mcLinkID = "Devil_Body_Top";
        _loc1_.mMaterials.Bandana.mColor = 16711680;
        _loc1_.mMaterials.LowerArm.mColor = 16711680;
        _loc1_.mMaterials.UpperArm.mColor = 16711680;
        _loc1_.mMaterials.Hand.mColor = 0;
        _loc1_.mMaterials.Foot.mColor = 0;
        _loc1_.mScale = !tScale ? 0.44 : tScale;
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.SS_APPLY(_loc1_);
    };
    0.SS_DEFAULT = function()
    {
        DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.mXSI_DI.ApplyStyleSheet();
    };
    _loc2_._CLASSID_ = "CDrawPrimitive_XSI_StyleSheet";
    _loc2_._BASECLASSID_ = "CDrawPrimitive_XSI_StyleSheet";
    0.mDefault_AnimID = "Player_Handgun_Walk";
    §§push(ASSetPropFlags(DrawPrimitive.XSI.CDrawPrimitive_XSI_StyleSheet.prototype,null,1));
}
§§pop();
