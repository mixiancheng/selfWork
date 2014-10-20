require "CCBReaderLoad"
require "luaRes/LoadingLayer"
require "AudioEngine"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
LogoLayer = LogoLayer or {}
ccb["LogoLayer"] = LogoLayer
local function onTouch()
    cclog("点击进入游戏")
    local nextScenes = runLoadingLayer()
    CCDirector:sharedDirector():replaceScene(nextScenes)
    -- AudioEngine.stopMusic()
    return true
end
local function LogoLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------LogoLayer")
    local  node  = CCBuilderReaderLoad("ccbi/logo.ccbi",proxy,LogoLayer)
    layer = tolua.cast(node,"CCLayer")
    local  pCallback = CCCallFunc:create(onTouch)
    local arr = CCArray:create()
    arr:addObject(CCDelayTime:create(2))
    arr:addObject(pCallback)
    local  pSequence = CCSequence:create(arr)
    layer:runAction(pSequence)
    AudioEngine.playMusic("music/logo1.wav", false)
    return layer
end
function runLogoLayer()
    cclog("LogoLayer")
    local scene = CCScene:create()
    scene:addChild(LogoLayer())
    return scene
end