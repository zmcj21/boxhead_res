class CThing_Animation extends CThing_Move
{
    var fState_Idle = 0;
    var fState_Runaway = 0;
    var PlayerControl = 0;
    var _CLASSID_ = "CThing_Animation";
    var _BASECLASSID_ = "CThing_Animation";
    static var mState_None = 0;
    static var mState_Idle = 1;
    static var mState_Dying = 2;
    static var mState_Dead = 3;
    static var mState_Runaway = 4;
    static var mState_Shoot = 5;
    static var mState_ThrowGrenade = 6;
    static var mState_ExplosionHit = 7;
    static var mState_ShotHit = 8;
    static var mState_Wander_Random = 9;
    static var mState_Wander_Angle = 20;
    static var mState_Wander_Goto = 21;
    static var mState_Wander_Offscreen = 22;
    static var mState_Wander_Goto_Offscreen = 26;
    static var mState_CellToCell_Offscreen = 23;
    static var mState_Wander_EnterWorld = 24;
    static var mState_Wander_Wait = 25;
    static var mState_GotoFinalPosition = 27;
    static var mState_SleepOrDrawn = 28;
    static var mState_WallhugLeft = 10;
    static var mState_WallhugRight = 11;
    static var mState_GotoPosition = 12;
    static var mState_CellToCell = 13;
    static var mState_ZombieHit = 14;
    static var mState_Sleep = 15;
    static var mState_PlayerControl = 16;
    static var mState_WaitForPlayer = 17;
    static var mState_ZombieAttack = 18;
    static var mState_TurnToDirection = 19;
    static var mState_Init = 0;
    static var mDirection_E = 0;
    static var mDirection_SE = 1;
    static var mDirection_S = 2;
    static var mDirection_SW = 3;
    static var mDirection_W = 4;
    static var mDirection_NW = 5;
    static var mDirection_N = 6;
    static var mDirection_NE = 7;
    static var mDirection_Amount = 8;
    static var mRadsToDirection = 6.283185307179586 / CThing_Animation.mDirection_Amount;
    static var mMoveMode_Quick = 0;
    static var mMoveMode_Normal = 1;
    static var mMoveMode_Goto = 2;
    static var mMoveMode_HugLeft = 3;
    static var mMoveMode_HugRight = 4;
    function CThing_Animation(tPosition, tAngle, tID)
    {
        super(tPosition,tAngle,tID);
        this.Move(this.mPosition);
        this.mAffectable = true;
        this.mRadius = 16;
        this.mSpeed = 1;
        this.mOffScreenCount = 0;
        this.mDrawn = true;
        this.mZombieEnemy = false;
        this.mTurnDirection = 0;
        this.mMoveMode = CThing_Animation.mMoveMode_Normal;
    }
    static function Renew()
    {
        CThing_Animation.mDirection_Deltas = [new flash.geom.Point(1,0),new flash.geom.Point(1,1),new flash.geom.Point(0,1),new flash.geom.Point(-1,1),new flash.geom.Point(-1,0),new flash.geom.Point(-1,-1),new flash.geom.Point(0,-1),new flash.geom.Point(1,-1)];
        CThing_Animation.mDirection_Angles = [0,0.7853981633974483,1.5707963267948966,2.356194490192345,3.141592653589793,3.9269908169872414,4.71238898038469,5.497787143782138];
        CThing_Zombie.mSpawnCount = 0;
        CThing_Civilian.mSpawnCount = 0;
        CThing_Player.mValidWeapons = ["pistol"];
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        super.Dispose();
        this.ClearCollideCell();
    }
    function Process()
    {
        this.mOffScreenCount = this.mDrawn != true ? this.mOffScreenCount + 1 : 0;
        if(this.mAffectors.length != 0)
        {
            this.ProcessAffects();
        }
        this.mState_Function();
        this.mDrawn = false;
    }
    function fState_TurnToDirection()
    {
        if(++this.mState_Count % 3 == 0)
        {
            if(this.mDirection == this.mNewDirection)
            {
                this.SetState(this.mState_Base);
                return undefined;
            }
            this.mDirection = this.ValidDirection(this.mDirection + this.mTurnDirection);
            this.mAngle = this.GetDirectionAngle(this.mDirection);
            this.Animate(0);
        }
    }
    function fState_Sleep()
    {
        if(--this.mState_Count < 0)
        {
            this.SetState(this.mState_Base);
        }
    }
    function fState_SleepOrDrawn()
    {
        if(--this.mState_Count < 0 || this.mDrawn)
        {
            this.SetState(this.mState_Base);
        }
    }
    function fState_Init()
    {
        this.SetState(this.mState_Base);
    }
    function fState_PlayerControl()
    {
        this.PlayerControl();
        this.Animate();
    }
    function fState_WaitForPlayer()
    {
        if(++this.mState_Count > 60)
        {
            this.SetState(this.mState_Base);
        }
    }
    function fState_Dying()
    {
        if(this.Animate(0.33))
        {
            this.SetState(CThing_Animation.mState_Dead);
            delete this.mMapColor;
            this.mState_Count = 300;
        }
    }
    function fState_ZombieAttack()
    {
        if(this.Animate(0.2))
        {
            var _loc3_ = this.oMapwho.mMapwho;
            var _loc2_ = _loc3_.GetCellPosition(this.mPosition.mX,this.mPosition.mY);
            var _loc4_ = this.GetDirectionDelta(this.mDirection);
            var _loc5_ = CThing_Affect.Zombie(this,this,100);
            _loc3_.AffectCell(_loc2_.x,_loc2_.y,_loc5_);
            _loc3_.AffectCell(_loc2_.x + _loc4_.x,_loc2_.y + _loc4_.y,_loc5_);
            this.mState_Count = 10;
            this.SetState(CThing_Animation.mState_Sleep);
        }
    }
    function fState_Dead()
    {
        if(this.mState_Count < 100)
        {
            this.mAlpha = this.mState_Count;
            if(this._CLASSID_ == "CThing_Player")
            {
                CScreen_Debriefing.Retry("dead");
            }
        }
        if(--this.mState_Count < 0)
        {
            this.__set__mDelete(true);
        }
    }
    function fState_ThrowGrenade()
    {
        if(this.Animate())
        {
            this.SetState(this.mState_Base);
        }
    }
    function fState_ZombieHit()
    {
        this.fState_ShotHit();
    }
    function fState_ShotHit()
    {
        var _loc2_ = this.mDelta.Clone();
        this.Collide(this.mPosition,_loc2_,CMapwho.mCollide_Solid | CMapwho.mCollide_Dude);
        this.Move(this.mPosition.Add(_loc2_));
        this.mDelta.ScaleN(0.65);
        CCity._this.CreateBloodSpill(this.mPosition);
        if(this.mDelta.__get__mLength() < 0.01)
        {
            if(this.CheckForDead())
            {
                return undefined;
            }
            this.SetState(CThing_Animation.mState_Sleep);
            this.mState_Count = 3;
            this.mDamageSound.PlaySound();
        }
    }
    function fState_ExplosionHit()
    {
        var _loc2_ = this.mDelta.Clone();
        this.Collide(this.mPosition,_loc2_,CMapwho.mCollide_Solid | CMapwho.mCollide_Dude);
        this.Move(this.mPosition.Add(_loc2_));
        this.mDelta.ScaleN(0.65);
        CCity._this.CreateBloodSpill(this.mPosition);
        if(this.mDelta.__get__mLength() < 0.01)
        {
            if(this.CheckForDead())
            {
                return undefined;
            }
            this.SetState(CThing_Animation.mState_Sleep);
            this.mState_Count = 3;
            this.mDamageSound.PlaySound();
        }
    }
    function fState_Wander_Random(nDirection)
    {
        nDirection = this.MoveDirection(this.mPosition.mX,this.mPosition.mY,nDirection);
        if(nDirection != undefined)
        {
            if(this.mDirection != nDirection && this.mDirection != undefined)
            {
                this.mNewDirection = nDirection;
                this.SetState(CThing_Animation.mState_TurnToDirection);
                return undefined;
            }
            this.mDirection = nDirection;
            this.SetCollideDirection(this.mDirection);
            this.SetDeltaAndAngleFromDirection(this.mDirection);
            this.mDelta.ScaleN(this.mSpeed);
            this.mState_TotalCount = this.mState_Count = CMapwho.mCellSize.x / this.mSpeed;
            var _loc3_ = this.oMapwho.mMapwho.CentreOnCell(this.mPosition.Clone()).Subtract(this.mPosition);
            this.mDelta = this.mDelta.Add(_loc3_.ScaleN(1 / this.mState_Count));
            this.SetState(CThing_Animation.mState_CellToCell);
        }
        else
        {
            this.mState_Count = 15 + random(5);
            this.SetState(CThing_Animation.mState_Sleep);
        }
    }
    function fState_Wander_OffScreen(nDirection)
    {
        nDirection = this.MoveDirection(this.mPosition.mX,this.mPosition.mY,nDirection);
        if(nDirection == undefined)
        {
            this.mState_Count = 90;
            this.SetState(CThing_Animation.mState_SleepOrDrawn);
        }
        else
        {
            this.mDirection = nDirection;
            this.SetCollideDirection(this.mDirection);
            this.mState_TotalCount = this.mState_Count = CMapwho.mCellSize.x / this.mSpeed;
            this.SetState(CThing_Animation.mState_CellToCell_Offscreen);
        }
    }
    function fState_Wander_Angle()
    {
        var _loc2_ = this.oMapwho.mMapwho.InFearArea(this.mPosition);
        if(_loc2_ != undefined)
        {
            this.mGotoAnglePosition = new scidd.Math.CPointXYZ(this.mPosition.mX + _loc2_.x * 100,this.mPosition.mY + _loc2_.y * 100,0);
            this.fState_Wander_Random(this.DirectionToPosition(this.mGotoAnglePosition));
            return true;
        }
        if(this.mState == CThing_Animation.mState_Wander_Angle)
        {
            this.SetState(CThing_Animation.mState_Wander_Goto);
        }
    }
    function fState_Wander_Goto()
    {
        this.fState_Wander_Random(this.DirectionToPosition(this.mGotoPosition));
    }
    function fState_GotoFinalPosition()
    {
        this.fState_Wander_Random(this.DirectionToPosition(this.mGotoPosition));
    }
    function fState_Wander_Goto_Offscreen()
    {
        this.fState_Wander_OffScreen(this.DirectionToPosition(this.mGotoPosition));
    }
    function fState_Wander_EnterWorld()
    {
        var _loc3_ = this.oMapwho.mMapwho.GetCellPosition(this.mPosition.mX,this.mPosition.mY);
        0;
        while(0 < CThing_Animation.mDirection_Amount)
        {
            if(!(this.MoveInDirectionFlags(_loc3_,0) & CMapwho.mCollide_Solid))
            {
                this.mDirection = 0;
                this.SetState(CThing_Animation.mState_Wander_Wait);
                return undefined;
            }
            2;
        }
    }
    function fState_Wander_Wait()
    {
        if(++this.mState_Count % 10 == 0)
        {
            var _loc2_ = this.oMapwho.mMapwho.GetCellPosition(this.mPosition.mX,this.mPosition.mY);
            if(!(this.MoveInDirectionFlags(_loc2_,this.mDirection) & (CMapwho.mCollide_Dude | CMapwho.mCollide_Player)))
            {
                this.SetState(!this.mDrawn ? CThing_Animation.mState_Wander_Offscreen : CThing_Animation.mState_Wander_Random);
            }
        }
    }
    function fState_CellToCell()
    {
        if(--this.mState_Count < 0)
        {
            this.SetState(this.mState_Base);
            return undefined;
        }
        this.Move(this.mPosition.Add(this.mDelta));
        this.Animate();
    }
    function fState_CellToCell_Offscreen()
    {
        if(--this.mState_Count < 0 || this.mDrawn)
        {
            this.Move(new scidd.Math.CPointXYZ((this.mNewCellPosition.x + 0.5) * CMapwho.mCellSize.x,(this.mNewCellPosition.y + 0.5) * CMapwho.mCellSize.y,0));
            if(this.mDrawn)
            {
                this.mGotoPosition = CThing.mTrackThing.mPosition;
                this.SetState(CThing_Animation.mState_Wander_Goto);
                return undefined;
            }
            this.SetState(this.mState_Base);
        }
    }
    function CheckForDead()
    {
        if(this.mLife <= 0)
        {
            this.SetState(CThing_Animation.mState_Dying);
            return true;
        }
        return false;
    }
    function RenewState()
    {
        var _loc2_ = this.mState;
        this.mState = CThing_Animation.mState_None;
        this.SetState(_loc2_);
    }
    function SetState(nState)
    {
        if(this.mState == nState)
        {
            return undefined;
        }
        var _loc6_ = this.mState;
        var _loc0_ = null;
        switch(this.mState = nState)
        {
            case CThing_Animation.mState_None:
                break;
            case CThing_Animation.mState_Idle:
                this.mState_Function = this.fState_Idle;
                this.SetAnimation("stand");
                break;
            case CThing_Animation.mState_TurnToDirection:
                this.mState_Function = this.fState_TurnToDirection;
                this.SetAnimation("stand");
                var _loc3_ = Math.abs(this.mNewDirection - this.mDirection) <= 4 ? 1 : -1;
                this.mTurnDirection = this.mNewDirection <= this.mDirection ? 0 - _loc3_ : _loc3_;
                this.mState_Count = 0;
                break;
            case CThing_Animation.mState_PlayerControl:
                this.mState_Function = this.fState_PlayerControl;
                this.mState_Base = this.mState;
                this.SetAnimation("walk");
                break;
            case CThing_Animation.mState_Wander_Wait:
                this.mState_Base = this.mState;
                this.mState_Count = 0;
                this.mState_Function = this.fState_Wander_Wait;
                break;
            case CThing_Animation.mState_Wander_EnterWorld:
                this.mState_Base = this.mState;
                this.fState_Wander_EnterWorld();
                break;
            case CThing_Animation.mState_Wander_Offscreen:
                this.mMoveMode = CThing_Animation.mMoveMode_Quick;
                this.mState_Base = this.mState;
                this.fState_Wander_OffScreen(this.mDirection);
                break;
            case CThing_Animation.mState_Wander_Angle:
                this.mMoveMode = CThing_Animation.mMoveMode_Goto;
                this.mState_Base = this.mState;
                this.fState_Wander_Angle();
                break;
            case CThing_Animation.mState_Wander_Goto:
                if(!this.mDrawn)
                {
                    this.SetState(CThing_Animation.mState_Wander_Goto_Offscreen);
                    return undefined;
                }
                this.mState_Base = this.mState;
                this.mMoveMode = CThing_Animation.mMoveMode_Goto;
                this.fState_Wander_Goto();
                break;
            case CThing_Animation.mState_Wander_Goto_Offscreen:
                this.mState_Base = this.mState;
                this.mMoveMode = CThing_Animation.mMoveMode_Goto;
                this.fState_Wander_Goto_Offscreen();
                break;
            case CThing_Animation.mState_GotoFinalPosition:
                this.mState_Base = this.mState;
                this.mMoveMode = CThing_Animation.mMoveMode_Goto;
                this.mState_Function = this.fState_GotoFinalPosition;
                var _loc5_ = new flash.geom.Point(CCity._this.mCivilianDestinationPosition.mX >> CMapwho.mCellSizeShift,CCity._this.mCivilianDestinationPosition.mY >> CMapwho.mCellSizeShift);
                var _loc4_ = new flash.geom.Point(this.mPosition.mX >> CMapwho.mCellSizeShift,this.mPosition.mY >> CMapwho.mCellSizeShift);
                if(_loc5_.equals(_loc4_))
                {
                    CCity_Level.CivilianOut();
                    this.__set__mDelete(true);
                    CHud.CivilianSaved();
                    return undefined;
                }
                this.SetAnimation("walk");
                break;
            case CThing_Animation.mState_CellToCell:
                this.mState_Function = this.fState_CellToCell;
                this.SetAnimation("walk");
                break;
            case CThing_Animation.mState_CellToCell_Offscreen:
                this.mState_Function = this.fState_CellToCell_Offscreen;
                break;
            case CThing_Animation.mState_Sleep:
                this.mState_Function = this.fState_Sleep;
                this.SetAnimation("stand",0);
                break;
            case CThing_Animation.mState_SleepOrDrawn:
                this.mState_Function = this.fState_SleepOrDrawn;
                this.SetAnimation("stand",0);
                break;
            case CThing_Animation.mState_Dying:
                this.mState_Function = this.fState_Dying;
                this.mZombieEnemy = false;
                this.mDeathSound.PlaySound();
                this.mAffectable = false;
                this.SetAnimation("dying",0);
                switch(this._CLASSID_)
                {
                    case "CThing_Civilian":
                        CHud.CivilianKill();
                        break;
                    case "CThing_Zombie":
                        CHud.ZombieKill();
                }
                break;
            case CThing_Animation.mState_ZombieAttack:
                this.mState_Function = this.fState_ZombieAttack;
                this.SetAnimation("attack");
                this.mDeathSound.PlaySound();
                break;
            case CThing_Animation.mState_Dead:
                this.mState_Function = this.fState_Dead;
                this.SetAnimation("dead",0);
                0;
                while(true)
                {
                    CCity._this.CreateBloodSpill(this.mPosition);
                    1;
                }
                break;
            case CThing_Animation.mState_Runaway:
                this.mState_Function = this.fState_Runaway;
                this.mState_Base = CThing_Animation.mState_Runaway;
                break;
            case CThing_Animation.mState_ThrowGrenade:
                this.mState_Function = this.fState_ThrowGrenade;
                break;
            case CThing_Animation.mState_ZombieHit:
                this.mState_Function = this.fState_ZombieHit;
                this.ClearCollideCell();
                switch(random(2))
                {
                    case 0:
                        this.SetAnimation("shothit_1",0);
                        break;
                    case 1:
                        this.SetAnimation("shothit_2",0);
                }
                CThing.AddThing(new CThing_BloodHit(this.mPosition.Add(new scidd.Math.CPointXYZ(0,0,random(20) + 10)),this.mAngle,this.mID,this));
                break;
            case CThing_Animation.mState_ShotHit:
                this.mState_Function = this.fState_ShotHit;
                this.ClearCollideCell();
                switch(random(2))
                {
                    case 0:
                        this.PlaySound(CSound.mBodyHit1);
                        this.SetAnimation("shothit_1",0);
                        break;
                    case 1:
                        this.PlaySound(CSound.mBodyHit2);
                        this.SetAnimation("shothit_2",0);
                }
                CThing.AddThing(new CThing_BloodHit(this.mPosition.Add(new scidd.Math.CPointXYZ(0,0,random(20) + 10)),this.mAngle,this.mID,this));
                break;
            case CThing_Animation.mState_ExplosionHit:
                this.mState_Function = this.fState_ExplosionHit;
                this.ClearCollideCell();
                switch(random(2))
                {
                    case 0:
                        this.SetAnimation("shothit_1",0);
                        break;
                    case 1:
                        this.SetAnimation("shothit_2",0);
                }
                CThing.AddThing(new CThing_BloodHit(this.mPosition.Add(new scidd.Math.CPointXYZ(0,0,random(20) + 10)),this.mAngle,this.mID,this));
                break;
            default:
                break;
            case CThing_Animation.mState_Wander_Random:
                if(!this.mDrawn)
                {
                    this.SetState(CThing_Animation.mState_Wander_Offscreen);
                    return undefined;
                }
                this.mGotoPosition = CThing.mTrackThing.mPosition;
                this.SetState(CThing_Animation.mState_Wander_Goto);
                return undefined;
        }
    }
    function Collide(p, d, collideFlags)
    {
        var _loc2_ = this.oMapwho.mMapwho;
        var _loc3_ = _loc2_.GetCellPosition(p.mX + scidd.Math.CMath.Sign(d.mX) * this.mRadius,p.mY + scidd.Math.CMath.Sign(d.mY) * this.mRadius);
        var _loc5_ = _loc2_.GetCellPosition(p.mX,p.mY);
        var _loc7_ = _loc2_.QCollide(_loc3_.x,_loc5_.y);
        var _loc8_ = _loc2_.QCollide(_loc5_.x,_loc3_.y);
        var _loc10_ = _loc2_.QCollide(_loc3_.x,_loc3_.y);
        if(_loc7_ & collideFlags)
        {
            d.mX = 0;
        }
        if(_loc8_ & collideFlags)
        {
            d.mY = 0;
        }
        return d;
    }
    function SetAnimation(tAnim, fIndex)
    {
        CMain._this.mAnimation.SetAnimation(this.mAnimationObject,tAnim,fIndex,this.mAngle);
    }
    function Animate(tTick)
    {
        return CMain._this.mAnimation.Animate(this.mAnimationObject,tTick != undefined ? tTick : 0.125,this.mAngle);
    }
    function ProcessAffects()
    {
        for(var _loc6_ in this.mAffectors)
        {
            var _loc2_ = this.mAffectors[_loc6_];
            switch(_loc2_.mType)
            {
                case CThing_Affect.mType_Bullet:
                    this.mLife -= _loc2_.mDamage;
                    this.SetState(CThing_Animation.mState_ShotHit);
                    this.mState_Count = Math.round(_loc2_.mDamage / 5 * 2);
                    this.mDelta = this.mPosition.Subtract(_loc2_.mAffector.mPosition).Normalize(Math.max(_loc2_.mDamage / 5 * 2,10));
                    this.mDelta.mZ = 0;
                    this.mAngle = this.mDelta.toAngleZ() + 3.141592653589793;
                    break;
                case CThing_Affect.mType_Zombie:
                    this.mLife -= _loc2_.mDamage;
                    this.SetState(CThing_Animation.mState_ZombieHit);
                    this.mState_Count = Math.round(_loc2_.mDamage / 5);
                    this.mDelta = this.mPosition.Subtract(_loc2_.mAffector.mPosition).Normalize(Math.max(_loc2_.mDamage / 5,10));
                    this.mDelta.mZ = 0;
                    this.mAngle = this.mDelta.toAngleZ() + 3.141592653589793;
                    break;
                case CThing_Affect.mType_Explosion:
                    var _loc5_ = Math.min(_loc2_.mRange,this.mPosition.Sub(_loc2_.mAffector.mPosition).__get__mLength());
                    var _loc4_ = 1 - _loc5_ / _loc2_.mRange;
                    if(_loc4_ < 0.1)
                    {
                        break;
                    }
                    var _loc3_ = _loc2_.mDamage * _loc4_;
                    this.mLife -= _loc3_;
                    this.SetState(CThing_Animation.mState_ExplosionHit);
                    this.mDelta = this.mPosition.Subtract(_loc2_.mAffector.mPosition).Normalize(Math.min(_loc3_ / 10,10));
                    this.mDelta.mZ = 0;
                    this.mAngle = this.mDelta.toAngleZ() + 3.141592653589793;
                    break;
            }
        }
        this.mAffectors = new Array();
    }
    function Draw()
    {
        this.mDrawn = true;
        if(this._cacheDraw_dBMD == undefined)
        {
            this._cacheDraw_dp = CCity.mDrawPosition;
            this._cacheDraw_dBMD = CCity._this.bmRenderPlane;
            this._cacheDraw_pos = new flash.geom.Point();
        }
        var _loc2_ = this.mAnimationObject.mCurrent;
        this._cacheDraw_pos.x = this.mPosition.mX - this._cacheDraw_dp.x + _loc2_.mDisp.x;
        this._cacheDraw_pos.y = this.mPosition.mY - this.mPosition.mZ - this._cacheDraw_dp.y + _loc2_.mDisp.y;
        if(this.mAlpha == undefined)
        {
            this._cacheDraw_dBMD.copyPixels(_loc2_.sBMD,_loc2_.sBMD.rectangle,this._cacheDraw_pos,undefined,undefined,true);
        }
        else
        {
            this._cacheDraw_dBMD.draw(_loc2_.sBMD,new flash.geom.Matrix(1,0,0,1,this._cacheDraw_pos.x,this._cacheDraw_pos.y),new flash.geom.ColorTransform(1,1,1,this.mAlpha / 100,0,0,0,0));
        }
    }
    function MoveDirection(px, py, tDirection)
    {
        var _loc4_ = this.oMapwho.mMapwho.GetCellPosition(px,py);
        switch(this.mMoveMode)
        {
            case CThing_Animation.mMoveMode_Quick:
            case CThing_Animation.mMoveMode_Normal:
                var _loc6_ = random(20) != 0 ? this.MoveInDirectionFlags(_loc4_,tDirection) : CMapwho.mCollide_Solid;
                if(!_loc6_)
                {
                    return tDirection;
                }
                1;
                var _loc3_ = random(2) * 2 - 1;
                while(1 < CThing_Animation.mDirection_Amount)
                {
                    if(!this.MoveInDirectionFlags(_loc4_,tDirection + _loc3_ * 1))
                    {
                        return this.ValidDirection(tDirection + _loc3_ * 1);
                    }
                    2;
                }
                break;
            case CThing_Animation.mMoveMode_Goto:
                _loc6_ = this.MoveInDirectionFlags(_loc4_,tDirection);
                if(!_loc6_)
                {
                    return tDirection;
                }
                if(_loc6_ & CMapwho.mCollide_Dude && this.mWaitToMoveCount == undefined)
                {
                    this.mWaitToMoveCount = 1;
                    return undefined;
                }
                delete this.mWaitToMoveCount;
                var _loc7_ = Math.abs(tDirection - this.mDirection) <= 4 ? 1 : -1;
                _loc3_ = tDirection <= this.mDirection ? 0 - _loc7_ : _loc7_;
                if(this.mDirection != tDirection)
                {
                    if(!this.MoveInDirectionFlags(_loc4_,this.mDirection))
                    {
                        return this.ValidDirection(this.mDirection);
                    }
                }
                if(this.mDirection & 1)
                {
                    1;
                    while(true)
                    {
                        if(!this.MoveInDirectionFlags(_loc4_,this.mDirection + _loc3_ * 1))
                        {
                            return this.ValidDirection(this.mDirection + _loc3_ * 1);
                        }
                        if(!this.MoveInDirectionFlags(_loc4_,this.mDirection - _loc3_ * 1))
                        {
                            return this.ValidDirection(this.mDirection - _loc3_ * 1);
                        }
                        2;
                    }
                }
                else
                {
                    if(!this.MoveInDirectionFlags(_loc4_,this.mDirection + _loc3_ * 2))
                    {
                        return this.ValidDirection(this.mDirection + _loc3_ * 2);
                    }
                    if(!this.MoveInDirectionFlags(_loc4_,this.mDirection - _loc3_ * 2))
                    {
                        return this.ValidDirection(this.mDirection - _loc3_ * 2);
                    }
                }
                if(!this.MoveInDirectionFlags(_loc4_,this.mDirection - CThing_Animation.mDirection_Amount / 2))
                {
                    return this.ValidDirection(this.mDirection - CThing_Animation.mDirection_Amount / 2);
                }
                break;
            case CThing_Animation.mMoveMode_HugLeft:
            case CThing_Animation.mMoveMode_HugRight:
        }
        return undefined;
    }
    function QuickMoveDirection(px, py, tDirection)
    {
        var _loc2_ = random(20) != 0 ? this.MoveInDirectionFlags(this.oMapwho.mMapwho.GetCellPosition(px,py),tDirection) : CMapwho.mCollide_Solid;
        if(!_loc2_)
        {
            return tDirection;
        }
        this.mDirection = this.ValidDirection(this.mDirection + random(2) * 2 - 1);
        return undefined;
    }
    function SetCollideDirection(tDirection)
    {
        var _loc2_ = this.oMapwho.mMapwho;
        this.ClearCollideCell();
        this.mNewCellPosition = _loc2_.GetCellPosition(this.mPosition.mX,this.mPosition.mY).add(this.GetDirectionDelta(tDirection));
        _loc2_.SetCollideFlags(this.mNewCellPosition.x,this.mNewCellPosition.y,CMapwho.mCollide_Dude);
    }
    function ClearCollideCell()
    {
        if(this.mNewCellPosition == undefined)
        {
            return undefined;
        }
        this.oMapwho.mMapwho.ClearCollideFlags(this.mNewCellPosition.x,this.mNewCellPosition.y,CMapwho.mCollide_Dude);
        delete this.mNewCellPosition;
    }
    function MoveInDirectionFlags(p, tDirection)
    {
        tDirection = this.ValidDirection(tDirection);
        var _loc2_ = this.GetDirectionDelta(tDirection);
        var _loc4_ = this.oMapwho.mMapwho;
        return !(tDirection & 1) ? _loc4_.QCollide(p.x + _loc2_.x,p.y + _loc2_.y) : _loc4_.QCollide(p.x + _loc2_.x,p.y) | _loc4_.QCollide(p.x,p.y + _loc2_.y) | _loc4_.QCollide(p.x + _loc2_.x,p.y + _loc2_.y);
    }
    function SetDeltaAndAngleFromDirection(tDirection)
    {
        tDirection = this.ValidDirection(tDirection);
        this.mDelta = new scidd.Math.CPointXYZ(CThing_Animation.mDirection_Deltas[tDirection].x,CThing_Animation.mDirection_Deltas[tDirection].y,0);
        this.mAngle = CThing_Animation.mDirection_Angles[tDirection];
    }
    function GetDirectionDelta(tDirection)
    {
        return CThing_Animation.mDirection_Deltas[tDirection];
    }
    function GetDirectionAngle(tDirection)
    {
        return CThing_Animation.mDirection_Angles[tDirection];
    }
    function ValidDirection(tDirection)
    {
        return CThing_Animation.mDirection_Amount + tDirection & CThing_Animation.mDirection_Amount - 1;
    }
    function RandomDirection()
    {
        this.mDirection = random(CThing_Animation.mDirection_Amount);
    }
    function AngleToDirection(tAngle)
    {
        return this.ValidDirection(Math.round(tAngle / CThing_Animation.mRadsToDirection));
    }
    function DirectionToPosition(tPosition)
    {
        return this.ValidDirection(Math.round(Math.atan2(tPosition.mY - this.mPosition.mY,tPosition.mX - this.mPosition.mX) / CThing_Animation.mRadsToDirection));
    }
    function GetDirectionFromDelta(d)
    {
        var _loc2_ = Math.atan2(d.mY,d.mX);
        return this.ValidDirection(Math.floor(_loc2_ / CThing_Animation.mRadsToDirection));
    }
}
