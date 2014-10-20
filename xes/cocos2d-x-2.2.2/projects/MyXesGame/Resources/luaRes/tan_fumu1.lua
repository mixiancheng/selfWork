require "CCBReaderLoad"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
tan_fumu1 = tan_fumu1 or {}
ccb["tan_fumu1"] = tan_fumu1
local function buttonLExit()
    -- body
    AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    local s = runGameGameSelectBothLayer()
    CCDirector:sharedDirector():replaceScene(s)
end
local function buttonRExit()
    -- body
    AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    local s = runGameGameSelectBothLayer()
    CCDirector:sharedDirector():replaceScene(s)
    AudioEngine.playEffect("music/buttonchild.wav")
end
local function buttonLStart()
    -- body
    startGame()
    AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    CCDirector:sharedDirector():getRunningScene():removeChild(layer,true)
end
local function buttonRStart()
    -- body
    startGame()
    AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    CCDirector:sharedDirector():getRunningScene():removeChild(layer,true)
end
local function buttonStop()
    cclog("buttonBack------->")
    AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runGameGameSelectBothLayer()
CCDirector:sharedDirector():replaceScene(s)
end
local function buttonNext( )
    -- body
    cclog("buttonRgame------->")
    AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runTest()
CCDirector:sharedDirector():replaceScene(s)
end

tan_fumu1["LExit"]=buttonLExit
tan_fumu1["RExit"]=buttonRExit
tan_fumu1["LStart"]=buttonLStart
tan_fumu1["RStart"]=buttonRStart
local function _tan_fumu1Layer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    local  node  = CCBuilderReaderLoad("ccbi/tan_fumu1.ccbi",proxy,tan_fumu1)
    layer = tolua.cast(node,"CCLayer")
    playBackMusic("music/background.mp3", true)
    AudioEngine.playEffect("music/vioceparents1.mp3")
    return layer
end
function runtan_fumu1Layer()
    cclog("LogoLayer")
    -- local scene = CCScene:create()
    -- scene:addChild(_tan_fumu1Layer())
    return _tan_fumu1Layer()
end