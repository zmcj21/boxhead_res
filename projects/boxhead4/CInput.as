class CInput
{
    var _CLASSID_ = "CInput";
    var _BASECLASSID_ = "CInput";
    function CInput()
    {
        if(!CInput.mValidKeys)
        {
            this.Setup_ValidKeys();
        }
        this.ResetKeys();
        this.RegisterKey("KEY_UP",CMain.mSaveData.__get__mPlayer1_KeyMoveUp());
        this.RegisterKey("KEY_DOWN",CMain.mSaveData.__get__mPlayer1_KeyMoveDown());
        this.RegisterKey("KEY_LEFT",CMain.mSaveData.__get__mPlayer1_KeyMoveLeft());
        this.RegisterKey("KEY_RIGHT",CMain.mSaveData.__get__mPlayer1_KeyMoveRight());
        this.RegisterKey("KEY_FIRE",CMain.mSaveData.__get__mPlayer1_KeyShoot());
        this.RegisterKey("KEY_NEXT_WEAPON",CMain.mSaveData.__get__mPlayer1_KeyNextWeapon());
        this.RegisterKey("KEY_PREV_WEAPON",CMain.mSaveData.__get__mPlayer1_KeyPrevWeapon());
        this.RegisterKey("KEY_UP2",CMain.mSaveData.__get__mPlayer2_KeyMoveUp());
        this.RegisterKey("KEY_DOWN2",CMain.mSaveData.__get__mPlayer2_KeyMoveDown());
        this.RegisterKey("KEY_LEFT2",CMain.mSaveData.__get__mPlayer2_KeyMoveLeft());
        this.RegisterKey("KEY_RIGHT2",CMain.mSaveData.__get__mPlayer2_KeyMoveRight());
        this.RegisterKey("KEY_FIRE2",CMain.mSaveData.__get__mPlayer2_KeyShoot());
        this.RegisterKey("KEY_NEXT_WEAPON2",CMain.mSaveData.__get__mPlayer2_KeyNextWeapon());
        this.RegisterKey("KEY_PREV_WEAPON2",CMain.mSaveData.__get__mPlayer2_KeyPrevWeapon());
        this.RegisterKey("KEY_PAUSE",CInput.ToAscii("P"));
        this.RegisterKey("KEY_SELECT1",CInput.ToAscii("1"));
        this.RegisterKey("KEY_SELECT2",CInput.ToAscii("2"));
        this.RegisterKey("KEY_SELECT3",CInput.ToAscii("3"));
        this.RegisterKey("KEY_SELECT4",CInput.ToAscii("4"));
        this.RegisterKey("KEY_SELECT5",CInput.ToAscii("5"));
        this.RegisterKey("KEY_SELECT6",CInput.ToAscii("6"));
        this.RegisterKey("KEY_SELECT7",CInput.ToAscii("7"));
        this.RegisterKey("KEY_SELECT8",CInput.ToAscii("8"));
        this.RegisterKey("KEY_SELECT9",CInput.ToAscii("9"));
        this.RegisterKey("KEY_SELECT0",CInput.ToAscii("0"));
        var _loc3_ = new Object();
        _loc3_.pClass = this;
        _loc3_.onKeyDown = function()
        {
            this.pClass.ProcessAllKeys();
        };
        _loc3_.onKeyUp = function()
        {
            this.pClass.ProcessAllKeys();
        };
        Key.addListener(_loc3_);
        var _loc2_ = new Object();
        _loc2_.pClass = this;
        _loc2_.onMouseDown = function()
        {
            this.pClass.mMouseDown = true;
        };
        _loc2_.onMouseUp = function()
        {
            this.pClass.mMouseDown = false;
        };
        Mouse.addListener(_loc2_);
    }
    static function ToAscii(c)
    {
        return c.charCodeAt(0);
    }
    function ResetKeys()
    {
        this.mKey_List = new Array();
        this.mKey_List_Registered = new Array();
        0;
        while(true)
        {
            this.mKey_List[0] = {mKeycode:0,mPressed:false,mTimePressed:0,mDown:false,mReleased:false,mTimeDown:0,mTimeReleased:0};
            this.mKey_List[0].IsPressed = function()
            {
                if(this.mPressed)
                {
                    this.mPressed = false;
                    return true;
                }
                return false;
            };
            this.mKey_List[0].IsReleased = function()
            {
                if(this.mReleased)
                {
                    this.mReleased = false;
                    this.mPressed = false;
                    return true;
                }
                return false;
            };
            this.mKey_List[0].IsDown = function()
            {
                return Key.isDown(this.mKeycode) || Key.isDown(this.mKeycode_1);
            };
            this.mKey_List[0].IsUp = function()
            {
                return !this.IsDown();
            };
            this.mKey_List[0].Renew = function()
            {
                this.mReleased = false;
                this.mPressed = false;
                this.mDown = false;
            };
            1;
        }
    }
    function RegisterKey(tKeyID, tKeycode)
    {
        this[tKeyID] = this.mKey_List[tKeycode];
        this.mKey_List_Registered.push(this.mKey_List[tKeycode]);
    }
    function AddAdditionKeyCode(tKey, tKeycode_1)
    {
        tKey.mKeycode_1 = tKeycode_1;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function AnyKeyPressed()
    {
        0;
        while(true)
        {
            if(this.mKey_List[0].mPressed)
            {
                return true;
            }
            1;
        }
        return false;
    }
    function ProcessAllKeys()
    {
        for(var _loc2_ in this.mKey_List_Registered)
        {
            this.UpdateKey(this.mKey_List_Registered[_loc2_]);
        }
    }
    function UpdateKey(tKey)
    {
        if(tKey.IsDown())
        {
            if(!tKey.mDown)
            {
                tKey.mDown = true;
                tKey.mTimeDown = 3011;
                if(!tKey.mPressed)
                {
                    tKey.mPressed = true;
                    tKey.mTimePressed = 9592;
                }
            }
        }
        else if(tKey.mDown)
        {
            tKey.mDown = false;
            tKey.mReleased = true;
            tKey.mTimeReleased = 5821;
        }
    }
    function Setup_ValidKeys()
    {
        CInput.mValidKeys[20] = {mValid:false,mName:"CAPS LOCK"};
        CInput.mValidKeys[144] = {mValid:false,mName:"NUM LOCK "};
        CInput.mValidKeys[145] = {mValid:false,mName:"SCROLL LOCK "};
        CInput.mValidKeys = new Array();
        CInput.mValidKeys[38] = {mValid:true,mName:"ARROW UP"};
        CInput.mValidKeys[40] = {mValid:true,mName:"ARROW DOWN"};
        CInput.mValidKeys[37] = {mValid:true,mName:"ARROW LEFT"};
        CInput.mValidKeys[39] = {mValid:true,mName:"ARROW RIGHT"};
        CInput.mValidKeys[111] = {mValid:true,mName:"NUM PD \'/\'"};
        CInput.mValidKeys[106] = {mValid:true,mName:"NUM PD \'*\'"};
        CInput.mValidKeys[109] = {mValid:true,mName:"NUM PD \'-\'"};
        CInput.mValidKeys[107] = {mValid:true,mName:"NUM PD \'+\'"};
        CInput.mValidKeys[110] = {mValid:true,mName:"NUM PD \'.\'"};
        CInput.mValidKeys[96] = {mValid:true,mName:"NUM PD \'0\'"};
        CInput.mValidKeys[97] = {mValid:true,mName:"NUM PD \'1\'"};
        CInput.mValidKeys[98] = {mValid:true,mName:"NUM PD \'2\'"};
        CInput.mValidKeys[99] = {mValid:true,mName:"NUM PD \'3\'"};
        CInput.mValidKeys[100] = {mValid:true,mName:"NUM PD \'4\'"};
        CInput.mValidKeys[101] = {mValid:true,mName:"NUM PD \'5\'"};
        CInput.mValidKeys[102] = {mValid:true,mName:"NUM PD \'6\'"};
        CInput.mValidKeys[103] = {mValid:true,mName:"NUM PD \'7\'"};
        CInput.mValidKeys[104] = {mValid:true,mName:"NUM PD \'8\'"};
        CInput.mValidKeys[105] = {mValid:true,mName:"NUM PD \'9\'"};
        CInput.mValidKeys[65] = {mValid:true,mName:"\'A\'"};
        CInput.mValidKeys[66] = {mValid:true,mName:"\'B\'"};
        CInput.mValidKeys[67] = {mValid:true,mName:"\'C\'"};
        CInput.mValidKeys[68] = {mValid:true,mName:"\'D\'"};
        CInput.mValidKeys[69] = {mValid:true,mName:"\'E\'"};
        CInput.mValidKeys[70] = {mValid:true,mName:"\'F\'"};
        CInput.mValidKeys[71] = {mValid:true,mName:"\'G\'"};
        CInput.mValidKeys[72] = {mValid:true,mName:"\'H\'"};
        CInput.mValidKeys[73] = {mValid:true,mName:"\'I\'"};
        CInput.mValidKeys[74] = {mValid:true,mName:"\'J\'"};
        CInput.mValidKeys[75] = {mValid:true,mName:"\'K\'"};
        CInput.mValidKeys[76] = {mValid:true,mName:"\'L\'"};
        CInput.mValidKeys[77] = {mValid:true,mName:"\'M\'"};
        CInput.mValidKeys[78] = {mValid:true,mName:"\'N\'"};
        CInput.mValidKeys[79] = {mValid:true,mName:"\'O\'"};
        CInput.mValidKeys[81] = {mValid:true,mName:"\'Q\'"};
        CInput.mValidKeys[82] = {mValid:true,mName:"\'R\'"};
        CInput.mValidKeys[83] = {mValid:true,mName:"\'S\'"};
        CInput.mValidKeys[84] = {mValid:true,mName:"\'T\'"};
        CInput.mValidKeys[85] = {mValid:true,mName:"\'U\'"};
        CInput.mValidKeys[86] = {mValid:true,mName:"\'V\'"};
        CInput.mValidKeys[87] = {mValid:true,mName:"\'W\'"};
        CInput.mValidKeys[88] = {mValid:true,mName:"\'X\'"};
        CInput.mValidKeys[89] = {mValid:true,mName:"\'Y\'"};
        CInput.mValidKeys[90] = {mValid:true,mName:"\'Z\'"};
        CInput.mValidKeys[32] = {mValid:true,mName:"\' \'"};
        CInput.mValidKeys[188] = {mValid:true,mName:"\',\'"};
        CInput.mValidKeys[190] = {mValid:true,mName:"\'.\'"};
        CInput.mValidKeys[191] = {mValid:true,mName:"\'/\'"};
        CInput.mValidKeys[220] = {mValid:true,mName:"\'\'"};
        CInput.mValidKeys[189] = {mValid:true,mName:"\'-\'"};
        CInput.mValidKeys[187] = {mValid:true,mName:"\'=\'"};
        CInput.mValidKeys[46] = {mValid:true,mName:"\'DEL\'"};
        CInput.mValidKeys[36] = {mValid:true,mName:"\'HOME\'"};
        CInput.mValidKeys[35] = {mValid:true,mName:"\'END\'"};
        CInput.mValidKeys[33] = {mValid:true,mName:"\'PGUP\'"};
        CInput.mValidKeys[34] = {mValid:true,mName:"\'PGDN\'"};
        CInput.mValidKeys[45] = {mValid:true,mName:"\'INSERT\'"};
        CInput.mValidKeys[0] = {mValid:false,mName:"-zero-"};
        CInput.mValidKeys[186] = {mValid:false,mName:"\';\'"};
        CInput.mValidKeys[192] = {mValid:false,mName:"\'\'\'"};
        CInput.mValidKeys[222] = {mValid:false,mName:"\'#\'"};
        CInput.mValidKeys[219] = {mValid:false,mName:"\'[\'"};
        CInput.mValidKeys[221] = {mValid:false,mName:"\']\'"};
    }
    static function isValidKey(keyCode)
    {
        return CInput.mValidKeys[keyCode];
    }
}
