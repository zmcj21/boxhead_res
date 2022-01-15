package Thing
{
    import World.CWMCNavigation;
    
    public class CThingNavigation extends CThingCollision
    {
        
        private static const nDirStack:Array = [0,-1,1,-2,2,-3,3,4];
        
        private static const pDirStack:Array = [0,1,-1,2,-2,3,-3,4];
         
        
        public function CThingNavigation()
        {
            super();
        }
        
        public function Peep_Navigate_NM() : CThingAngle
        {
            var _loc1_:* = null;
            if(false)
            {
            }
            _loc1_ = mCellCurrent.MovableNeighbours8_1(mAngle.mDirectionName);
            return !!_loc1_ ? CThingAngle.AsXY(_loc1_.mapX - 0,_loc1_.mapY - 0) : null;
        }
        
        override public function get _CLASSID_() : String
        {
            return "CThingNavigation";
        }
    }
}
