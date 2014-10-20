
require "CCBReaderLoad"
require "AudioEngine"
cclog = function(...)
    print(string.format(...))
end
game2WinLayer = game2WinLayer or {}
ccb["game2WinLayer"] = game2WinLayer
local showImgs = nil
local function LoadFinsh()
    cclog("进入大地图")
    FinshMapIndex()
    AudioEngine.stopAllEffects()
    local nextLayer = runWorldMapLayer()
    CCDirector:sharedDirector():replaceScene(nextLayer)
end
local function buttonBack(eventName,control,controlEvent)
    -- body
    -- AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    LoadFinsh()
end
local function buttonRgame(eventName,control,controlEvent)
    -- body
    -- AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    local nextLayer = runGame2Layer()
    CCDirector:sharedDirector():replaceScene(nextLayer)
end
local function buttonFinsh(eventName,control,controlEvent)
    -- body
    LoadFinsh()
end
game2WinLayer["buttonBack"]=buttonBack
game2WinLayer["buttonRgame"]=buttonRgame
game2WinLayer["buttonFinsh"]=buttonFinsh
local function _game2WinLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    -- cclog("-------Game2Layer")
    local  node  = CCBuilderReaderLoad("ccbi/game2Win.ccbi",proxy,game2WinLayer)
    layer = tolua.cast(node,"CCLayer")
    showImgs=tolua.cast(game2WinLayer["_showImgs"],"CCSprite")
    local arr = CCArray:create()
    arr:addObject(getHH())
    arr:addObject(CCDelayTime:create(1))
    local  pSequence = CCSequence:create(arr)
    showImgs:runAction(CCRepeatForever:create(pSequence))
    stopBackMusic()
    AudioEngine.playEffect("music/success.wav",true)
    -- playBackMusic("music",_bool)
    -- layer:scheduleUpdateWithPriorityLua(step, 0)
    return layer
end

function rungame2WinLayer()
    cclog("rungame2WinLayer")
    local scene = CCScene:create()
    scene:addChild(_game2WinLayer())
    return scene
end