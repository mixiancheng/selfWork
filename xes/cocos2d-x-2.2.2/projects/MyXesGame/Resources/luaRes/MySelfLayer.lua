
require "CCBReaderLoad"
require "luaRes/MyDouDouLayer"
cclog = function(...)
    print(string.format(...))
end
local layer = nil 
MySelfLayer = MySelfLayer or {}
ccb["MySelfLayer"] = MySelfLayer
local function buttonOne(eventName,control,controlEvent)

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
    elseif controlEvent == CCControlEventTouchUpOutside then
        
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
local function buttonTwo(eventName,control,controlEvent)

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
      local _scenes = runMyDouDouLayer()
        CCDirector:sharedDirector():replaceScene(_scenes)
    elseif controlEvent == CCControlEventTouchUpOutside then
        
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
local function buttonThree(eventName,control,controlEvent)

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
    elseif controlEvent == CCControlEventTouchUpOutside then
        
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
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
        local _scenes = runWorldMapLayer()
        CCDirector:sharedDirector():replaceScene(_scenes)
    elseif controlEvent == CCControlEventTouchUpOutside then
       
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
MySelfLayer["buttonBack"]=buttonBack
MySelfLayer["buttonOne"]=buttonOne
MySelfLayer["buttonTwo"]=buttonTwo
MySelfLayer["buttonThree"]=buttonThree
local function _MySelfLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------Game1Layer")
    local  node  = CCBuilderReaderLoad("ccbi/MySelfLayer.ccbi",proxy,MySelfLayer)
    layer = tolua.cast(node,"CCLayer")
    playBackMusic("music/background.mp3", true)
    return layer
end

function runMySelfLayer()
    local scene = CCScene:create()
    scene:addChild(_MySelfLayer())
    -- local l=InitPauseLayer()
    -- scene:addChild(InitPauseLayer())
    return scene
end