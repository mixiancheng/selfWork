require "CCBReaderLoad"
-- require "GameSelectLayer"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
tan_baby = tan_baby or {}
ccb["tan_baby"] = tan_baby
local function buttonStop()
    cclog("buttonBack------->")
    -- AudioEngine.stopMusic()
    AudioEngine.playEffect("music/buttonchild.wav")
    local s = runGameSelectLayerLayer()
    CCDirector:sharedDirector():replaceScene(s)
    AudioEngine.stopAllEffects()
end
local function buttonNext( )
    -- body
    cclog("buttonRgame------->")
    -- AudioEngine.stopMusic()
    AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
-- local s = runWorldMapLayer()
   local _scenes = runGame2Layer()
   CCDirector:sharedDirector():replaceScene(_scenes)
   -- AudioEngine.stopAllEffects()
   -- AudioEngine.playEffect("music/viocechild2.mp3")
end

tan_baby["buttonStop"]=buttonStop
tan_baby["buttonNext"]=buttonNext
local function _tan_babyLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    local  node  = CCBuilderReaderLoad("ccbi/tan_baby.ccbi",proxy,tan_baby)
    layer = tolua.cast(node,"CCLayer")
    playBackMusic("music/background.mp3", true)
    AudioEngine.playEffect("music/viocechild1.mp3")
    return layer
end
function runtan_babyLayer()
    cclog("LogoLayer")
    local scene = CCScene:create()
    scene:addChild(_tan_babyLayer())
    return scene
end