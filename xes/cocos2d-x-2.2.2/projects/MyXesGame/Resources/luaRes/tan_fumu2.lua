require "CCBReaderLoad"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
tan_fumu2 = tan_fumu2 or {}
ccb["tan_fumu2"] = tan_fumu2
local function buttonYes()
    cclog("buttonBack------->")
    AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runWorldMapLayer()
CCDirector:sharedDirector():replaceScene(s)
end
local function buttonStart( )
    -- body
    cclog("buttonRgame------->")
    AudioEngine.stopAllEffects()
AudioEngine.playEffect("music/buttonchild.wav")
local s = runGame1Layer()
CCDirector:sharedDirector():replaceScene(s)
end

tan_fumu2["buttonYes"]=buttonYes
tan_fumu2["buttonStart"]=buttonStart
local function _tan_fumu2Layer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    local  node  = CCBuilderReaderLoad("ccbi/tan_fumu2.ccbi",proxy,tan_fumu2)
    layer = tolua.cast(node,"CCLayer")
    local timeMesg=tolua.cast(tan_fumu2["timeMesg"],"CCLabelTTF")
    local str = string.format("%2.1f\"", QZGameTimer)
    timeMesg:setString(str)
    local FMDFMesg=tolua.cast(tan_fumu2["FMDFMesg"],"CCLabelTTF")
    FMDFMesg:setString("98")
    playBackMusic("music/background.mp3", true)
    AudioEngine.playEffect("music/vioceparents2.mp3")
    return layer
end
function runtan_fumu2Layer()
    cclog("LogoLayer")
    local scene = CCScene:create()
    scene:addChild(_tan_fumu2Layer())
    return scene
end