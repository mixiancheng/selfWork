
require "CCBReaderLoad"
require "luaRes/MiFeng"
require "luaRes/GameGold"
require "AudioEngine"
cclog = function(...)
    -- print(string.format(...))
end
local MUSIC_BACK = "music/gameBack1.wav"
-- local MUSIC_PENG1  = "music/peng1.wav"
-- local MUSIC_PENG2  = "music/peng2.wav"
 _leftNum=nil 
 _rightNum=nil 
 _leftjinNum=nil
 _rightjinNum=nil
 shuDD=0
 jinDD=0
local dirButton = {}
local m_label0=nil
local m_label1=nil
local m_time0=15
local creatBigerTime=3
 damifeng=nil 
 xiaomifeng=nil
local layer = nil
local pauseLayer=nil
local tongjiLayer=nil
-- local spritebatch=nil 
local _ccspriteTimeL=nil
local _ccspriteTimeR=nil
game_state = -1
-- local readyL=false
-- local readyR=false
local pauseLButton=nil
local pauseRButton=nil
-- local readyLButton=nil
-- local readyRButton=ni
state_Emu={normal=0,ready=1,play=2,pause=3,tongji=4}
local allNum=0;
GamePauseLayer = GamePauseLayer or {}
ccb["GamePauseLayer"] = GamePauseLayer
GameTongjiLayer = GameTongjiLayer or {}
ccb["GameTongjiLayer"] = GameTongjiLayer
Game1Layer = Game1Layer or {}
ccb["Game1Layer"] = Game1Layer
function removeGold()
    -- body
    for i,v in ipairs(objs) do
        if v.alive then 
        v.alive=false 
        v.removeSelf()
        table.remove(objs,i)
    end 
    end
    -- objs=nil
end
local function addBigerGold(dt)
    -- body
    creatBigerTime=creatBigerTime-dt
    if creatBigerTime<0 then 
        creatBigerTime=3
        local temp=creatBigerGold(1,layer)
        layer:addChild(temp.avt)
        temp=creatBigerGold(2,layer)
        layer:addChild(temp.avt)
    end
end
local function InitData()
    -- body
    -- spritebatch=nil
    game_state=state_Emu.normal
    -- readyL=false
    -- readyR=false
    m_time0=QZGameTimer
end
local function tjBack(eventName,control,controlEvent)
    -- body
    AudioEngine.playEffect("music/buttonchild.wav")
    CCDirector:sharedDirector():replaceScene(runGameGameSelectBothLayer())
    removeGold()
end
local function tjRgame(eventName,control,controlEvent)
    -- body
    AudioEngine.playEffect("music/buttonchild.wav")
    removeGold()
    InitData()
    CCDirector:sharedDirector():replaceScene(runGame1Layer())
end  
local function backL(eventName,control,controlEvent)
    -- body
    if controlEvent == CCControlEventTouchUpInside then
        -- if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        AudioEngine.playEffect("music/buttonchild.wav")
        CCDirector:sharedDirector():replaceScene(runGameGameSelectBothLayer())
        removeGold()
    end 
end
local function backR(eventName,control,controlEvent)
    -- body
    if controlEvent == CCControlEventTouchUpInside then
        -- if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        AudioEngine.playEffect("music/buttonchild.wav")
        CCDirector:sharedDirector():replaceScene(runGameGameSelectBothLayer())
        removeGold()
    end 
end
local function continueL(eventName,control,controlEvent)
    if game_state==state_Emu.play then return end 
    -- body
    if controlEvent == CCControlEventTouchUpInside then
        -- if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        AudioEngine.playEffect("music/buttonchild.wav")
        game_state=state_Emu.play
        CCDirector:sharedDirector():getRunningScene():removeChild(pauseLayer,false)
        playBackMusic("music/gamebackground.mp3", true)
    end 
end
local function continueR(eventName,control,controlEvent)
    if game_state==state_Emu.play then return end 
    -- body
    if controlEvent == CCControlEventTouchUpInside then
        -- if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        AudioEngine.playEffect("music/buttonchild.wav")
        game_state=state_Emu.play
        CCDirector:sharedDirector():getRunningScene():removeChild(pauseLayer,false)
        playBackMusic("music/gamebackground.mp3", true)
    end 
end
GameTongjiLayer["tjBack"]=tjBack
GameTongjiLayer["tjRgame"]=tjRgame
GamePauseLayer["backL"]=backL
GamePauseLayer["backR"]=backR
GamePauseLayer["continueL"]=continueL
GamePauseLayer["continueR"]=continueR
local function InitPauseLayer()
    -- body
    if pauseLayer==nil then 
    local  proxy = CCBProxy:create()
    local node =CCBuilderReaderLoad("ccbi/GamePauseLayer.ccbi",proxy,GamePauseLayer)
    pauseLayer = tolua.cast(node,"CCLayer")
    end 
    return pauseLayer
end
local function InitTongJiLayer()
    -- body
    if tongjiLayer==nil then 
    local  proxy = CCBProxy:create()
    local node =CCBuilderReaderLoad("ccbi/gameTongjiLayer.ccbi",proxy,GameTongjiLayer)
    tongjiLayer = tolua.cast(node,"CCLayer")
    -- AudioEngine.stopMusic()
    end 
    AudioEngine.stopMusic()
    return tongjiLayer
end
local function UIInit()
    _leftNum=tolua.cast(Game1Layer["LDDNum"],"CCLabelTTF")
    _rightNum=tolua.cast(Game1Layer["RDDNum"],"CCLabelTTF")
    _leftjinNum=tolua.cast(Game1Layer["LjinDDNum"],"CCLabelTTF")
    _rightjinNum=tolua.cast(Game1Layer["RjinDDNum"],"CCLabelTTF")

    _ccspriteTimeL = tolua.cast(Game1Layer["_timerL"],"CCSprite")
    _ccspriteTimeR = tolua.cast(Game1Layer["_timerR"],"CCSprite")
    -- _ccspriteTimeL:setVisible(false)
    -- _ccspriteTimeR:setVisible(false)
    pauseLButton = tolua.cast(Game1Layer["_pauseL"],"CCControlButton")
    pauseRButton = tolua.cast(Game1Layer["_pauseR"],"CCControlButton")
    pauseLButton:setZOrder(100)
    pauseRButton:setZOrder(100)
    pauseLButton:setVisible(false)
    pauseRButton:setVisible(false) 
    -- readyLButton = tolua.cast(Game1Layer["_GetreadyL"],"CCControlButton")
    -- readyRButton = tolua.cast(Game1Layer["_GetreadyR"],"CCControlButton")

    local _LUPButton = tolua.cast(Game1Layer["_LUPButton"],"CCControlButton")
    local _LDOWNButton = tolua.cast(Game1Layer["_LDOWNButton"],"CCControlButton")
    local _RUPButton = tolua.cast(Game1Layer["_RUPButton"],"CCControlButton")
    local _RDOWNButton = tolua.cast(Game1Layer["_RDOWNButton"],"CCControlButton")
    _LUPButton:setZOrder(100)
    _LDOWNButton:setZOrder(100)
    _RUPButton:setZOrder(100)
    _RDOWNButton:setZOrder(100)
    _LUPButton:setEnabled(false)
    _LDOWNButton:setEnabled(false)
    _RUPButton:setEnabled(false)
    _RDOWNButton:setEnabled(false)
    table.insert(dirButton,_LUPButton)
    table.insert(dirButton,_LDOWNButton)
    table.insert(dirButton,_RUPButton)
    table.insert(dirButton,_RDOWNButton)
    -- _RDOWNButton:setZOrder(100)
end
local function addGold()
    -- body
    -- if spritebatch==nil then 
    -- spritebatch = CCSpriteBatchNode:create("game/game.png")
    -- layer:addChild(spritebatch)
    -- end 
    creatGold(2,layer)
    local function sortObjs( a,b )
    -- body
   local x= a.avt:getPositionX()
   local y= a.avt:getPositionY()
   local xx = b.avt:getPositionX()
   local yy=b.avt:getPositionY()
    return yy<y
end 
    table.sort( objs, sortObjs)
    for i,v in ipairs(objs) do
        cclog("i======="..i)
    layer:addChild(objs[i].avt)
    end 
end
local function timefinsh()
    -- body
    cclog("local function timefinsh()")
    _ccspriteTimeL:setVisible(false)
    _ccspriteTimeR:setVisible(false)
    pauseLButton:setVisible(true)
    pauseRButton:setVisible(true)
    addGold()
    game_state=state_Emu.play
    for i,v in ipairs(dirButton) do
       v:setEnabled(true)
    end
    -- cclog("local function timefinsh()")
end 
local function dellTick(dt)
    if #objs==0 then 
        -- addGold()
        -- m_time0=m_time0+10
        -- cclog("add------------------->")
    end 

    for i,v in ipairs(objs) do
        if v~=nil then
            if v.alive==false then 
                table.remove(objs,i)
            end 
        end 
    end
    -- cclog("number============>"..allNum)
end
local function step(dt)
    -- cclog("local function step ")
    -- getDisplayedColor()
    -- m_label1:setString(allNum)
    if game_state==state_Emu.normal then 
        -- cclog("state_Emu.normal")
        --  if readyL and readyR then 
        --     game_state=state_Emu.ready
            
        -- local animationMgr = tolua.cast(Game1Layer["mAnimationManager"],"CCBAnimationManager")
        -- if nil ~= animationMgr then
        --     animationMgr:runAnimationsForSequenceNamedTweenDuration("Untitled Timeline",0.2)
        -- end 
        --  end 
        elseif game_state==state_Emu.ready then 
-- cclog("state_Emu.ready")
        elseif game_state==state_Emu.play   then 
            -- cclog("state_Emu.play")
            addBigerGold(dt)
            m_time0 = m_time0 -dt
            local str = string.format("%2.1f秒", m_time0)
            m_label0:setString(str)
            if m_time0<1 then 
            local str = string.format("%2.1f秒", 0)
            m_label0:setString(str)
            game_state=state_Emu.tongji
            CCDirector:sharedDirector():getRunningScene():addChild(runtan_fumu3Layer())
            end 
            -- elseif 1 then
            if m_time0>0 then 
            damifeng:step()
            xiaomifeng:step()
            dellTick(dt)
            end 
           -- end 
        elseif game_state==state_Emu.pause then 
            -- cclog("state_Emu.pause")
        elseif game_state==state_Emu.tongji then 
            -- cclog("state_Emu.tongji")
        end  

end
local function pauseL(eventName,control,controlEvent)
    if game_state==state_Emu.pause then return end 
    if game_state==state_Emu.tongji then return end 
    -- body
    if controlEvent == CCControlEventTouchUpInside then
        -- if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        AudioEngine.playEffect("music/buttonchild.wav")
        game_state=state_Emu.pause 
        local _layer=InitPauseLayer()
        CCDirector:sharedDirector():getRunningScene():addChild(_layer)
        stopBackMusic()
    end 
end
local function pauseR(eventName,control,controlEvent)
    if game_state==state_Emu.pause then return end 
    if game_state==state_Emu.tongji then return end 
    -- body
    if controlEvent == CCControlEventTouchUpInside then
        -- if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        AudioEngine.playEffect("music/buttonchild.wav")
        game_state=state_Emu.pause 
        local _layer=InitPauseLayer()
        CCDirector:sharedDirector():getRunningScene():addChild(_layer)
        stopBackMusic()
    end 
end
local function buttonRGame(eventName,control,controlEvent)
    cclog("buttonLUp--------------->")

    CCDirector:sharedDirector():replaceScene(runGame1Layer())
   if controlEvent == CCControlEventTouchDown  then  
   -- damifeng.dir=EnumTable[1] 
        cclog("Touch Down."..EnumTable[1])   
        AudioEngine.playEffect("music/buttonchild.wav")     
    elseif controlEvent == CCControlEventTouchDragInside then
        cclog("Touch Drag Inside.") 
        
    elseif controlEvent == CCControlEventTouchDragOutside then
        cclog("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        cclog("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        cclog("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        -- if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        cclog("Touch Up Inside.") 
    elseif controlEvent == CCControlEventTouchUpOutside then
        if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        cclog("Touch Up Outside.") 
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
local function buttonLUp(eventName,control,controlEvent)
    if game_state==state_Emu.pause then return end 
    cclog("buttonLUp--------------->")
   if controlEvent == CCControlEventTouchDown  then  
   damifeng.dir=EnumTable[1] 
        cclog("Touch Down."..EnumTable[1])     
        AudioEngine.playEffect("music/buttonchild.wav")   
    elseif controlEvent == CCControlEventTouchDragInside then
        cclog("Touch Drag Inside.") 
        
    elseif controlEvent == CCControlEventTouchDragOutside then
        cclog("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        cclog("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        cclog("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        cclog("Touch Up Inside.") 
    elseif controlEvent == CCControlEventTouchUpOutside then
        if EnumTable[1]==damifeng.dir then damifeng.dir=0  end
        cclog("Touch Up Outside.") 
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
local function buttonLDown(eventName,control,controlEvent)
    if game_state==state_Emu.pause then return end 
    cclog("buttonLDown--------------->")
   if controlEvent == CCControlEventTouchDown  then   
    damifeng.dir=EnumTable[2]
        cclog("Touch Down.")        
        AudioEngine.playEffect("music/buttonchild.wav")
    elseif controlEvent == CCControlEventTouchDragInside then
          
        cclog("Touch Drag Inside.") 
    elseif controlEvent == CCControlEventTouchDragOutside then
        cclog("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        cclog("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        cclog("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        if EnumTable[2]==damifeng.dir then damifeng.dir=0 end
        cclog("Touch Up Inside.") 
    elseif controlEvent == CCControlEventTouchUpOutside then
        if EnumTable[2]==damifeng.dir then damifeng.dir=0 end
        cclog("Touch Up Outside.") 
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
local function buttonRUp(eventName,control,controlEvent)
    if game_state==state_Emu.pause then return end 
    if controlEvent == CCControlEventTouchDown  then  
   xiaomifeng.dir=EnumTable[2]
   AudioEngine.playEffect("music/buttonchild.wav")
        cclog("Touch Down.")        
    elseif controlEvent == CCControlEventTouchDragInside then
        cclog("Touch Drag Inside.") 
        
    elseif controlEvent == CCControlEventTouchDragOutside then
        cclog("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        cclog("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        cclog("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        if EnumTable[2]==xiaomifeng.dir then xiaomifeng.dir=0  end
        cclog("Touch Up Inside.") 
    elseif controlEvent == CCControlEventTouchUpOutside then
        if EnumTable[2]==xiaomifeng.dir then xiaomifeng.dir=0  end
        cclog("Touch Up Outside.") 
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
local function buttonRDown(eventName,control,controlEvent)
if game_state==state_Emu.pause then return end 
  if controlEvent == CCControlEventTouchDown  then   
    xiaomifeng.dir=EnumTable[1] 
    AudioEngine.playEffect("music/buttonchild.wav")
        cclog("Touch Down.")        
    elseif controlEvent == CCControlEventTouchDragInside then
        cclog("Touch Drag Inside.") 
    elseif controlEvent == CCControlEventTouchDragOutside then
        cclog("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        cclog("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        cclog("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        if EnumTable[1]==xiaomifeng.dir then xiaomifeng.dir=0 end
        cclog("Touch Up Inside.") 
    elseif controlEvent == CCControlEventTouchUpOutside then
        if EnumTable[1]==xiaomifeng.dir then xiaomifeng.dir=0 end
        cclog("Touch Up Outside.") 
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
Game1Layer["buttonLUp"]=buttonLUp
Game1Layer["buttonLDown"]=buttonLDown
Game1Layer["buttonRUp"]=buttonRUp
Game1Layer["buttonRDown"]=buttonRDown
Game1Layer["RGame"]=buttonRGame
-- Game1Layer["GetreadyL"]=GetreadyL
-- Game1Layer["GetreadyR"]=GetreadyR
Game1Layer["pauseL"]=pauseL
Game1Layer["pauseR"]=pauseR
Game1Layer["timefinsh"]=timefinsh
local function GameLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local cache = CCSpriteFrameCache:sharedSpriteFrameCache()
    
    cache:addSpriteFramesWithFile("game/game.plist")
    local  proxy = CCBProxy:create()
    cclog("-------Game1Layer")
    local  node  = CCBuilderReaderLoad("ccbi/game1.ccbi",proxy,Game1Layer)
    layer = tolua.cast(node,"CCLayer")
    damifeng = MiFeng:MiFengWithTexture("game/damifeng.png")
    layer:addChild(damifeng)
    damifeng:setZOrder(100)
    damifeng:setPosition(280,230)
    xiaomifeng = MiFeng:MiFengWithTexture("game/xiaomifeng.png",-1)
    layer:addChild(xiaomifeng)
    xiaomifeng:setZOrder(100)
    xiaomifeng:setPosition(750,536)
    xiaomifeng:setRotation(180)
    layer:scheduleUpdateWithPriorityLua(step, 0)
    UIInit()
    InitData()
    -- addGold()
    -- AudioEngine.playMusic(MUSIC_BACK, true)
    local _back = tolua.cast(Game1Layer["_TimerBack"],"CCSprite")
    m_label0 =tolua.cast(Game1Layer["timeMesg"],"CCLabelTTF")
    local str = string.format("%2.1f秒", QZGameTimer)
    m_label0:setString(str)
    shuDD=0
    jinDD=0
    stopBackMusic()
   playBackMusic("music/gamebackground.mp3", true)

    game_state=state_Emu.ready  
        local animationMgr = tolua.cast(Game1Layer["mAnimationManager"],"CCBAnimationManager")
        if nil ~= animationMgr then
        animationMgr:runAnimationsForSequenceNamedTweenDuration("Untitled Timeline",0.2)
        end 
    return layer
end

function runGame1Layer()
    cclog("Game1Layer")
    local scene = CCScene:create()
    scene:addChild(GameLayer())
    -- local l=InitPauseLayer()
    -- scene:addChild(InitPauseLayer())
    return scene
end