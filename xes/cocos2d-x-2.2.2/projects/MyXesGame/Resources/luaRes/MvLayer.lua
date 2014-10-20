require "CCBReaderLoad"
-- require "GameSelectLayer"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
MvLayer = MvLayer or {}
ccb["MvLayer"] = MvLayer
local function showEG()
    -- body
    local function showAction()
        -- body
   local bu = tolua.cast(MvLayer["toEG"],"CCControlButton")
   local mesg=tolua.cast(MvLayer["mesg"],"CCSprite")
   bu:setVisible(true)
   mesg:setVisible(true)
    end
    local  pCallback = CCCallFunc:create(showAction)
    local arr = CCArray:create()
    arr:addObject(CCDelayTime:create(1))
    arr:addObject(pCallback)
    local  pSequence = CCSequence:create(arr)
    local bu = tolua.cast(MvLayer["toEG"],"CCControlButton")
    bu:runAction(pSequence)
   
end
local function buttonBack(eventName,control,controlEvent)
    if controlEvent == CCControlEventTouchUpInside then
    AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    local _scenes = runGameSelectLayerLayer()
     CCDirector:sharedDirector():replaceScene(_scenes)
end

end
local function buttonPlay( eventName,control,controlEvent)
    -- body
    cclog("________________________111")
    if controlEvent == CCControlEventTouchUpInside then
    AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    cclog("________________________111")
    Platform:playVideo()
    cclog("________________________")
    showEG()
    end 
end
local function buttonToEG(eventName,control,controlEvent )
    -- body
 if controlEvent == CCControlEventTouchUpInside then
    AudioEngine.stopAllEffects()
    AudioEngine.playEffect("music/buttonchild.wav")
    local _scenes = runMySelfLayer()
     CCDirector:sharedDirector():replaceScene(_scenes)
 end 
end
MvLayer["buttonToEG"]=buttonToEG
MvLayer["buttonPlay"]=buttonPlay
MvLayer["buttonBack"]=buttonBack
local function _MvLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    local  node  = CCBuilderReaderLoad("ccbi/MvLayer.ccbi",proxy,MvLayer)
    layer = tolua.cast(node,"CCLayer")
    stopBackMusic()
    AudioEngine.playEffect("music/voicechild3.mp3")
    return layer
end
function runMvLayer()
    cclog("LogoLayer")
    local scene = CCScene:create()
    scene:addChild(_MvLayer())
    return scene
end