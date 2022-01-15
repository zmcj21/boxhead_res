package Thing
{
    import World.eWMCCollideType;
    
    public class CRock extends CThingObject
    {
         
        
        public function CRock(param1:Object, param2:* = null)
        {
            param1.mCollideRadius = 0.5;
            super(param1);
            mLife = 1000;
            mMaxLife = 1000;
            mAudioMaterial = "METAL";
            SetCollide(mCellCurrent,eWMCCollideType.ROCK);
            if(!MCAnimationExists(_CLASSID_))
            {
                AddMCAnimation(_CLASSID_,new Object_Rock());
            }
            SetState("State_GROWRADIUS");
            mAnimationFrame = Random();
        }
        
        override public function get _CLASSID_() : String
        {
            return "CRock";
        }
    }
}
