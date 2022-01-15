package Thing
{
    import World.eWMCCollideType;
    
    public class CTree extends CThingObject
    {
         
        
        public function CTree(param1:Object, param2:* = null)
        {
            param1.mCollideRadius = 0.4;
            super(param1);
            mLife = 1000;
            mMaxLife = 1000;
            mAudioMaterial = "METAL";
            SetCollide(mCellCurrent,eWMCCollideType.TREE);
            mAnimationFrame = Random();
            mPosition.y += RandomOffset(0.1);
            if(!MCAnimationExists(_CLASSID_))
            {
                AddMCAnimation(_CLASSID_,new Object_Tree());
            }
            SetState("State_GROWRADIUS");
            mAnimationFrame = Random();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CTree";
        }
    }
}
