
require "CCBReaderLoad"
require "luaRes/Game1Layer"
cclog = function(...)
    print(string.format(...))
end
local layer = nil 
GameSelectBothLayer = GameSelectBothLayer or {}
ccb["GameSelectBothLayer"] = GameSelectBothLayer
local function buttonOne(eventName,control,controlEvent)
    cclog("GameSelectBothLayer---->")
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
       -- local _scenes = runGame1Layer()
       local _scenes = runTest()
        CCDirector:sharedDirector():replaceScene(_scenes)
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
        -- local _scenes = runtan_fumu1Layer()

        CCDirector:sharedDirector():replaceScene(_scenes)
    elseif controlEvent == CCControlEventTouchUpOutside then
       
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
GameSelectBothLayer["buttonBack"]=buttonBack
GameSelectBothLayer["buttonOne"]=buttonOne
local function _GameSelectBothLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------Game1Layer")
    local  node  = CCBuilderReaderLoad("ccbi/GameSelectBothLayer.ccbi",proxy,GameSelectBothLayer)
    layer = tolua.cast(node,"CCLayer")
    playBackMusic("music/background.mp3", true)
    local spriteThree = tolua.cast(GameSelectBothLayer["spriteShow"],"CCSprite")
    local temp =getddjAni()
    spriteThree:runAction(CCRepeatForever:create(temp))
    return layer
end

function runGameGameSelectBothLayer()
    cclog("Game1Layer")
    local scene = CCScene:create()
    scene:addChild(_GameSelectBothLayer())
    -- local l=InitPauseLayer()
    -- scene:addChild(InitPauseLayer())
    return scene
end