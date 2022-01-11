class World.CWorld extends MovieClip
{
    var CleanUp_PlayerPlane = 0;
    var DrawCircle = 0;
    var _CLASSID_ = "CWorld";
    var _BASECLASSID_ = "CWorld";
    static var zPoint = new flash.geom.Point(0,0);
    static var zMatrix = new flash.geom.Matrix();
    static var m2Player = false;
    static var mSpawnDist_Min = 4;
    static var mNumberOfGameKills = [5,10,20,50];
    var mAmbienceTicker = 0;
    var mZombieSampleIndex = 0;
    var mZombie_DrawCount = 0;
    var mZombie_NumberOfSounds = 4;
    function CWorld()
    {
        super();
        Thing.Math.CThing_Angle.Create_LookupTables();
        scidd.Math.CRandom.SetSeed(0);
        this._visible = false;
        this.mcRoomData = this.attachMovie(this.mWorldLibLink,"_RoomData",this.getNextHighestDepth());
        if(this.mcRoomData)
        {
            this.onEnterFrame = this.Init;
            return undefined;
        }
        this.onEnterFrame = this.InitFinished;
        this.mCompleteState = "error";
    }
    function Pad0(s)
    {
        while(s.length < 4)
        {
            s = "0" + s;
        }
        return s;
    }
    function toString()
    {
        return this._CLASSID_;
    }
    function Dispose()
    {
        this.mHud.Dispose();
        this.mMap.Dispose();
        this.bmFloor.dispose();
        this.bmDecalMask.dispose();
        this.bmCover.dispose();
        this.bmDraw.dispose();
        CSaveData.QualityActive(false);
    }
    function Init()
    {
        if(this.mInitList == undefined)
        {
            return undefined;
        }
        this.mScreenSize = new flash.geom.Point(this._Size._width,this._Size._height);
        this.mArea = new flash.geom.Rectangle(0,0,this.mcRoomData._Size._width,this.mcRoomData._Size._height);
        this.mMap = new World.Map.CMap(this);
        this.mUpgrades = new World.CUpgrades(this);
        this.mShake = new flash.geom.Point(0,0);
        this.mBrightness = 1;
        this.mPaused = true;
        this.mTick = 0;
        this.mDrawPosition = World.CWorld.zPoint.clone();
        this.onEnterFrame = this.InitDrawPlanes;
    }
    function InitDrawPlanes()
    {
        this.bmFloor = new flash.display.BitmapData(this.mArea.width,this.mArea.height,false,4294901760);
        this.bmDecalMask = new flash.display.BitmapData(this.mArea.width,this.mArea.height,true,0);
        this.bmCover = new flash.display.BitmapData(this.mArea.width,this.mArea.height,true,65280);
        this.bmFloor.draw(this.mcRoomData,World.CWorld.zMatrix,undefined,"normal",undefined,true);
        this.bmDraw = new flash.display.BitmapData(this.mScreenSize.x,this.mScreenSize.y,World.CWorld.mGameMode != "DeathMatch",4278190335);
        this.attachBitmap(this.bmDraw,this.getNextHighestDepth(),"always",false);
        this.mcScratch = this.createEmptyMovieClip("_00004",this.getNextHighestDepth());
        this.mcScratch._visible = false;
        this.mHud = new World.CHud(this);
        if(World.CWorld.mGameMode == "DeathMatch")
        {
            this.mSplitScreen = new Object();
            this.mSplitScreen.mScreenSize = new flash.geom.Point(480,480);
            this.mSplitScreen.mScalar = this.mScreenSize.x / 2 / this.mSplitScreen.mScreenSize.x;
            var _loc2_ = (this.mScreenSize.y - this.mSplitScreen.mScreenSize.y * this.mSplitScreen.mScalar) / 2;
            this.mSplitScreen.mOffsets = [new flash.geom.Point(0,_loc2_),new flash.geom.Point(this.mSplitScreen.mScreenSize.x * this.mSplitScreen.mScalar,_loc2_)];
            this.mSplitScreen.bmDraw = new flash.display.BitmapData(this.mSplitScreen.mScreenSize.x,this.mSplitScreen.mScreenSize.y,true,4278190335);
            this.mSplitScreen.mMatrix = new flash.geom.Matrix();
            this.mSplitScreen.mMatrix.scale(this.mSplitScreen.mScalar,this.mSplitScreen.mScalar);
        }
        this.onEnterFrame = this.InitThings;
    }
    function InitThings()
    {
        Thing.CThing.DummyThings();
        this.mThing_Collection = new Thing.CThing_Collection(this);
        0;
        var _loc6_ = this.mInitList.length;
        while(0 < _loc6_)
        {
            var _loc3_ = this.mInitList[0];
            var _loc2_ = _loc3_.mPosition.ConvertScreenToCell();
            var _loc7_ = _loc3_.mPosition2.ConvertScreenToCell();
            var _loc5_ = _loc3_.mAngle;
            switch(_loc3_._CLASSID_)
            {
                case "CWorld_Init_CollisionSolid":
                    this.mMap.mCollide.MarkArea_PP(_loc2_.Round(),_loc7_.Round(),World.Map.CMap_Cell.mCollide_Solid);
                    break;
                case "CWorld_Init_Barrel":
                    this.mThing_Collection.AddThing(new Thing.Object.CThing_Object_Barrel(_loc2_.CellCentre()));
                    break;
                case "CWorld_Init_Wall":
                    this.mThing_Collection.AddThing(new Thing.Object.CThing_Object_Wall(_loc2_.CellCentre()));
                    break;
                case "CWorld_Init_Zombie":
                    this.AddSpawnPoint_Zombie(_loc2_.CellCentre());
                    break;
                case "CWorld_Init_Devil":
                    this.AddSpawnPoint_Devil(_loc2_.CellCentre());
                    break;
                case "CWorld_Init_Player1":
                    this.AddSpawnPoint_Player(_loc2_.CellCentre(),_loc5_,true);
                    break;
                case "CWorld_Init_Player2":
                    this.AddSpawnPoint_Player(_loc2_.CellCentre(),_loc5_,false);
                    break;
                case "CWorld_Init_Pickup":
                    this.mThing_Collection.AddThing(new Thing.Object.CThing_Object_Pickup(_loc2_));
                    break;
                case "CWorld_Init_Piece":
                    _loc3_.Draw();
            }
            1;
        }
        DrawPrimitive.CDrawPrimitive.InvertAlpha(this.bmDecalMask);
        this.Spawn_ValidateAll();
        this.Spawn_Player_0();
        if(World.CWorld.mGameMode != "Single")
        {
            this.Spawn_Player_Other(1);
        }
        this.mTrackPositions = new Array();
        this.onEnterFrame = this.InitCleanUp;
    }
    function InitCleanUp()
    {
        DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.RenderStack_Process(8910,2000);
        if(!DrawPrimitive.XSI.CDrawPrimitive_XSI_DI.RenderStack_Finished())
        {
            return undefined;
        }
        this.mcRoomData.removeMovieClip();
        this._visible = true;
        this.mPaused = false;
        CSaveData.QualityActive(true);
        this.Process();
        this.Draw();
        this.mUpgrades.SetDifficulty(CMain.mSaveData.__get__mDifficulty());
        if(World.CWorld.mGameMode == "DeathMatch")
        {
            for(var _loc2_ in this.mThing_Collection.mPlayerThings)
            {
                this.mThing_Collection.mPlayerThings[_loc2_].ResetWeapons();
            }
        }
        this.onEnterFrame = this.InitFinished;
    }
    function InitFinished()
    {
        this.mLoaded = true;
        delete this.onEnterFrame;
    }
    function Process()
    {
        if(CMain.mInput.KEY_PAUSE.IsPressed())
        {
            this.mPaused = this.mPaused != true ? true : false;
            this.mHud.Pause(this.mPaused);
        }
        if(this.mPaused)
        {
            return undefined;
        }
        this.mThing_Collection.Process();
        this.mUpgrades.Process();
        this.mHud.Process();
        this.mTick++;
    }
    function Draw()
    {
        if(this.mPaused)
        {
            return undefined;
        }
        this.Process_Shake();
        if(World.CWorld.mGameMode == "DeathMatch")
        {
            var _loc5_ = this.mSplitScreen.mMatrix;
            var _loc9_ = CMain.mSaveData.__get__mViewSide_DeathMatch();
            var _loc8_ = (CMain.mSaveData.__get__mViewSide_DeathMatch() + 1) % 2;
            this.bmDraw.fillRect(this.bmDraw.rectangle,0);
            this.Draw_PlayerPlane(0,this.mSplitScreen.bmDraw);
            _loc5_.tx = this.mSplitScreen.mOffsets[_loc9_].x - (_loc9_ != 0 ? 0 : 1);
            _loc5_.ty = this.mSplitScreen.mOffsets[_loc9_].y;
            this.mHud.UpdatePlayer(this.mTrackPositions[0],_loc5_.transformPoint(this.GetScreenPosition(this.mTrackPositions[0].mPosition)),this.mSplitScreen.mScalar);
            this.bmDraw.draw(this.mSplitScreen.bmDraw,_loc5_,undefined,"normal",undefined,_root._quality != "LOW");
            this.Draw_PlayerPlane(1,this.mSplitScreen.bmDraw);
            _loc5_.tx = this.mSplitScreen.mOffsets[_loc8_].x - (_loc8_ != 0 ? 0 : 1);
            _loc5_.ty = this.mSplitScreen.mOffsets[_loc8_].y;
            this.mHud.UpdatePlayer(this.mTrackPositions[1],_loc5_.transformPoint(this.GetScreenPosition(this.mTrackPositions[1].mPosition)),this.mSplitScreen.mScalar);
            this.bmDraw.draw(this.mSplitScreen.bmDraw,_loc5_,undefined,"normal",undefined,_root._quality != "LOW");
            this.CleanUp_PlayerPlane();
        }
        else
        {
            for(var _loc6_ in this.mThing_Collection.mPlayerThings)
            {
                var _loc3_ = this.mThing_Collection.mPlayerThings[_loc6_];
                this.mHud.UpdatePlayer(_loc3_,this.GetScreenPosition(_loc3_.mPosition));
            }
            this.Draw_PlayerPlane(undefined,this.bmDraw);
        }
        if(_root._quality != "LOW")
        {
            var _loc4_ = this.Process_Brightness();
            for(var _loc7_ in _loc4_)
            {
                this.bmDraw.applyFilter(this.bmDraw,this.bmDraw.rectangle,World.CWorld.zPoint,_loc4_[_loc7_]);
            }
        }
        this.mHud.Draw(this.bmDraw);
        this.mScreenSizeHalf = this.mScreenSize.clone();
        this.mScreenSizeHalf.x /= 2;
        this.mScreenSizeHalf.y /= 2;
        this.mScreenCentre = this.mScreenSizeHalf.clone();
        this.ProcessAmbience();
        this.mTrackPosition = undefined;
    }
    function Draw_PlayerPlane(tIndex, t_bmDraw)
    {
        var _loc3_ = this.Process_Tracking(tIndex);
        var _loc2_ = World.CWorld.zPoint.subtract(_loc3_.topLeft.add(this.mShake));
        _loc2_.x = Math.round(_loc2_.x);
        _loc2_.y = Math.round(_loc2_.y);
        var _loc4_ = _loc3_.clone();
        _loc4_.x = 0 - _loc2_.x;
        _loc4_.y = 0 - _loc2_.y;
        t_bmDraw.copyPixels(this.bmFloor,_loc4_,World.CWorld.zPoint,undefined,undefined,false);
        this.mDrawPosition.x = _loc3_.x + this.mShake.x;
        this.mDrawPosition.y = _loc3_.y + this.mShake.y;
        DrawPrimitive.XSI.CDrawPrimitive_XSI.bmDraw = t_bmDraw;
        this.bmCurrentDraw = t_bmDraw;
        this.mMap.Draw(_loc3_);
        this.RenderMCToDraw(this.mcScratch,t_bmDraw);
        t_bmDraw.copyPixels(this.bmCover,_loc4_,World.CWorld.zPoint,undefined,undefined,true);
    }
    function RenderMCToDraw(mc, t_bmDraw)
    {
        var _loc1_ = mc.getBounds(mc);
        t_bmDraw.draw(mc,World.CWorld.zMatrix,undefined,"normal",new flash.geom.Rectangle(_loc1_.xMin,_loc1_.yMin,_loc1_.xMax - _loc1_.xMin,_loc1_.yMax - _loc1_.yMin),true);
        mc.clear();
    }
    function Process_Tracking(tIndex, bmSize)
    {
        if(tIndex == undefined)
        {
            var _loc5_ = this.mTrackPosition;
            if(_loc5_)
            {
                if(this.lTrackPosition)
                {
                    var _loc6_ = this.lTrackPosition.Distance2D(_loc5_);
                    0.16;
                    if(_loc6_ > 0.16)
                    {
                        var _loc8_ = (_loc6_ - 0.16) / 5 + 1;
                        var _loc7_ = _loc5_.Subtract(this.lTrackPosition).Normalize(0.16 * _loc8_);
                        _loc5_ = this.lTrackPosition.Add(_loc7_);
                    }
                }
            }
            else
            {
                _loc5_ = this.lTrackPosition;
            }
            var _loc2_ = new flash.geom.Rectangle(0,0,this.mScreenSize.x,this.mScreenSize.y);
        }
        else
        {
            _loc5_ = this.mTrackPositions[tIndex].mPosition;
            _loc2_ = new flash.geom.Rectangle(0,0,this.mSplitScreen.mScreenSize.x,this.mSplitScreen.mScreenSize.y);
        }
        var _loc3_ = _loc5_.ConvertCellToScreen();
        if(isNaN(_loc3_.x))
        {
            _loc3_ = new flash.geom.Point(0,0);
        }
        _loc2_.x = scidd.Math.CMath.Range(Math.round(_loc3_.x - _loc2_.width / 2),World.Map.CMap_Cell.mSize.x,this.mArea.width - (_loc2_.width + World.Map.CMap_Cell.mSize.x));
        _loc2_.y = scidd.Math.CMath.Range(Math.round(_loc3_.y - _loc2_.height / 2),World.Map.CMap_Cell.mSize.y,this.mArea.height - (_loc2_.height + World.Map.CMap_Cell.mSize.y));
        this.lTrackPosition = _loc5_;
        return _loc2_;
    }
    function TrackThing(tThing)
    {
        this.mTrackPosition = this.mTrackPosition != undefined ? this.mTrackPosition.Add(tThing.mPosition).ScaleN(0.5) : tThing.mPosition.Clone();
        this.mTrackPositions[tThing.mPlayerIndex] = tThing;
    }
    function GetScreenPosition(p)
    {
        return p.ConvertCellToScreen().subtract(this.mDrawPosition);
    }
    function Shake(tShake)
    {
        if(this.mShake.length < 32)
        {
            this.mShake = this.mShake.add(tShake);
        }
    }
    function Process_Shake()
    {
        this.mShake.x = (0 - this.mShake.x) * 0.5;
        this.mShake.y = (0 - this.mShake.y) * 0.5;
        if(this.mShake.length < 0.1)
        {
            this.mShake.x = 0;
            this.mShake.y = 0;
        }
    }
    function Process_Brightness()
    {
        if(this.mBrightness != 0)
        {
            this.mBrightness -= 0.2 * scidd.Math.CMath.Sign(this.mBrightness);
            if(Math.abs(this.mBrightness) < 0.2)
            {
                this.mBrightness = 0;
                return [];
            }
            return [scidd.Draw.CColor.GetColorMatrixFilter(scidd.Draw.CColor.ColorMatrix_Brightness(this.mBrightness))];
        }
        return [];
    }
    function AddInitObject(tInitClass)
    {
        tInitClass._visible = false;
        this.mInitList = this.mInitList != undefined ? this.mInitList : new Array();
        this.mInitList.push(tInitClass);
    }
    function AddSpawnPoint_Zombie(p)
    {
        this.mSpawnPoint_Zombie = this.mSpawnPoint_Zombie != undefined ? this.mSpawnPoint_Zombie : new Array();
        this.mSpawnPoint_Zombie.push({mPosition:p,mCell:this.mMap.GetCell(p.mX,p.mY)});
    }
    function AddSpawnPoint_Player(p, a, mFirst)
    {
        var _loc2_ = {mAngle:a,mPosition:p,mCell:this.mMap.GetCell(p.mX,p.mY)};
        if(mFirst)
        {
            this.mSpawnPoint_PlayerStart = _loc2_;
        }
        this.mSpawnPoint_Player = this.mSpawnPoint_Player != undefined ? this.mSpawnPoint_Player : new Array();
        this.mSpawnPoint_Player.push(_loc2_);
    }
    function AddSpawnPoint_Devil(p)
    {
        this.mSpawnPoint_Devil = this.mSpawnPoint_Devil != undefined ? this.mSpawnPoint_Devil : new Array();
        this.mSpawnPoint_Devil.push({mPosition:p,mCell:this.mMap.GetCell(p.mX,p.mY)});
    }
    function AddSpawnPoint_Pickup(p)
    {
        this.mSpawnPoint_Pickup = this.mSpawnPoint_Pickup != undefined ? this.mSpawnPoint_Pickup : new Array();
        this.mSpawnPoint_Pickup.push({mPosition:p,mCell:this.mMap.GetCell(p.mX,p.mY)});
    }
    function Spawn_ValidateAll()
    {
        var _loc4_ = [this.mSpawnPoint_Zombie,this.mSpawnPoint_Devil];
        for(var _loc6_ in _loc4_)
        {
            var _loc3_ = _loc4_[_loc6_];
            for(var _loc5_ in _loc3_)
            {
                var _loc2_ = _loc3_[_loc5_];
                _loc2_.mNextCell = _loc2_.mCell.ValidMoveDirection();
                if(_loc2_.mNextCell == undefined)
                {
                    _loc3_.splice(_loc5_,1);
                }
            }
        }
    }
    function Spawn_ValidPosition(tList)
    {
        var _loc5_ = undefined;
        var _loc3_ = random(tList.length);
        var _loc2_ = tList.length;
        while(_loc2_)
        {
            var _loc1_ = tList[_loc3_];
            if(!((_loc1_.mCell.mCollide | _loc1_.mNextCell.mCollide) & World.Map.CMap_Cell.mCollide_NoSpawn))
            {
                return _loc1_;
            }
            _loc2_ = _loc2_ - 1;
            _loc3_ = (_loc3_ = _loc3_ + 1) % tList.length;
        }
        return undefined;
    }
    function Spawn_ValidPosition_NonStrict(tList)
    {
        var _loc5_ = undefined;
        var _loc3_ = random(tList.length);
        var _loc2_ = tList.length;
        while(_loc2_)
        {
            var _loc1_ = tList[_loc3_];
            if(!((_loc1_.mCell.mCollide | _loc1_.mNextCell.mCollide) & World.Map.CMap_Cell.mCollide_Creature))
            {
                return _loc1_;
            }
            _loc2_ = _loc2_ - 1;
            _loc3_ = (_loc3_ = _loc3_ + 1) % tList.length;
        }
        return undefined;
    }
    function Spawn_ValidPosition_Close(tList, p)
    {
        var _loc5_ = random(tList.length);
        1.7976931348623157e+308;
        var _loc9_ = undefined;
        var _loc4_ = tList.length;
        while(_loc4_)
        {
            var _loc2_ = tList[_loc5_];
            if(!(_loc2_.mCell.mCollide & (World.Map.CMap_Cell.mCollide_NoSpawn | World.Map.CMap_Cell.mCollide_Player)))
            {
                var _loc3_ = _loc2_.mPosition.Distance_SQR(p);
                if(_loc3_ < 1.7976931348623157e+308 && _loc3_ >= World.CWorld.mSpawnDist_Min && this.Spawn_ValidPosition_WithinPlayerScope(p,_loc2_.mPosition))
                {
                    _loc7_ = _loc3_;
                    _loc9_ = _loc2_;
                }
            }
            _loc4_ = _loc4_ - 1;
            _loc5_ = (_loc5_ = _loc5_ + 1) % tList.length;
        }
        if(_loc9_)
        {
        }
        return _loc9_;
    }
    function Spawn_ValidPosition_Far(tList, p)
    {
        var _loc5_ = random(tList.length);
        0;
        var _loc9_ = undefined;
        var _loc4_ = tList.length;
        while(_loc4_)
        {
            var _loc2_ = tList[_loc5_];
            if(!(_loc2_.mCell.mCollide & (World.Map.CMap_Cell.mCollide_NoSpawn | World.Map.CMap_Cell.mCollide_Player)))
            {
                var _loc3_ = _loc2_.mPosition.Distance_SQR(p);
                if(_loc3_ >= 0 && this.Spawn_ValidPosition_WithinPlayerScope(p,_loc2_.mPosition))
                {
                    _loc7_ = _loc3_;
                    _loc9_ = _loc2_;
                }
            }
            _loc4_ = _loc4_ - 1;
            _loc5_ = (_loc5_ = _loc5_ + 1) % tList.length;
        }
        if(_loc9_)
        {
        }
        return _loc9_;
    }
    function Spawn_ValidPosition_WithinPlayerScope(p1, p2)
    {
        return !(Math.abs(p1.mX - p2.mX) > 19 || Math.abs(p1.mY - p2.mY) > 13);
    }
    function Spawn_Zombie()
    {
        var _loc2_ = this.Spawn_ValidPosition(this.mSpawnPoint_Zombie);
        if(_loc2_)
        {
            this.mUpgrades.__set__mZombieCount(this.mUpgrades.__get__mZombieCount() + 1);
            var _loc3_ = this.mThing_Collection.AddThing(new Thing.Creature.CThing_Creature_Zombie(_loc2_.mPosition.Clone()));
            return true;
        }
        return false;
    }
    function Spawn_Devil()
    {
        var _loc2_ = this.Spawn_ValidPosition_NonStrict(this.mSpawnPoint_Devil);
        if(_loc2_)
        {
            this.mUpgrades.__set__mDevilCount(this.mUpgrades.__get__mDevilCount() + 1);
            var _loc3_ = this.mThing_Collection.AddThing(new Thing.Creature.CThing_Creature_Devil(_loc2_.mPosition.Clone()));
            return true;
        }
        return false;
    }
    function Spawn_Player_0()
    {
        this._Spawn_Player(0,!this.mSpawnPoint_PlayerStart ? this.Spawn_ValidPosition(this.mSpawnPoint_Player) : this.mSpawnPoint_PlayerStart);
    }
    function Spawn_Player_Other(tIndex)
    {
        return this._Spawn_Player(tIndex,this.Spawn_Player_PositionObject());
    }
    function Spawn_Player_PositionObject(cPlayer)
    {
        cPlayer = cPlayer != undefined ? cPlayer : this.mThing_Collection.GetClosestPlayer();
        if(World.CWorld.mGameMode == "Coop")
        {
            return this.Spawn_ValidPosition_Close(this.mSpawnPoint_Player,cPlayer.mPosition);
        }
        return this.Spawn_ValidPosition_Far(this.mSpawnPoint_Player,cPlayer.mPosition);
    }
    function _Spawn_Player(tIndex, sObject)
    {
        if(sObject == undefined)
        {
            return false;
        }
        var _loc3_ = sObject.mPosition.Clone();
        this.mUpgrades.__set__mTotalPlayerCount(this.mUpgrades.__get__mTotalPlayerCount() + 1);
        this.mUpgrades.__set__mPlayerCount(this.mUpgrades.__get__mPlayerCount() + 1);
        this.mThing_Collection.AddThing_Player(new Thing.Creature.CThing_Creature_Player(_loc3_,tIndex,sObject.mAngle.Clone()));
        return true;
    }
    function LogKill(tThing)
    {
        false;
        switch(tThing._CLASSID_)
        {
            case "CThing_Creature_Zombie":
                this.mUpgrades.__set__mZombieCount(this.mUpgrades.__get__mZombieCount() - 1);
                if(this.mUpgrades.__get__mMultipleKill() % 5 == 0)
                {
                    this._CreatePickup(tThing.mPosition);
                }
                break;
            case "CThing_Creature_Devil":
                this.mUpgrades.__set__mDevilCount(this.mUpgrades.__get__mDevilCount() - 1);
                this._CreatePickup(tThing.mPosition);
                break;
            default:
                break;
            case "CThing_Creature_Player":
                this.mUpgrades.__set__mPlayerCount(this.mUpgrades.__get__mPlayerCount() - 1);
                this.mHud["mPlayer" + (tThing.mPlayerIndex + 1) + "_Deaths"]++;
                if(World.CWorld.mGameMode == "DeathMatch")
                {
                    this._CreatePickup(tThing.mPosition);
                }
                return undefined;
        }
        this.mHud.AddScore(this.GetScreenPosition(tThing.mPosition),tThing.mScore * this.mUpgrades.__get__mMultiplier());
    }
    function _CreatePickup(p)
    {
        if((this.mMap.mCells[p.mY & 16777215][p.mX & 16777215].mCollide & World.Map.CMap_Cell.mCollide_StaticImpassable) == 0)
        {
            var _loc2_ = this.mThing_Collection.AddThing(new Thing.Object.CThing_Object_Pickup(p.Clone()));
            _loc2_.mDeleteOnPickup = true;
            _loc2_.SetDeleteCounter(CMain.mFPS * 10);
        }
    }
    function PlayerDead(tThing)
    {
        if(World.CWorld.mGameMode == "DeathMatch")
        {
            var _loc2_ = World.CWorld.mNumberOfGameKills[CMain.mSaveData.__get__mGameAmount()];
            if(this.mHud.mPlayer1_Deaths == _loc2_)
            {
                this.mCompleteState = "player2 wins";
            }
            if(this.mHud.mPlayer2_Deaths == _loc2_)
            {
                this.mCompleteState = "player1 wins";
            }
        }
        else if(this.mUpgrades.__get__mPlayerCount() <= 0)
        {
            this.mCompleteState = "player dead";
        }
    }
    function ProcessAmbience()
    {
        var _loc3_ = this.mZombie_AvgPosition;
        _loc3_.x /= this.mZombie_DrawCount;
        _loc3_.y /= this.mZombie_DrawCount;
        this.mAmbienceTicker++;
        if(this.mZombie_DrawCount == 0)
        {
            for(var _loc2_ in this.mZombieSamples)
            {
                this.mZombieSamples[_loc2_].StopSound();
            }
            delete this.mZombieFrequency;
        }
        else if(this.mZombie_DrawCount == 1)
        {
            this.mZombieChannels = 1;
            this.mZombieFrequency = 150;
            this.mZombieVolume = 30;
        }
        else if(this.mZombie_DrawCount <= 2)
        {
            this.mZombieChannels = 1;
            this.mZombieFrequency = 150;
            this.mZombieVolume = 40;
        }
        else if(this.mZombie_DrawCount <= 4)
        {
            this.mZombieChannels = 2;
            this.mZombieFrequency = 150;
            this.mZombieVolume = 60;
        }
        else if(this.mZombie_DrawCount <= 8)
        {
            this.mZombieChannels = 3;
            this.mZombieFrequency = 60;
            this.mZombieVolume = 80;
        }
        else
        {
            this.mZombieChannels = 3;
            this.mZombieFrequency = 1;
            this.mZombieVolume = 100;
        }
        for(_loc2_ in this.mZombieSamples)
        {
            if(!this.mZombieSamples[_loc2_].mPlaying)
            {
                this.mZombieSamples.splice(Number(_loc2_),1);
            }
        }
        if(this.mAmbienceTicker % this.mZombieFrequency == 0)
        {
            this.mZombieSamples = this.mZombieSamples != undefined ? this.mZombieSamples : new Array();
            if(this.mZombieSamples.length < this.mZombieChannels)
            {
                var _loc4_ = CSound.mAmbience["Creature_Zombie_Ambience_" + this.mZombieSampleIndex + "_wav"];
                this.mZombieSampleIndex = (this.mZombieSampleIndex + 1) % this.mZombie_NumberOfSounds;
                this.mZombieSamples.push(_loc4_);
                this.Zombie_PlaySound(_loc4_,_loc3_);
            }
        }
        this.mZombie_DrawCount = 0;
        this.mZombie_AvgPosition = new flash.geom.Point(0,0);
    }
    function Zombie_PlaySound(tSound, p)
    {
        var _loc2_ = this.mScreenCentre;
        var _loc3_ = this.mScreenSizeHalf;
        p = new flash.geom.Point((p.x - _loc2_.x) / _loc3_.x / 3,(p.y - _loc2_.y) / _loc3_.y / 1.5);
        tSound.PlaySound(new flash.geom.Point(0,0));
    }
}
