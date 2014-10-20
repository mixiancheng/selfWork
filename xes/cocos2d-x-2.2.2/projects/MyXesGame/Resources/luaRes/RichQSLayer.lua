
require "CCBReaderLoad"
require "AudioEngine"
require "GameWinLayer"
cclog = function(...)
    print(string.format(...))
end
local showType = -1
local gameState=0
local gameTimes=3
local buttonImg = {}
local showImgs=nil
local ShowType = 0
RichQSLayer = RichQSLayer or {}
ccb["RichQSLayer"] = RichQSLayer
local _showImgs = {}
_showImgs[1]={imgShow=CCTextureCache:sharedTextureCache():addImage("saizi/xiongmao.png"),imgButton=CCTextureCache:sharedTextureCache():addImage("saizi/yingzi_xiongmao.png")}
_showImgs[2]={imgShow=CCTextureCache:sharedTextureCache():addImage("saizi/houzi.png"),imgButton=CCTextureCache:sharedTextureCache():addImage("saizi/yingzi_houzi.png")}
_showImgs[3]={imgShow=CCTextureCache:sharedTextureCache():addImage("saizi/mao.png"),imgButton=CCTextureCache:sharedTextureCache():addImage("saizi/yingzi_mao.png")}
_showImgs[4]={imgShow=CCTextureCache:sharedTextureCache():addImage("saizi/niao.png"),imgButton=CCTextureCache:sharedTextureCache():addImage("saizi/yingzi_niao.png")}
_showImgs[5]={imgShow=CCTextureCache:sharedTextureCache():addImage("saizi/tuzi.png"),imgButton=CCTextureCache:sharedTextureCache():addImage("saizi/yingzi_tuzi.png")}
_showImgs[6]={imgShow=CCTextureCache:sharedTextureCache():addImage("saizi/eyu.png"),imgButton=CCTextureCache:sharedTextureCache():addImage("saizi/yingzi_eyu.png")}
local heartShow = {}
local function initHeart(num)
    -- body
    heartNum=num
    heartShow[1]=tolua.cast(RichQSLayer["_heartOne"],"CCSprite")
    heartShow[2]=tolua.cast(RichQSLayer["_heartTwo"],"CCSprite")
    heartShow[3]=tolua.cast(RichQSLayer["_heartThree"],"CCSprite")
    for i,v in ipairs(heartShow) do
     if i<=num then v:setVisible(true) else
        v:setVisible(false)
    end 
    end
end
local function delHeart()
    -- body
    local actionBack=tolua.cast(RichQSLayer["actionBack"],"CCSprite")
    actionBack:setVisible(true)
    local actionDel=tolua.cast(RichQSLayer["actionDel"],"CCSprite")
    actionDel:setVisible(true)
    local animMixed = getdellHeartAni()
           local _fun = function ()
                -- body
                heartShow[heartNum]:setVisible(false)
                -- CCDirector:sharedDirector():popScene()
                heartNum=heartNum-1
                for i,v in ipairs(HeartArr) do
                if i<=heartNum then v:setVisible(true) else
                v:setVisible(false)
                end 
                end 
                if heartNum~=0 then CCDirector:sharedDirector():popScene()
                else  
                cclog("gameOver")
                local _s=runGameWinLayer(false)
                CCDirector:sharedDirector():replaceScene(_s)
                end 
            end
            local  pCallback = CCCallFunc:create(_fun)
            local arr = CCArray:create()
            arr:addObject(CCDelayTime:create(0.5))
            arr:addObject(animMixed)
            arr:addObject(pCallback)
            local  pSequence = CCSequence:create(arr)
            actionDel:runAction(pSequence)
end
local function initUi()
    -- body
    cclog("local function initUi()")
    showImgs=tolua.cast(RichQSLayer["_showImg"],"CCSprite")
    buttonImg[1]=tolua.cast(RichQSLayer["_oneImg"],"CCSprite")
    buttonImg[2]=tolua.cast(RichQSLayer["_twoImg"],"CCSprite")
    buttonImg[3]=tolua.cast(RichQSLayer["_threeImg"],"CCSprite")
end
local function CreatType(n_type)
    -- body
    local index  = {}
    if n_type>=5 then index[1]=1 index[2]=2 else 
        index[1]=n_type+1 index[2]=n_type+2
    end 
return index
end
local function setType(_type)
    -- body
    -- ShowType=_type
    showType=_type
    local imgs = _showImgs[_type].imgShow
    showImgs:setTexture(_showImgs[_type].imgShow)
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    ShowType = math.random(1,3)
    buttonImg[ShowType]:setTexture(_showImgs[_type].imgButton)
    local indexT=CreatType(_type)
    local n=1
    for i,v in ipairs(buttonImg) do
          if  ShowType~=i then 
            -- cclog("a=="..a.."b=="..b)
            v:setTexture(_showImgs[indexT[n]].imgButton)
            n=n+1
          end          
    end
end
local function nextQS(index)
    -- body
    if index~=ShowType then delHeart() 
    AudioEngine.playEffect("music/taskworng.wav")
        return end 
        AudioEngine.playEffect("music/taskcorret.wav")
    gameTimes=gameTimes-1
    if gameTimes==0 then CCDirector:sharedDirector():popScene()
     -- AudioEngine.playEffect("music/success.wav")
     return end 
    math.randomseed(tostring(os.time()):reverse():sub(1, 6)*(index/1.25))
    local buttonIndex = math.random(1,6)
    while buttonIndex==showType do
        math.randomseed(tostring(os.time()):reverse():sub(1, 6)*(index/1.25))
        buttonIndex = math.random(1,6)
    end 
    setType(buttonIndex)
    gameState=0
end
local function gameBegin()
    -- body
    local animationMgr = tolua.cast(Game2Layer["mAnimationManager"],"CCBAnimationManager")
        if nil ~= animationMgr then
            animationMgr:runAnimationsForSequenceNamedTweenDuration("showPP",0.2)
        end 
end
local function buttonOne(eventName,control,controlEvent)
    -- body
    if gameState~=0 then return end 
    gameState=1
    if controlEvent == CCControlEventTouchDown  then

    elseif controlEvent == CCControlEventTouchUpInside then
    nextQS(1)
    end 
end
local function buttonTwo(eventName,control,controlEvent)
    -- body
    if gameState~=0 then return end
    gameState=1
    if controlEvent == CCControlEventTouchUpInside then
nextQS(2)
    end 
end
local function buttonThree(eventName,control,controlEvent)
    -- body
    if gameState~=0 then return end
    gameState=1
    if controlEvent == CCControlEventTouchUpInside then
    nextQS(3)
    end 
end
local function step()
    -- body
end
RichQSLayer["buttonOne"]=buttonOne
RichQSLayer["buttonTwo"]=buttonTwo
RichQSLayer["buttonThree"]=buttonThree
local function _RichQSLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    -- cclog("-------Game2Layer")
    local  node  = CCBuilderReaderLoad("ccbi/RichQSLayer.ccbi",proxy,RichQSLayer)
    layer = tolua.cast(node,"CCLayer")
    layer:scheduleUpdateWithPriorityLua(step, 0)
    initUi()
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    local _type=math.random(1,6)
    setType(_type)
    initHeart(heartNum)
    gameState=0
    gameTimes=3
    playBackMusic("music/gamebackground.mp3", true)
    AudioEngine.playEffect("music/viocetask.mp3")
    return layer
end

function runRichQSLayer()
    cclog("RichQSLayer")
    local scene = CCScene:create()
    scene:addChild(_RichQSLayer())
    -- local l=InitPauseLayer()
    -- scene:addChild(InitPauseLayer())
    return scene
end