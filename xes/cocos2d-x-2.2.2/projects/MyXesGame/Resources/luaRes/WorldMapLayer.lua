
require "CCBReaderLoad"
require "luaRes/Game1Layer"
require "luaRes/Game2Layer"
require "luaRes/GameSelectBothLayer"
require "luaRes/MySelfLayer"
require "luaRes/RichLayer"
require "luaRes/Game2DoubleLayer"
cclog = function(...)
    print(string.format(...))
end
local MapIndex={}
curMapIndex=4
curMapIndexPlay=1
local showNum={}
showNum[1]={close=CCTextureCache:sharedTextureCache():addImage("ui/1_close.png"),open=CCTextureCache:sharedTextureCache():addImage("ui/1_open.png"),cur=CCTextureCache:sharedTextureCache():addImage("ui/1_cur.png")}
showNum[2]={close=CCTextureCache:sharedTextureCache():addImage("ui/2_close.png"),open=CCTextureCache:sharedTextureCache():addImage("ui/2_open.png"),cur=CCTextureCache:sharedTextureCache():addImage("ui/2_cur.png")}
showNum[3]={close=CCTextureCache:sharedTextureCache():addImage("ui/3_close.png"),open=CCTextureCache:sharedTextureCache():addImage("ui/3_open.png"),cur=CCTextureCache:sharedTextureCache():addImage("ui/3_cur.png")}
showNum[4]={close=CCTextureCache:sharedTextureCache():addImage("ui/4_close.png"),open=CCTextureCache:sharedTextureCache():addImage("ui/4_open.png"),cur=CCTextureCache:sharedTextureCache():addImage("ui/4_cur.png")}
showNum[5]={close=CCTextureCache:sharedTextureCache():addImage("ui/5_close.png"),open=CCTextureCache:sharedTextureCache():addImage("ui/5_open.png"),cur=CCTextureCache:sharedTextureCache():addImage("ui/5_cur.png")}
local showNumSprite=nil 
local function initShowNumSprite(curIndex)
    -- body
    cclog("curIndex-------------->"..curIndex)
    showNumSprite=nil
    local backAni={}
    showNumSprite={}
    local temp =nil
    local back =nil
    temp=tolua.cast(WorldMapLayer["spriteOne"],"CCSprite")
    back=tolua.cast(WorldMapLayer["backAniOne"],"CCSprite")
    table.insert(showNumSprite,temp)
    table.insert(backAni,back)
    temp=tolua.cast(WorldMapLayer["spriteTwo"],"CCSprite")
    back=tolua.cast(WorldMapLayer["backAniTwo"],"CCSprite")
    table.insert(showNumSprite,temp)
    table.insert(backAni,back)
    temp=tolua.cast(WorldMapLayer["spriteThree"],"CCSprite")
    back=tolua.cast(WorldMapLayer["backAniThree"],"CCSprite")
    table.insert(showNumSprite,temp)
    table.insert(backAni,back)
    temp=tolua.cast(WorldMapLayer["spriteFour"],"CCSprite")
    back=tolua.cast(WorldMapLayer["backAniFour"],"CCSprite")
    table.insert(showNumSprite,temp)
    table.insert(backAni,back)
    temp=tolua.cast(WorldMapLayer["spriteFive"],"CCSprite")
    back=tolua.cast(WorldMapLayer["backAniFive"],"CCSprite")
    table.insert(showNumSprite,temp)
    table.insert(backAni,back)
    for i,v in ipairs(showNumSprite) do
        cclog("i========"..i)
     if i<curIndex then 
     v:setTexture(showNum[i].open)
     MapIndex[i]._s:stopAllActions()
     end 
    if i==curIndex then 
        cclog("curIndex-------------->"..curIndex)
    v:setTexture(showNum[i].cur)
    local actionBy = CCMoveBy:create(2, ccp(20, -20))
    local actionByBack = actionBy:reverse()
    MapIndex[i]._s:runAction(CCRepeatForever:create(CCSequence:createWithTwoActions(actionBy, actionByBack)))
    backAni[i]:runAction(CCRepeatForever:create(getdjfgAni()))
    end 
     if i>curIndex then 
     MapIndex[i]._s:stopAllActions()
     v:setTexture(showNum[i].close)
     end 
    end
end
function FinshMapIndex()
    -- body
    if curMapIndexPlay==curMapIndex then 
        curMapIndex=curMapIndex+1
    end 
    if curMapIndex>5 then curMapIndex=5 end 
end
local layer = nil
WorldMapLayer = WorldMapLayer or {}
ccb["WorldMapLayer"] = WorldMapLayer
local function InitWorldMap()
    -- body
end
local function setMapIndex( _index )
    -- body
    -- curMapIndex=_index
    cclog("curMapIndex=====>"..curMapIndex)
    for i,v in ipairs(MapIndex) do
        v._s:setVisible(false)
        if i>curMapIndex then 
            v._b:setHighlighted(false)
            v._b:setEnabled(false)
            -- v._s:setVisible(false)
        end 
        if i==curMapIndex then 
            v._b:setHighlighted(true)
            v._s:setVisible(true)
        end 
    end
end
local function InitUI( )
    -- body
    MapIndex=nil 
    MapIndex={}
    local _button = tolua.cast(WorldMapLayer["buttonOne"],"CCControlButton")
    local indexImg = tolua.cast(WorldMapLayer["curOne"],"CCSprite")
    local temp ={}
    temp._b=_button
    temp._s=indexImg
    table.insert(MapIndex,temp)
    _button = tolua.cast(WorldMapLayer["buttonTwo"],"CCControlButton")
    indexImg = tolua.cast(WorldMapLayer["curTwo"],"CCSprite")
    temp ={}
    temp._b=_button
    temp._s=indexImg
    table.insert(MapIndex,temp)
    _button = tolua.cast(WorldMapLayer["buttonThree"],"CCControlButton")
    indexImg = tolua.cast(WorldMapLayer["curThree"],"CCSprite")
    temp ={}
    temp._b=_button
    temp._s=indexImg
    table.insert(MapIndex,temp)
    _button = tolua.cast(WorldMapLayer["buttonFour"],"CCControlButton")
    indexImg = tolua.cast(WorldMapLayer["curFour"],"CCSprite")
    temp ={}
    temp._b=_button
    temp._s=indexImg
    table.insert(MapIndex,temp)
    _button = tolua.cast(WorldMapLayer["buttonFive"],"CCControlButton")
    indexImg = tolua.cast(WorldMapLayer["curFive"],"CCSprite")
    temp ={}
    temp._b=_button
    temp._s=indexImg
    table.insert(MapIndex,temp)
    setMapIndex(curMapIndex)
end
local function buttonEnd( _type )
    -- body
     -- AudioEngine.stopMusic()
     cclog("_type====>".._type) 
    if _type==1 then 
        curMapIndexPlay=1
        AudioEngine.playEffect("music/buttonchild.wav")
     local _scenes = runGameSelectLayerLayer()
     CCDirector:sharedDirector():replaceScene(_scenes)
     end 
    if _type==2 then 
    curMapIndexPlay=2 
        AudioEngine.playEffect("music/buttonchild.wav")
local _scenes = runGameSelectLayerLayer()
     CCDirector:sharedDirector():replaceScene(_scenes)
    end 
    if _type==3 then  
        curMapIndexPlay=3
    AudioEngine.playEffect("music/buttonchild.wav")
    local _scenes = runGameSelectLayerLayer()
     CCDirector:sharedDirector():replaceScene(_scenes)
 end 
    if _type==4 then 
        curMapIndexPlay=4
        AudioEngine.playEffect("music/buttonchild.wav")
        local _scenes = runGameSelectLayerLayer()
     CCDirector:sharedDirector():replaceScene(_scenes)
     end 
    if _type==5 then 
        curMapIndexPlay=5
        AudioEngine.playEffect("music/buttonparents.wav")
     local _scenes = runGameGameSelectBothLayer()
     CCDirector:sharedDirector():replaceScene(_scenes)
      end 
    if _type==6 then 
        AudioEngine.playEffect("music/buttonchild.wav")
        local _scenes = runRichLayer()
     CCDirector:sharedDirector():replaceScene(_scenes)
     end 
    if _type==7 then
        AudioEngine.playEffect("music/buttonchild.wav")
        local _scenes = runMySelfLayer()
        -- CCDirector:sharedDirector():setDepthTest(true)
        -- _scenes = CCTransitionPageTurn:create(1, _scenes, false)
        CCDirector:sharedDirector():replaceScene(_scenes)
      end 
      if _type==8 then
        AudioEngine.playEffect("music/buttonchild.wav")
        -- local _scenes = runMySelfLayer()
        -- CCDirector:sharedDirector():setDepthTest(true)
        -- _scenes = CCTransitionPageTurn:create(1, _scenes, false)
        -- CCDirector:sharedDirector():replaceScene(_scenes)
      end 

end
local function buttonMySlef(eventName,control,controlEvent)
    -- body
   cclog("-----------------------")
   if controlEvent == CCControlEventTouchDown  then      
      
    elseif controlEvent == CCControlEventTouchDragInside then

    elseif controlEvent == CCControlEventTouchDragOutside then

    elseif controlEvent == CCControlEventTouchDragEnter then

    elseif controlEvent == CCControlEventTouchDragExit then

    elseif controlEvent == CCControlEventTouchUpInside then
        buttonEnd(7)
        -- _scenes = CCTransitionCrossFade:create(1, _scenes)
     
    elseif controlEvent == CCControlEventTouchUpOutside then

    elseif controlEvent == CCControlEventTouchCancel then

    elseif controlEvent == CCControlEventValueChanged  then

    end
end
local function buttonRich(eventName,control,controlEvent)
    -- body
   cclog("-----------------------")
   if controlEvent == CCControlEventTouchDown  then      
      
    elseif controlEvent == CCControlEventTouchDragInside then

    elseif controlEvent == CCControlEventTouchDragOutside then

    elseif controlEvent == CCControlEventTouchDragEnter then

    elseif controlEvent == CCControlEventTouchDragExit then

    elseif controlEvent == CCControlEventTouchUpInside then
        buttonEnd(6)
    elseif controlEvent == CCControlEventTouchUpOutside then

    elseif controlEvent == CCControlEventTouchCancel then

    elseif controlEvent == CCControlEventValueChanged  then

    end
end
local function buttonSeting(eventName,control,controlEvent)
    -- body
   cclog("-----------------------")
   if controlEvent == CCControlEventTouchDown  then      
      
    elseif controlEvent == CCControlEventTouchDragInside then

    elseif controlEvent == CCControlEventTouchDragOutside then

    elseif controlEvent == CCControlEventTouchDragEnter then

    elseif controlEvent == CCControlEventTouchDragExit then

    elseif controlEvent == CCControlEventTouchUpInside then
        buttonEnd(8)
    elseif controlEvent == CCControlEventTouchUpOutside then

    elseif controlEvent == CCControlEventTouchCancel then

    elseif controlEvent == CCControlEventValueChanged  then

    end
end
local function buttonGame1(eventName,control,controlEvent)
    -- body
   if controlEvent == CCControlEventTouchDown  then      
      
    elseif controlEvent == CCControlEventTouchDragInside then

    elseif controlEvent == CCControlEventTouchDragOutside then

    elseif controlEvent == CCControlEventTouchDragEnter then

    elseif controlEvent == CCControlEventTouchDragExit then

    elseif controlEvent == CCControlEventTouchUpInside then
        -- 
        buttonEnd(1)
        -- Platform:playVideo()
    elseif controlEvent == CCControlEventTouchUpOutside then

    elseif controlEvent == CCControlEventTouchCancel then

    elseif controlEvent == CCControlEventValueChanged  then

    end
    if 1==curMapIndex then 
    control:setHighlighted(true)
    end
end
local function buttonGame2(eventName,control,controlEvent)
    -- body
   cclog("-----------------------")
   if controlEvent == CCControlEventTouchDown  then      
      
    elseif controlEvent == CCControlEventTouchDragInside then

    elseif controlEvent == CCControlEventTouchDragOutside then

    elseif controlEvent == CCControlEventTouchDragEnter then

    elseif controlEvent == CCControlEventTouchDragExit then

    elseif controlEvent == CCControlEventTouchUpInside then
        buttonEnd(2)
    elseif controlEvent == CCControlEventTouchUpOutside then

    elseif controlEvent == CCControlEventTouchCancel then

    elseif controlEvent == CCControlEventValueChanged  then

    end
    if 2==curMapIndex then 
            control:setHighlighted(true)
            end
end
local function buttonGame3(eventName,control,controlEvent)
    -- body
    cclog("-----------------------")
    if controlEvent == CCControlEventTouchDown  then      
      
    elseif controlEvent == CCControlEventTouchDragInside then

    elseif controlEvent == CCControlEventTouchDragOutside then

    elseif controlEvent == CCControlEventTouchDragEnter then

    elseif controlEvent == CCControlEventTouchDragExit then

    elseif controlEvent == CCControlEventTouchUpInside then
     buttonEnd(3)
    elseif controlEvent == CCControlEventTouchUpOutside then

    elseif controlEvent == CCControlEventTouchCancel then

    elseif controlEvent == CCControlEventValueChanged  then

    end
    if 3==curMapIndex then 
            control:setHighlighted(true)
            end
end
local function buttonGame4(eventName,control,controlEvent)
   cclog("-----------------------")
   if controlEvent == CCControlEventTouchDown  then      
      
    elseif controlEvent == CCControlEventTouchDragInside then

    elseif controlEvent == CCControlEventTouchDragOutside then

    elseif controlEvent == CCControlEventTouchDragEnter then

    elseif controlEvent == CCControlEventTouchDragExit then

    elseif controlEvent == CCControlEventTouchUpInside then
     buttonEnd(4)
    elseif controlEvent == CCControlEventTouchUpOutside then

    elseif controlEvent == CCControlEventTouchCancel then

    elseif controlEvent == CCControlEventValueChanged  then

    end
    if 4==curMapIndex then 
            control:setHighlighted(true)
            end
end
local function buttonGame5(eventName,control,controlEvent)
    -- body
    cclog("-----------------------")
    if controlEvent == CCControlEventTouchDown  then      
      
    elseif controlEvent == CCControlEventTouchDragInside then

    elseif controlEvent == CCControlEventTouchDragOutside then

    elseif controlEvent == CCControlEventTouchDragEnter then

    elseif controlEvent == CCControlEventTouchDragExit then

    elseif controlEvent == CCControlEventTouchUpInside then
        buttonEnd(5)
    elseif controlEvent == CCControlEventTouchUpOutside then

    elseif controlEvent == CCControlEventTouchCancel then

    elseif controlEvent == CCControlEventValueChanged  then

    end
    if 5==curMapIndex then 
            control:setHighlighted(true)
            end
end
WorldMapLayer["buttonBls"]=buttonRich
WorldMapLayer["buttonMySelf"]=buttonMySlef
WorldMapLayer["buttonSeting"]=buttonSeting
WorldMapLayer["buttonGame1"]=buttonGame1
WorldMapLayer["buttonGame2"]=buttonGame2
WorldMapLayer["buttonGame3"]=buttonGame3
WorldMapLayer["buttonGame4"]=buttonGame4
WorldMapLayer["buttonGame5"]=buttonGame5
local function _WorldMapLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------WorldMapLayer")
    local  node  = CCBuilderReaderLoad("ccbi/map.ccbi",proxy,WorldMapLayer)
    layer = tolua.cast(node,"CCLayer")
    InitUI()
    local _sp = tolua.cast(WorldMapLayer["BLSImg"],"CCSprite")
    local ani=getBlsAni()
    _sp:runAction(CCRepeatForever:create(ani))
    playBackMusic("music/background.mp3", true)
    initShowNumSprite(curMapIndex)
    return layer
end
function runWorldMapLayer()
    cclog("WorldMapLayer")
    local scene = CCScene:create()
    scene:addChild(_WorldMapLayer())
    return scene
end
