
require "CCBReaderLoad"
require "AudioEngine"
require "luaRes/GameSelectLayer"
require "luaRes/AniMationData"
require "luaRes/game2WinLayer"
cclog = function(...)
    print(string.format(...))
end
isFirstGame=0
local ydHand=nil
local _ppBack=nil
local HMRole=nil
local DCRole=nil
local layer=nil
local show_Type=1
local show_Num=1
local Game2State=-1;
local Game2_Emu = {normal=0,play=1}
local GameTime=5
local curButtonIndex=0
Game2Layer = Game2Layer or {}
ccb["Game2Layer"] = Game2Layer
local showTypeImgs ={}
showTypeImgs[1]={one=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_tuzi1.png"),two=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_tuzi2.png")}
showTypeImgs[2]={one=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_qingwa1.png"),two=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_qingwa2.png")}
showTypeImgs[3]={one=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_niao1.png"),two=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_niao2.png")}
showTypeImgs[4]={one=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_songshu1.png"),two=CCTextureCache:sharedTextureCache():addImage("richanggame/zhuomicang/zhmc_songshu2.png")}
local showBurrons={}
local buttonPosition={}
local showImags = {}
local showTypeSprite={}
local showTypeNode={}
local function InitDate()
    -- body
    show_Type=1
    show_Num=1
    curButtonIndex=0
end
local function intiShowType()
    -- body
    showTypeSprite[1]=tolua.cast(Game2Layer["_typeTuzi"],"CCSprite")
    showTypeSprite[2]=tolua.cast(Game2Layer["_typeQingWa"],"CCSprite")
    showTypeSprite[3]=tolua.cast(Game2Layer["_typeNiao"],"CCSprite")
    showTypeSprite[4]=tolua.cast(Game2Layer["_typeSongShu"],"CCSprite")
    cclog("isType===="..show_Type..showTypeSprite[1]:getPositionX().."---"..showTypeSprite[1]:getPositionY())
    cclog("isType===="..show_Type..showTypeSprite[2]:getPositionX().."---"..showTypeSprite[2]:getPositionY())
    cclog("isType===="..show_Type..showTypeSprite[3]:getPositionX().."---"..showTypeSprite[3]:getPositionY())
    cclog("isType===="..show_Type..showTypeSprite[4]:getPositionX().."---"..showTypeSprite[4]:getPositionY())
end
local function InitUi()
    
    ydHand=tolua.cast(Game2Layer["ydHand"],"CCSprite")
    _ppBack=tolua.cast(Game2Layer["_ppBack"],"CCSprite")
    HMRole=tolua.cast(Game2Layer["HMRole"],"CCSprite")
    local temp =getHMNOm()
    HMRole:runAction(CCRepeatForever:create(temp))
    DCRole=tolua.cast(Game2Layer["_role"],"CCSprite")
    DCRole:runAction(CCRepeatForever:create(getDCNOm()))
    
    showImags[1]=tolua.cast(Game2Layer["_ShowImgOne"],"CCSprite")
    showImags[2]=tolua.cast(Game2Layer["_ShowImgTwo"],"CCSprite")
    showImags[3]=tolua.cast(Game2Layer["_ShowImgThree"],"CCSprite")
    showImags[4]=tolua.cast(Game2Layer["_ShowImgFour"],"CCSprite")
    showImags[5]=tolua.cast(Game2Layer["_ShowImgFive"],"CCSprite")
   for i,v in ipairs(showImags) do
       v:setVisible(false)
   end
end 
local function intiButton()
    -- body
showBurrons[1]=tolua.cast(Game2Layer["_buttonOne"],"CCControlButton")
showBurrons[2]=tolua.cast(Game2Layer["_buttonTwo"],"CCControlButton")
showBurrons[3]=tolua.cast(Game2Layer["_buttonThree"],"CCControlButton")
showBurrons[4]=tolua.cast(Game2Layer["_buttonFour"],"CCControlButton")
showBurrons[5]=tolua.cast(Game2Layer["_buttonFive"],"CCControlButton") 
buttonPosition[1]={x=showBurrons[1]:getPositionX(),y=showBurrons[1]:getPositionY()}
buttonPosition[2]={x=showBurrons[2]:getPositionX(),y=showBurrons[2]:getPositionY()}
buttonPosition[3]={x=showBurrons[3]:getPositionX(),y=showBurrons[3]:getPositionY()}
buttonPosition[4]={x=showBurrons[4]:getPositionX(),y=showBurrons[4]:getPositionY()}
buttonPosition[5]={x=showBurrons[5]:getPositionX(),y=showBurrons[5]:getPositionY()}
end
local function initShowImg( type,num )
    -- 
    show_Type=type
    show_Num=num 
    -- CCTextureCache:sharedTextureCache():addImage("")
     for i,v in ipairs(showImags) do
       v:setVisible(false)
     end
   for i=1,num do
    local v=showImags[i]
       print(i)
       v:setVisible(true)
       v:setTexture(showTypeImgs[type].one)
   end
end 
local function containsTouchLocation(obj,x,y)
    local position = ccp(obj:getPosition())
    local  s = obj:getContentSize()
    local touchRect = CCRectMake(-s.width / 2 + position.x, -s.height / 2 + position.y, s.width, s.height)
    local b = touchRect:containsPoint(ccp(x,y))
    return b
end
local function ccTouchBegan(x, y)
    if (curButtonIndex ~= 0) then 
        return false
    end
    for i,paddle in ipairs(showBurrons) do
        if containsTouchLocation(paddle,x,y) == true then
            curButtonIndex=i
           cclog("containsTouchLocation----------------->"..i)
        end
    end
    return true;
end
local function gameBegin( )
    -- body
    local animationMgr = tolua.cast(Game2Layer["mAnimationManager"],"CCBAnimationManager")
        if nil ~= animationMgr then
            animationMgr:runAnimationsForSequenceNamedTweenDuration("showPP",0.2)
        end 
end
local moveAvt={}
local function nextGame( )
    -- body
    cclog("nextGame")
    isFirstGame=1
    if GameTime>0 then 
    for i,v in ipairs(moveAvt) do
        layer:removeChild(v,true)
    end
    moveAvt=nil 
    GameTime=GameTime-1
    showBurrons[curButtonIndex]:setPositionX(buttonPosition[curButtonIndex].x)
    showBurrons[curButtonIndex]:setPositionY(buttonPosition[curButtonIndex].y)
    curButtonIndex=0 
    for i,v in ipairs(showImags) do
       v:setVisible(false)
     end
    -- math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    --     local _type=math.random(1,4)
    --     local _num=math.random(1,5)
    --     InitDate()
    -- initShowImg(_type,_num)
    gameBegin()
    return 
    end 
    -- stopBackMusic()
    FinshMapIndex()
    CCDirector:sharedDirector():replaceScene(runMvLayer())
end 
local function HMRunFal(  )
    -- body
    AudioEngine.playEffect("music/taskworng.wav")
    local _action = function ()
        -- body
        cclog("--------->local _action = function ()")
        HMRole:stopAllActions()
        local temp =getHMNOm()
        HMRole:runAction(CCRepeatForever:create(temp))
    end
    local  pCallback = CCCallFunc:create(_action)
    local arr = CCArray:create()
    arr:addObject(getHMNO())
    arr:addObject(pCallback)
    local  pSequence = CCSequence:create(arr)
    HMRole:stopAllActions()
    HMRole:runAction(pSequence)
end
local function HMRunWin(  )
    -- body
    local _action = function ()
        -- body
        cclog("--------->local _action = function ()")
        HMRole:stopAllActions()
        local temp =getHMNOm()
        HMRole:runAction(CCRepeatForever:create(temp))
    end
    local  pCallback = CCCallFunc:create(_action)
    local arr = CCArray:create()
    arr:addObject(getHMYes())
    arr:addObject(pCallback)
    local  pSequence = CCSequence:create(arr)
    HMRole:stopAllActions()
    HMRole:runAction(pSequence)
    AudioEngine.playEffect("music/corret.wav")
end
local function gameWin()
    isFirstGame=1
    if moveAvt==nil then 
        moveAvt={}
    end 
    -- body
    for i=1,show_Num do
        moveAvt[i]=CCSprite:createWithTexture(showTypeImgs[show_Type].two)
        layer:addChild(moveAvt[i])
        local xx=showTypeSprite[show_Type]:getPositionX()
        local yy=showTypeSprite[show_Type]:getPositionY()
        moveAvt[i]:setPosition(xx,yy)
        local x=showImags[i]:getPositionX()
        local y=showImags[i]:getPositionY()
        local actionTo = CCJumpTo:create(1, ccp(x,y), 50, 4)
        moveAvt[i]:runAction(actionTo)
    end
    AudioEngine.playEffect("music/jump.wav")
    local array = CCArray:create()
    array:addObject(CCDelayTime:create(2))
    array:addObject(CCCallFuncN:create(nextGame))
    local action2 = CCSequence:create(array)
    layer:runAction(action2)
    -- nextGame()
end
local function ccTouchMoved(x, y)
    if (curButtonIndex == 0) then 
        return false
    end
    cclog("move----------------->")
    showBurrons[curButtonIndex]:setPosition(x,y)
end

local function ccTouchEnded(x, y)
if (curButtonIndex == 0) then 
        return false
    end
if curButtonIndex~=show_Num then 
    cclog("show_Num----------------->")
    showBurrons[curButtonIndex]:setPositionX(buttonPosition[curButtonIndex].x)
    showBurrons[curButtonIndex]:setPositionY(buttonPosition[curButtonIndex].y)
    curButtonIndex=0
HMRunFal()
    return 
end 
local isType=containsTouchLocation(showTypeSprite[show_Type],x,y); 
cclog("isType===="..show_Type..showTypeSprite[show_Type]:getPositionX().."---"..showTypeSprite[show_Type]:getPositionY())
if isType~=true then 
    cclog("isType----------------->")
    showBurrons[curButtonIndex]:setPositionX(buttonPosition[curButtonIndex].x)
    showBurrons[curButtonIndex]:setPositionY(buttonPosition[curButtonIndex].y)
    curButtonIndex=0
    HMRunFal()
    return 
end
    -- showBurrons[curButtonIndex]:setPositionX(buttonPosition[curButtonIndex].x)
    -- showBurrons[curButtonIndex]:setPositionY(buttonPosition[curButtonIndex].y)
    -- curButtonIndex=0
cclog("yes--------------------------->")
local _sprite=showTypeSprite[show_Type]
showBurrons[curButtonIndex]:setAnchorPoint(ccp(0.5,0.5))
    showBurrons[curButtonIndex]:setPositionX(_sprite:getPositionX()-20)
    showBurrons[curButtonIndex]:setPositionY(_sprite:getPositionY()+20)
    HMRunWin()
    gameWin()
end
local function handFinsh()
    -- body
    if isFirstGame~=0 then  ydHand:setVisible(false)  return end
    local animationMgr = tolua.cast(Game2Layer["mAnimationManager"],"CCBAnimationManager")
        if nil ~= animationMgr then
            animationMgr:runAnimationsForSequenceNamedTweenDuration("handAni",0.2)
    end 

end
local function showPPFinsh()
    -- body
    cclog("showPPFinsh---------------->")
     math.randomseed(tostring(os.time()):reverse():sub(1, 6))

        local _type=math.random(1,4)
        while show_Type==_type do
            math.randomseed(tostring(os.time()):reverse():sub(1, 6))
            _type=math.random(1,4)
        end 
        local _num=math.random(1,5)
    initShowImg(_type,_num)
    _ppBack:setVisible(true)
    Game2State=Game2_Emu.play
    -- gameBegin()
    if isFirstGame==0 then
    local animationMgr = tolua.cast(Game2Layer["mAnimationManager"],"CCBAnimationManager")
        if nil ~= animationMgr then
            animationMgr:runAnimationsForSequenceNamedTweenDuration("handAni",0.2)
        end 
    end 
end
local isTeach=false 
local _tech=nil 
local function onTouch(event, x, y)
    if isTeach==false then _tech:setVisible(false) isTeach=true Game2State=Game2_Emu.normal 
     AudioEngine.stopAllEffects()
    InitDate()
    GameTime=5
    InitUi()
    intiShowType()
    intiButton()
    gameBegin()
    _ppBack:setVisible(false)
    ydHand:setVisible(false)
    isFirstGame=1
    end 
    if Game2State~=Game2_Emu.play then 
        return true
    end 
    cclog("onTouch----------------->")
    if event == "began" then
        return ccTouchBegan(x,y)
    elseif event == "moved" then
        return ccTouchMoved(x,y)
    elseif event == "ended" then
        return ccTouchEnded(x, y)
    end
    return true
end
local function step(dt)
    -- cclog("GameLayer2")
end
local function buttonOne(eventName,control,controlEvent)
    -- body
    cclog("-------buttonOne")
    if controlEvent == CCControlEventTouchDown  then

    elseif controlEvent == CCControlEventTouchUpInside then
         cclog("-------buttonOne")
    end 
end
local function buttonTwo(eventName,control,controlEvent)
    -- body
    cclog("-------buttonTwo")
    if controlEvent == CCControlEventTouchUpInside then
         cclog("-------buttonTwo")
    end 
end
local function buttonThree(eventName,control,controlEvent)
    -- body
    cclog("-------buttonThree")
    if controlEvent == CCControlEventTouchUpInside then
         cclog("-------buttonThree")
    end 
end
local function buttonFour(eventName,control,controlEvent)
    -- body
     cclog("-------buttonFour")
    if controlEvent == CCControlEventTouchUpInside then
         cclog("-------buttonFour")
    end 
end
local function buttonFive(eventName,control,controlEvent)
    -- body
    cclog("-------buttonFive")
    if controlEvent == CCControlEventTouchUpInside then
         cclog("-------buttonFive")
    end 
end
local function buttonBack(eventName,control,controlEvent)
    -- body
    AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    if controlEvent == CCControlEventTouchUpInside then
        cclog("-------buttonBack")
        local _scenes = runGameSelectLayerLayer()
        -- CCDirector:sharedDirector():replaceScene(_scenes)
        CCDirector:sharedDirector():replaceScene(_scenes)
    end 
end
local function test(eventName,control,controlEvent)
    -- body
    cclog("-------buttonBack")
end
Game2Layer["buttonOne"]=buttonOne
Game2Layer["buttonTwo"]=buttonTwo
Game2Layer["buttonThree"]=buttonThree
Game2Layer["buttonFour"]=buttonFour
Game2Layer["buttonFive"]=buttonFive
Game2Layer["buttonBack"]=buttonBack
Game2Layer["showPPFinsh"]=showPPFinsh
Game2Layer["handFinsh"]=handFinsh


local function GameLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    -- cclog("-------Game2Layer")
    local  node  = CCBuilderReaderLoad("ccbi/game2.ccbi",proxy,Game2Layer)
    layer = tolua.cast(node,"CCLayer")
    layer:scheduleUpdateWithPriorityLua(step, 0)
    layer:setTouchEnabled(true)
    layer:registerScriptTouchHandler(onTouch)
    
    isTeach=CCUserDefault:sharedUserDefault():getBoolForKey("isTeach")
    -- if isTeach==false or isTeach==nil or isTeach=="" then 
    if  true then 
        isTeach=false
        CCUserDefault:sharedUserDefault():setBoolForKey("isTeach", true)
    _tech = CCSprite:create("richanggame/zhuomicang/teachImg.png")
    _tech:setAnchorPoint(ccp(0,0))
    layer:addChild(_tech)
    local function playVoice( )
        AudioEngine.playEffect("music/viocechild2.mp3")
    end
    local  pCallback = CCCallFunc:create(playVoice)
    playBackMusic("music/gamebackground.mp3", true)
    local arr = CCArray:create()
    arr:addObject(CCDelayTime:create(0.5))
    arr:addObject(pCallback)
    local  pSequence = CCSequence:create(arr)
    layer:runAction(pSequence)
    else
    Game2State=Game2_Emu.normal 
    InitDate()
    GameTime=5
    InitUi()
    intiShowType()
    intiButton()
    gameBegin()
    _ppBack:setVisible(false)
    ydHand:setVisible(false)
    isFirstGame=1
    playBackMusic("music/gamebackground.mp3", true)
    end 
    return layer
end

function runGame2Layer()
    cclog("Game2Layer")
    local scene = CCScene:create()
    scene:addChild(GameLayer())
    -- local l=InitPauseLayer()
    -- scene:addChild(InitPauseLayer())
    return scene
end