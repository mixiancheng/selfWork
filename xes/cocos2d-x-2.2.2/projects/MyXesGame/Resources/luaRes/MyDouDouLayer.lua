
require "CCBReaderLoad"
cclog = function(...)
    print(string.format(...))
end
local layer = nil 
MyDouDouLayer = MyDouDouLayer or {}
ccb["MyDouDouLayer"] = MyDouDouLayer
local function buttonBack(eventName,control,controlEvent)

  if controlEvent == CCControlEventTouchDown  then         
    elseif controlEvent == CCControlEventTouchDragInside then
        cclog("Touch Drag Inside.") 
    elseif controlEvent == CCControlEventTouchDragOutside then
        cclog("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        cclog("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        cclog("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        AudioEngine.playEffect("music/buttonchild.wav")
        local _scenes = runMySelfLayer()
        CCDirector:sharedDirector():replaceScene(_scenes)
    elseif controlEvent == CCControlEventTouchUpOutside then
       
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
MyDouDouLayer["buttonBack"]=buttonBack
local function _MyDouDouLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------MyDouDouLayer")
    local  node  = CCBuilderReaderLoad("ccbi/MyDouDouLayer.ccbi",proxy,MyDouDouLayer)
    layer = tolua.cast(node,"CCLayer")
    return layer
end

function runMyDouDouLayer()
    cclog("MyDouDouLayer")
    local scene = CCScene:create()
    scene:addChild(_MyDouDouLayer())
    -- local l=InitPauseLayer()
    -- scene:addChild(InitPauseLayer())
    return scene
end