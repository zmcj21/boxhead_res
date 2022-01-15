class World.Init.CWorld_Init_Piece extends World.Init.CWorld_Init
{
    var _CLASSID_ = "CWorld_Init_Piece";
    function CWorld_Init_Piece()
    {
        super();
    }
    function Draw()
    {
        var _loc2_ = this.__get__mPosition();
        var _loc3_ = new flash.geom.Matrix(1,0,0,1,_loc2_.mX,_loc2_.mY);
        this.mWorld.bmFloor.draw(this,_loc3_);
        this.mWorld.bmDecalMask.draw(this,_loc3_);
        _loc2_ = this.GetPosition(this._Cover);
        _loc3_ = new flash.geom.Matrix(1,0,0,1,_loc2_.mX,_loc2_.mY);
        this.mWorld.bmCover.draw(this._Cover,_loc3_);
    }
}
