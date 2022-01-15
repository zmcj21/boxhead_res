class CInput
{
    var _CLASSID_ = "CInput";
    var _BASECLASSID_ = "CInput";
    function CInput()
    {
        this.ResetKeys();
        this.RegisterKey("KEY_UP",38);
        this.RegisterKey("KEY_DOWN",40);
        this.RegisterKey("KEY_LEFT",37);
        this.RegisterKey("KEY_RIGHT",39);
        this.RegisterKey("KEY_FIRE",CInput.ToAscii(" "));
        this.RegisterKey("KEY_UP2",CInput.ToAscii("W"));
        this.RegisterKey("KEY_DOWN2",CInput.ToAscii("S"));
        this.RegisterKey("KEY_LEFT2",CInput.ToAscii("A"));
        this.RegisterKey("KEY_RIGHT2",CInput.ToAscii("D"));
        this.RegisterKey("KEY_FIRE2",CInput.ToAscii("F"));
        this.RegisterKey("KEY_PAUSE",CInput.ToAscii("P"));
        this.RegisterKey("KEY_INFO",CInput.ToAscii("I"));
        this.RegisterKey("KEY_HUD",CInput.ToAscii("H"));
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
                return Key.isDown(this.mKeycode);
            };
            this.mKey_List[0].IsUp = function()
            {
                return !Key.isDown(this.mKeycode);
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
        if(Key.isDown(tKey.mKeycode))
        {
            if(!tKey.mDown)
            {
                tKey.mDown = true;
                tKey.mTimeDown = 4840;
                if(!tKey.mPressed)
                {
                    tKey.mPressed = true;
                    tKey.mTimePressed = 1876;
                }
            }
        }
        else if(tKey.mDown)
        {
            tKey.mDown = false;
            tKey.mReleased = true;
            tKey.mTimeReleased = 10571;
        }
    }
}
