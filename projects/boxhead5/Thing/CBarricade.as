package Thing
{
    import World.eWMCCollideType;
    
    public class CBarricade extends CThingObject
    {
         
        
        public function CBarricade(param1:Object, param2:* = null)
        {
            param1.mCollideRadius = 0.4;
            super(param1,param2);
            mLife = !!param1.mLife ? int(param1.mLife) : 1000;
            mMaxLife = 1000;
            mAudioMaterial = "METAL";
            SetCollide(mCellCurrent,eWMCCollideType.BARRICADE);
            if(!SpriteSheetExists(_CLASSID_))
            {
                AddSpriteSheet(_CLASSID_,new SheetBarricade(0,0));
            }
            SetState("State_GROWRADIUS");
            NavMapAdd();
        }
        
        override public function Dispose() : void
        {
            NavMapRemove();
            super.Dispose();
        }
        
        override public function Affect_FIRE(param1:CAffect) : void
        {
            mLife -= param1.mDamage / 8;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CBarricade";
        }
    }
}
