package
{
    public class CVersion
    {
         
        
        public function CVersion()
        {
            super();
        }
        
        public static function get mMinorVersion() : String
        {
            return "00239";
        }
        
        public static function get mVersionString() : String
        {
            return mName + ": " + mVersionID + " (" + mCompileDate + ")";
        }
        
        public static function get mCompileDate() : String
        {
            return "14/10/2008 08:15";
        }
        
        public static function get mVersionName() : String
        {
            return "Final";
        }
        
        public static function get mName() : String
        {
            return "BXH_ZW";
        }
        
        public static function get mMajorVersion() : String
        {
            return "1";
        }
        
        public static function get mVersionID() : String
        {
            return mVersionName + "." + mMajorVersion + "." + mMinorVersion;
        }
    }
}
