package
{
    public class CBuild
    {
        
        public static const mDEBUG:Boolean = false;
        
        public static const mSkipIntro:Boolean = !!mDEBUG ? true : false;
        
        public static const UNLIMITEDAMMO:Boolean = false;
        
        public static const PLAYERDOESNOTDIES:Boolean = false;
        
        public static const mKongregateStats:Boolean = true;
        
        public static const mLoadingTime:int = !!mDEBUG ? 1 : 10;
         
        
        public function CBuild()
        {
            super();
        }
    }
}
