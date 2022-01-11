class Screen.CScreen_Main extends Screen.CScreen
{
    var _CLASSID_ = "CScreen_Main";
    function CScreen_Main()
    {
        super();
        this.Init_Buttons();
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
    }
    function Process()
    {
        super.Process();
    }
    function Draw()
    {
        super.Draw();
    }
    function Init_Buttons()
    {
        this.Register_Button(this.mcSinglePlay,"State_SelectWorld_Single");
        this.Register_Button(this.mcCoopPlay,"State_SelectWorld_Coop");
        this.Register_Button(this.mcDeathPlay,"State_SelectWorld_DeathMatch");
        this.Register_Button(this.mcInstructions,undefined,"http://www.crazymonkeygames.com/instr/boxhead2play/");
    }
    function Register_Button(mc, nState, dURL)
    {
        mc.pClass = this;
        mc._Contents._alpha = 50;
        mc.nState = nState;
        mc.onRollOver = function()
        {
            this.onEnterFrame = function()
            {
                this._Contents._alpha = 100;
                this._Contents.filters = [new flash.filters.DropShadowFilter(Math.random() * 3,random(360)),new flash.filters.BlurFilter(Math.random() * 2,Math.random() * 2)];
            };
        };
        mc.onRollOut = function()
        {
            this._Contents._alpha = 50;
            delete this.onEnterFrame;
            this._Contents.filters = [];
        };
        if(nState)
        {
            mc.onRelease = function()
            {
                CSound.mSamples.Click.PlaySound();
                this.pClass.nState = this.nState;
            };
        }
        else if(dURL)
        {
            mc.onRelease = function()
            {
                CSound.mSamples.Click2.PlaySound();
                this.getURL(dURL,"_blank");
            };
        }
    }
}
