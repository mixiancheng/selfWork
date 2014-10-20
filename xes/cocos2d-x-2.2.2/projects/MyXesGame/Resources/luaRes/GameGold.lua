require "luaRes/extern"
require "AudioEngine"
local MUSIC_GOLD1  = "music/gold1.wav"
local MUSIC_GOLD2  = "music/gold2.wav"
local scheduler = CCDirector:sharedDirector():getScheduler()
cclog = function(...)
    print(string.format(...))
end
GameGold = class("GameGold", function()
    return CCNode:create()
end)
objs={}--金币容器
local imgs ={"game/jinDD.png","game/shuDD.png","game/xingDD.png","game/luojiDD.png"}
local _spriteCache=CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile("game/game.plist","game/game.png")
local function actionCreat()
    -- body
    local actionUp = CCJumpBy:create(2, ccp(0,0), 40, 4)
    return actionUp
end
GameGold.__index=GameGold
GameGold.r=10
GameGold.avt=nil
GameGold.num=10
GameGold.time=30
GameGold.type=0
GameGold.name="---"
GameGold.schedulerEntry=nil
GameGold.alive=true
GameGold.action=false;
local goldNumber=10
function GameGold:addAvt(name,_type,x,y)
    cclog("t==>".._type)
    cclog("imgs[_type]"..imgs[_type])
    self.avt =CCSprite:create(imgs[_type])
    local out=self.avt:getContentSize()
    self.avt:setPositionX(x)
    self.avt:setPositionY(y)
    self.avt:setAnchorPoint(ccp(0.5,0.5))
    self.r=out.width/2
end
function GameGold:removeSelf()
    -- body
    if self==nil then return end 
    -- table.remove(objs,self)
    if self.type==1 then 
        AudioEngine.playEffect("music/goldbeans.wav")
    else
        AudioEngine.playEffect("music/commombeans.wav")
    end 
    cclog("function GameGold:removeSelf()")
    self.avt:setVisible(false)
    self.alive=false;
    scheduler:unscheduleScriptEntry(self.schedulerEntry)
   end
function GameGold:Update(dt)
    self:playAction()
    if game_state~=state_Emu.play  then return end 

    if self.type==0 then
       self.time=self.time-dt
       if self.time<0 then 
        self:removeSelf()
        return 
       end 
    end 
    self:check(damifeng)
    self:check(xiaomifeng)
-- cclog("GameGold:step()->>>>>>>>>>>>>>>"..self.name)
end 
function GameGold:playAction()
    if self.type~=1 then return end 
    local op=255*self.time/30
    self.avt:setOpacity(op)
    -- body
     if game_state==state_Emu.play then 
        if self.action==false then 
            self.action=true  
            self.avt:runAction(CCRepeatForever:create(actionCreat()))
        end 
     elseif game_state==state_Emu.pause then 
        if self.action==true  then 
            self.action=false  
            self.avt:stopAllActions()
        end 
     end 
end
function GameGold:GoldWithTexture(_mtype,_x,_y,_layer )
    cclog("_mtype---->".._mtype)
     self = GameGold.new();
     self:addAvt(_name,_mtype,_x,_y)
     self:retain()
     self.name=_name
     self.type=_mtype
     self.alive=true
     -- if _type==0 then 
     -- self.avt:setScale(2)
     -- end 
     local function step(dt)
         -- body
         -- cclog("local function step(dt)")
         self:Update(dt)
         -- _GameGold:Update(dt)
     end

    self.schedulerEntry=scheduler:scheduleScriptFunc(step,0,false)
    table.insert(objs,self)
    -- _layer:addChild(self.avt)
    return self;
end
function GameGold:check(obj)
    if obj==nil then return end 
    if self.alive==false then 
        return end 
    -- body
    if self.avt==nil  then 
        return false 
    end 
    local  x = obj:getPositionX()
    local y = obj:getPositionY()
    local xx = self.avt:getPositionX()
    local yy=self.avt:getPositionY()
    -- cclog("GameGold:check(obj)::x====="..xx.."y====="..yy)
    local dis = ccpDistance(ccp(xx,yy),ccp(x,y))
    if dis<obj.r+self.r then 
        self:removeSelf()
        if obj._type~=-1 then
        if self.type==1 then jinDD=jinDD+1 
        local n=_leftjinNum:getString()
            _leftjinNum:setString(""..n+1)
        end 
        if self.type==2 then shuDD=shuDD+1 
        local n=_leftNum:getString()
            _leftNum:setString(""..n+1)
        end 
        return 
      end 
            if self.type==1 then jinDD=jinDD+1 
            local n=_rightjinNum:getString()
            _rightjinNum:setString(""..n+1)
            end 
            if self.type==2 then shuDD=shuDD+1 
            local n=_rightNum:getString()
            _rightNum:setString(""..n+1)
           end 
            -- end
    end 
end 
function creatBigerGold(_type,_layer)
    -- body
        math.randomseed(tostring(os.time()):reverse():sub(1, 6)*_type)
        local x=math.random(100,900)
        local y=math.random(50,700)
        local a=GameGold:GoldWithTexture(_type,x,y,_layer)
        return a 
end
function creatGold(_mtype,_layer)
    -- self.type=_type 
    if objs~=nil then objs=nil objs={} end 
    for j=1,20 do
        print(j)
        math.randomseed(tostring(os.time()):reverse():sub(1, 6)*j*123)
        local x=math.random(100,900)
        local y=math.random(50,700)
        cclog("_type---->".._mtype)
        GameGold:GoldWithTexture(_mtype,x,y,_layer)
    end
end