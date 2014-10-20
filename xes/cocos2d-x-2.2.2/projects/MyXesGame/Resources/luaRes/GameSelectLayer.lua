
require "CCBReaderLoad"
require "luaRes/tan_baby"
cclog = function(...)
    print(string.format(...))
end
local layer = nil 
GameSelectLayer = GameSelectLayer or {}
ccb["GameSelectLayer"] = GameSelectLayer
local function buttonEnd( _type )
    -- body
    -- AudioEngine.stopMusic()
    if _type==3 or _type==1 or _type==2 then 
        AudioEngine.playEffect("music/buttonchild.wav")
     local _scenes=runGame2Layer()
     CCDirector:sharedDirector():replaceScene(_scenes)
    end 
    if _type==6 then 
AudioEngine.playEffect("music/buttonchild.wav")
        local _scenes = runWorldMapLayer()
        CCDirector:sharedDirector():replaceScene(_scenes)
    end 
end 
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
       buttonEnd(1)
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
      buttonEnd(2)
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
        buttonEnd(3)
    elseif controlEvent == CCControlEventTouchUpOutside then
        
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
local function buttonFour(eventName,control,controlEvent)

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
       buttonEnd(4)
    elseif controlEvent == CCControlEventTouchUpOutside then
       
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
local function buttonFive(eventName,control,controlEvent)

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
        buttonEnd(5)
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
        buttonEnd(6)
        
    elseif controlEvent == CCControlEventTouchUpOutside then
       
    elseif controlEvent == CCControlEventTouchCancel then
        cclog("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        cclog("Value Changed.") 
    end
end
GameSelectLayer["buttonBack"]=buttonBack
GameSelectLayer["buttonOne"]=buttonOne
GameSelectLayer["buttonTwo"]=buttonTwo
GameSelectLayer["buttonThree"]=buttonThree
GameSelectLayer["buttonFour"]=buttonFour
GameSelectLayer["buttonFive"]=buttonFive
local function _GameSelectLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------Game1Layer")
    local  node  = CCBuilderReaderLoad("ccbi/GameSelectLayer.ccbi",proxy,GameSelectLayer)
    layer = tolua.cast(node,"CCLayer")
    playBackMusic("music/background.mp3", true)
    local spriteThree = tolua.cast(GameSelectLayer["spriteThree"],"CCSprite")
    local temp =getxdjAni()
    spriteThree:runAction(CCRepeatForever:create(temp))
    return layer
end

function runGameSelectLayerLayer()
    cclog("Game1Layer")
    local scene = CCScene:create()
    scene:addChild(_GameSelectLayer())
    return scene
end