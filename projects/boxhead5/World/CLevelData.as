package World
{
    public class CLevelData
    {
         
        
        public function CLevelData()
        {
            super();
        }
        
        public static function GetData(param1:int) : Object
        {
            switch(param1)
            {
                case 0:
                default:
                    return {
                        "initClass":Level_00,
                        "mMode":"NONE",
                        "mIndex":0,
                        "mName":"Close combat"
                    };
                case 1:
                    return {
                        "initClass":Level_01,
                        "mMode":"NONE",
                        "mIndex":1,
                        "mName":"Death alley"
                    };
                case 2:
                    return {
                        "initClass":Level_02,
                        "mMode":"NONE",
                        "mIndex":2,
                        "mName":"Double trouble"
                    };
                case 3:
                    return {
                        "initClass":Level_03,
                        "mMode":"NONE",
                        "mIndex":3,
                        "mName":"In the middle"
                    };
                case 4:
                    return {
                        "initClass":Level_00,
                        "mMode":"DEFENCE",
                        "mIndex":4,
                        "mName":"Welcome to HELL"
                    };
                case 5:
                    return {
                        "initClass":Level_01,
                        "mMode":"DEFENCE",
                        "mIndex":5,
                        "mName":"Top heavy"
                    };
                case 6:
                    return {
                        "initClass":Level_02,
                        "mMode":"DEFENCE",
                        "mIndex":6,
                        "mName":"The road to hell"
                    };
                case 7:
                    return {
                        "initClass":Level_03,
                        "mMode":"DEFENCE",
                        "mIndex":7,
                        "mName":"Cross roads"
                    };
            }
        }
        
        public function get _CLASSID_() : String
        {
            return "CLevelData";
        }
    }
}
