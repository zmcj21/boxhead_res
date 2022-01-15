class CProjection3D_Axis extends scidd.Draw.F3D.CProjection3D
{
    var _CLASSID_ = "CProjection3D_Axis";
    static var mScreenProjection = true;
    static var _degsToRads = 0.017453292519943295;
    function CProjection3D_Axis(tPitch)
    {
        super();
        this.mType = this.mType_Pushed;
        this.mPitch = tPitch;
        var _loc4_ = Math.cos(tPitch);
        var _loc3_ = Math.sin(tPitch);
        this.mAxisScale = new scidd.Math.CVector3(1,Math.abs(0 * _loc4_ - 1 * _loc3_),Math.abs(1 * _loc4_ + 0 * _loc3_));
        this.mAxisScale.mY = Math.round(this.mAxisScale.mY * 10) / 10;
        this.mAxisScale.mZ = Math.round(this.mAxisScale.mZ * 10) / 10;
    }
    function Project(tMesh, pAngle)
    {
        var _loc5_ = new scidd.Math.CMatrix4();
        _loc5_ = _loc5_.RotateX(pAngle.mX);
        _loc5_ = _loc5_.RotateY(pAngle.mY);
        _loc5_ = _loc5_.RotateZ(pAngle.mZ);
        _loc5_.TransformVectors_NoTranslate(tMesh.mPosition_List,tMesh.mPosition_List_Projected);
        if(CProjection3D_Axis.mScreenProjection)
        {
            for(var _loc6_ in tMesh.mPosition_List)
            {
                var _loc1_ = tMesh.mPosition_List_Projected[_loc6_];
                _loc1_.mSort = 0 - _loc1_.mY + _loc1_.mZ / 100000;
                var _loc2_ = 0 - _loc1_.mZ + _loc1_.mY / 2;
                var _loc3_ = _loc1_.mX;
                _loc1_.mX = _loc3_;
                _loc1_.mY = _loc2_;
            }
        }
        var _loc8_ = _loc5_.Clone().Normalize();
        _loc8_.TransformVectors_NoTranslate(tMesh.mNormal_List,tMesh.mNormal_List_Projected);
    }
    function Project0(tMesh, pAngle)
    {
        var _loc2_ = new scidd.Math.CMatrix4();
        _loc2_ = _loc2_.RotateZ(pAngle.mZ);
        _loc2_.TransformVector_NoTranslate(tMesh.mPosition_List[0],tMesh.mPosition_List_Projected[0]);
        if(CProjection3D_Axis.mScreenProjection)
        {
            var _loc1_ = tMesh.mPosition_List_Projected[0];
            _loc1_.mSort = _loc1_.mY;
            var _loc3_ = 0 - _loc1_.mZ + _loc1_.mY / 2;
            var _loc4_ = _loc1_.mX;
            _loc1_.mX = _loc4_;
            _loc1_.mY = _loc3_;
        }
    }
    function Project_Vector3(tMesh, pAngle, p)
    {
        var _loc1_ = new scidd.Math.CMatrix4();
        _loc1_ = _loc1_.RotateZ(pAngle.mZ);
        var _loc2_ = new scidd.Math.CVector3(0,0,0);
        _loc1_.TransformVector_NoTranslate(p,_loc2_);
        return _loc2_;
    }
    function Project_TEST(tMesh, pAngle, p)
    {
        var _loc2_ = new scidd.Math.CMatrix4();
        _loc2_ = _loc2_.RotateZ(pAngle.mZ);
        var _loc3_ = new scidd.Math.CVector3(0,0,0);
        _loc2_.TransformVector_NoTranslate(p,_loc3_);
        if(CProjection3D_Axis.mScreenProjection)
        {
            var _loc1_ = _loc3_;
            _loc1_.mSort = _loc1_.mY;
            var _loc4_ = 0 - _loc1_.mZ + _loc1_.mY / 2;
            var _loc5_ = _loc1_.mX;
            _loc1_.mX = _loc5_;
            _loc1_.mY = _loc4_;
        }
        return _loc3_;
    }
}
