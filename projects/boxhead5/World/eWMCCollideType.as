package World
{
    public class eWMCCollideType
    {
        
        public static const DUMBCELL:uint = 512;
        
        public static const BARRICADE:uint = 256;
        
        public static const SOLID:uint = 2;
        
        public static const NONINITABLE:uint = 65535;
        
        public static const INVALIDANDIE:uint = SOLID | DUMBCELL;
        
        public static const TREE:uint = 16;
        
        public static const PEEP:uint = 4;
        
        public static const PLAYER:uint = 8;
        
        public static const ROCK:uint = 32;
        
        public static const BARREL:uint = 64;
        
        public static const TURRET:uint = 128;
        
        public static const NONNAVIGATE:uint = SOLID | TREE | TURRET | ROCK | BARREL | BARRICADE;
        
        public static const NONMOVABLE:uint = PEEP | SOLID | TREE | TURRET | ROCK | BARREL | BARRICADE;
        
        public static const NONE:uint = 0;
        
        public static const EDGE:uint = 1;
        
        public static const NONPLACEMENT:uint = NONMOVABLE | EDGE;
         
        
        public function eWMCCollideType()
        {
            super();
        }
    }
}
