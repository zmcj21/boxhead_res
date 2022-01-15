class CInput
{
    var _CLASSID_ = "CInput";
    function CInput()
    {
        this.mDefineKeyList = new Array();
        this.mKEY_UP = 38;
        this.mDefineKeyList[this.mDefineKeyList.length] = 38;
        this.mKEY_DOWN = 40;
        this.mDefineKeyList[this.mDefineKeyList.length] = 40;
        this.mKEY_LEFT = 37;
        this.mDefineKeyList[this.mDefineKeyList.length] = 37;
        this.mKEY_RIGHT = 39;
        this.mDefineKeyList[this.mDefineKeyList.length] = 39;
        this.mKEY_LEFT2 = _loc0_ = this.ToAscii("Z");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_RIGHT2 = _loc0_ = this.ToAscii("X");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_FIRE = _loc0_ = this.ToAscii(" ");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_USE = _loc0_ = this.ToAscii("C");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_ZOOMIN = 34;
        this.mDefineKeyList[this.mDefineKeyList.length] = 34;
        this.mKEY_ZOOMOUT = 33;
        this.mDefineKeyList[this.mDefineKeyList.length] = 33;
        this.mKEY_PAUSE = _loc0_ = this.ToAscii("P");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_INFO = _loc0_ = this.ToAscii("I");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_NEXT = 16;
        this.mDefineKeyList[this.mDefineKeyList.length] = 16;
        this.mKEY_HUD = _loc0_ = this.ToAscii("H");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT1 = _loc0_ = this.ToAscii("1");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT2 = _loc0_ = this.ToAscii("2");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT3 = _loc0_ = this.ToAscii("3");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT4 = _loc0_ = this.ToAscii("4");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT5 = _loc0_ = this.ToAscii("5");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT6 = _loc0_ = this.ToAscii("6");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT7 = _loc0_ = this.ToAscii("7");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT8 = _loc0_ = this.ToAscii("8");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT9 = _loc0_ = this.ToAscii("9");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.mKEY_SELECT0 = _loc0_ = this.ToAscii("0");
        this.mDefineKeyList[this.mDefineKeyList.length] = _loc0_;
        this.ResetKeys();
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
        setInterval(this,"ProcessAllKeys",10);
    }
    function ToAscii(c)
    {
        return c.charCodeAt(0);
    }
    function ResetKeys()
    {
        this.mKey_List = new Array();
        0;
        while(true)
        {
            this.Renew(0);
            1;
        }
    }
    function ProcessAllKeys()
    {
        for(var _loc2_ in this.mDefineKeyList)
        {
            this.ProcessKey(this.mDefineKeyList[_loc2_]);
        }
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
    function ProcessKey(tKeycode)
    {
        if(Key.isDown(tKeycode))
        {
            if(!this.mKey_List[tKeycode].mDown)
            {
                this.mKey_List[tKeycode].mDown = true;
                this.mKey_List[tKeycode].mTimeDown = 4274;
                if(!this.mKey_List[tKeycode].mPressed)
                {
                    this.mKey_List[tKeycode].mPressed = true;
                    this.mKey_List[tKeycode].mTimePressed = 1009;
                }
            }
        }
        else if(this.mKey_List[tKeycode].mDown)
        {
            this.mKey_List[tKeycode].mDown = false;
            this.mKey_List[tKeycode].mReleased = true;
            this.mKey_List[tKeycode].mTimeReleased = 2768;
        }
        return 0;
    }
    function Renew(tKeycode)
    {
        var _loc2_ = {mPressed:false,mTimePressed:0,mDown:false,mTimeDown:0,mReleased:false,mTimeReleased:0};
        return this.mKey_List[tKeycode] = _loc2_;
    }
    function Down(tKeycode)
    {
        return this.mKey_List[tKeycode].mDown;
    }
    function Released(tKeycode)
    {
        if(this.mKey_List[tKeycode].mReleased)
        {
            this.mKey_List[tKeycode].mReleased = false;
            return true;
        }
        return false;
    }
    function Pressed(tKeycode)
    {
        if(this.mKey_List[tKeycode].mPressed)
        {
            this.mKey_List[tKeycode].mPressed = false;
            return true;
        }
        return false;
    }
}
