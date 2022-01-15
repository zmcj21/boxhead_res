class World.CWorld extends MovieClip
{
    var _CLASSID_ = "CWorld";
    var _BASECLASSID_ = "CWorld";
    static var zPoint = new flash.geom.Point(0,0);
    static var zMatrix = new flash.geom.Matrix();
    var mAmbienceTicker = 0;
    var mZombieSampleIndex = 0;
    var mZombie_DrawCount = 0;
    var mZombie_NumberOfSounds = 4;
    function CWorld()
    {
        super();
        Thing.Math.CThing_Angle.Create_LookupTables();
        this._visible = false;
        this.mWorldLoadID = this.Pad0(String(this.mWorldLoadIndex));
        this.mcRoomData = this.attachMovie("Room." + this.mWorldLoadID,"_RoomData",this.getNextHighestDepth());
        this.onEnterFrame = this.Init;
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
        this.mScreenRect = new flash.geom.Rectangle(0,0,this.mScreenSize.x,this.mScreenSize.y);
        this.oScreenRect = this.mScreenRect.clone();
        this.cScreenRect = this.mScreenRect.clone();
        this.mDrawPosition = World.CWorld.zPoint.clone();
        this.onEnterFrame = this.InitDrawPlanes;
    }
    function InitDrawPlanes()
    {
        this.bmFloor = new flash.display.BitmapData(this.mArea.width,this.mArea.height,false,4294901760);
        this.bmDecalMask = new flash.display.BitmapData(this.mArea.width,this.mArea.height,true,0);
        this.bmCover = new flash.display.BitmapData(this.mArea.width,this.mArea.height,true,65280);
        this.bmFloor.draw(this.mcRoomData,World.CWorld.zMatrix,undefined,"normal",undefined,true);
        this.bmDraw = new flash.display.BitmapData(this.mScreenSize.x,this.mScreenSize.y,true,4278190335);
        this.attachBitmap(this.bmDraw,this.getNextHighestDepth(),"always",false);
        this.mcDebug = this.createEmptyMovieClip("_00002",this.getNextHighestDepth());
        this.mcScratch = this.createEmptyMovieClip("_00004",this.getNextHighestDepth());
        this.mcScratch._visible = false;
        this.mcDebug._visible = false;
        this.mHud = new World.CHud(this);
        World.Map.CMap.mcDebug = this.mcDebug;
        this.onEnterFrame = this.InitThings;
    }
    function InitThings()
    {
        Thing.CThing.DummyThings();
        this.mThing_Collection = new Thing.CThing_Collection(this);
        0;
        var _loc5_ = this.mInitList.length;
        while(0 < _loc5_)
        {
            var _loc3_ = this.mInitList[0];
            var _loc2_ = _loc3_.mPosition.ConvertScreenToCell();
            var _loc6_ = _loc3_.mPosition2.ConvertScreenToCell();
            switch(_loc3_._CLASSID_)
            {
                case "CWorld_Init_CollisionSolid":
                    this.mMap.mCollide.MarkArea_PP(_loc2_.Round(),_loc6_.Round(),World.Map.CMap_Cell.mCollide_Solid);
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
                    this.AddSpawnPoint_Player(_loc2_.CellCentre());
                    break;
                case "CWorld_Init_Player2":
                    this.AddSpawnPoint_Player(_loc2_.CellCentre());
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
        this.Spawn_Player();
        this.onEnterFrame = this.InitCleanUp;
    }
    function InitCleanUp()
    {
        this.mcRoomData.removeMovieClip();
        this._visible = true;
        this.mPaused = false;
        CSaveData.QualityActive(true);
        this.Process();
        this.Draw();
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
        scidd.CProfiler.Timer_Start("DRAW");
        this.Process_Shake();
        var _loc4_ = World.CWorld.zPoint.subtract(this.mScreenRect.topLeft.add(this.mShake));
        _loc4_.x = Math.round(_loc4_.x);
        _loc4_.y = Math.round(_loc4_.y);
        this.cScreenRect.x = 0 - _loc4_.x;
        this.cScreenRect.y = 0 - _loc4_.y;
        this.bmDraw.copyPixels(this.bmFloor,this.cScreenRect,World.CWorld.zPoint,undefined,undefined,false);
        this.mDrawPosition.x = this.mScreenRect.x + this.mShake.x;
        this.mDrawPosition.y = this.mScreenRect.y + this.mShake.y;
        scidd.CProfiler.Timer_Start("THINGS.DRAW");
        DrawPrimitive.XSI.CDrawPrimitive_XSI.bmDraw = this.bmDraw;
        this.mMap.Draw(this.mScreenRect);
        scidd.CProfiler.Timer_Stop("THINGS.DRAW");
        if(_root._quality != "LOW")
        {
            this.RenderMCToDraw(this.mcScratch);
        }
        this.bmDraw.copyPixels(this.bmCover,this.cScreenRect,World.CWorld.zPoint,undefined,undefined,true);
        if(_root._quality != "LOW")
        {
            var _loc3_ = this.Process_Brightness();
            for(var _loc5_ in _loc3_)
            {
                this.bmDraw.applyFilter(this.bmDraw,this.bmDraw.rectangle,World.CWorld.zPoint,_loc3_[_loc5_]);
            }
        }
        this.mHud.Draw();
        this.ClearTrackThing();
        this.ProcessAmbience();
        scidd.CProfiler.Timer_Stop("DRAW");
    }
    function RenderMCToDraw(mc)
    {
        var _loc2_ = mc.getBounds(mc);
        this.bmDraw.draw(mc,World.CWorld.zMatrix,undefined,"normal",new flash.geom.Rectangle(_loc2_.xMin,_loc2_.yMin,_loc2_.xMax - _loc2_.xMin,_loc2_.yMax - _loc2_.yMin),true);
        mc.clear();
    }
    function TrackThing(tThing)
    {
        this.mTrackPosition = this.mTrackPosition != undefined ? this.mTrackPosition.Add(tThing.mPosition).ScaleN(0.5) : tThing.mPosition.Clone();
        var _loc2_ = this.mTrackPosition.ConvertCellToScreen();
        this.mScreenRect.x = scidd.Math.CMath.Range(Math.round(_loc2_.x - this.mScreenRect.width / 2),World.Map.CMap_Cell.mSize.x,this.mArea.width - (this.mScreenRect.width + World.Map.CMap_Cell.mSize.x));
        this.mScreenRect.y = scidd.Math.CMath.Range(Math.round(_loc2_.y - this.mScreenRect.height / 2),World.Map.CMap_Cell.mSize.y,this.mArea.height - (this.mScreenRect.height + World.Map.CMap_Cell.mSize.y));
        this.mScreenSizeHalf = this.mScreenRect.size;
        this.mScreenSizeHalf.x /= 2;
        this.mScreenSizeHalf.y /= 2;
        this.mScreenCentre = this.mScreenRect.topLeft.add(this.mScreenSizeHalf);
    }
    function ClearTrackThing()
    {
        this.mTrackPosition = undefined;
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
    function AddSpawnPoint_Player(p)
    {
        this.mSpawnPoint_Player = this.mSpawnPoint_Player != undefined ? this.mSpawnPoint_Player : new Array();
        this.mSpawnPoint_Player.push({mPosition:p,mCell:this.mMap.GetCell(p.mX,p.mY)});
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
    function Spawn_Player()
    {
        var _loc2_ = this.mSpawnPoint_Player[0].mPosition.Clone();
        this.mUpgrades.__set__mPlayerCount(this.mUpgrades.__get__mPlayerCount() + 1);
        this.mThing_Collection.AddThing_Player(new Thing.Creature.CThing_Creature_Player(_loc2_));
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
                    true;
                }
                break;
            case "CThing_Creature_Devil":
                this.mUpgrades.__set__mDevilCount(this.mUpgrades.__get__mDevilCount() - 1);
                true;
                break;
            default:
                break;
            case "CThing_Creature_Player":
                this.mUpgrades.__set__mPlayerCount(this.mUpgrades.__get__mPlayerCount() - 1);
                return undefined;
        }
        if(true)
        {
            if((this.mMap.mCells[tThing.mPosition.mY & 16777215][tThing.mPosition.mX & 16777215].mCollide & World.Map.CMap_Cell.mCollide_StaticImpassable) == 0)
            {
                var _loc4_ = this.mThing_Collection.AddThing(new Thing.Object.CThing_Object_Pickup(tThing.mPosition.Clone()));
                _loc4_.mDeleteOnPickup = true;
                _loc4_.SetDeleteCounter(CMain.mFPS * 10);
            }
        }
        this.mHud.AddScore(this.GetScreenPosition(tThing.mPosition),tThing.mScore * this.mUpgrades.__get__mMultiplier());
    }
    function DrawCircle(tp, r, tColor)
    {
        DrawPrimitive.CDrawPrimitive_Circle.Draw(this.mcDebug,new flash.geom.Point(tp.mX * 32,tp.mY * 32),r,tColor,25,false);
    }
    function PlayerDead(tThing)
    {
        this.mCompleteState = "player dead";
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
        tSound.PlaySound(p);
    }
}
