
require "CCBReaderLoad"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
MainMenuLayer = MainMenuLayer or {}
ccb["MainMenuLayer"] = MainMenuLayer
local function startButton(eventName,control,controlEvent)
    -- body
    local labelTTF = tolua.cast(MainMenuLayer["mCCControlEventLabel"],"CCLabelTTF")

    if nil == labelTTF then
        return
    end
    if controlEvent == CCControlEventTouchDown  then      
        labelTTF:setString("Touch Down.")        
    elseif controlEvent == CCControlEventTouchDragInside then
        labelTTF:setString("Touch Drag Inside.") 
    elseif controlEvent == CCControlEventTouchDragOutside then
        labelTTF:setString("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        labelTTF:setString("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        labelTTF:setString("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        labelTTF:setString("Touch Up Inside.") 
    elseif controlEvent == CCControlEventTouchUpOutside then
        labelTTF:setString("Touch Up Outside.") 
    elseif controlEvent == CCControlEventTouchCancel then
        labelTTF:setString("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        labelTTF:setString("Value Changed.") 
    end
     labelTTF:setString("startButton")
--      local spr = CCSprite:create("clickme.png")
--      spr:setAnchorPoint(ccp(0,0))
--      spr:setPosition(200,600)
--      layer:addChild(spr)
--      local function Ripple3DDemo(t)
--     return CCRipple3D:create(t, CCSizeMake(32,24), ccp(200,600), 240, 4, 160);
-- end
--     local action = Ripple3DDemo(2)
--     spr:runAction(action)
end
local function moreButton(eventName,control,controlEvent)
    -- body
    local labelTTF = tolua.cast(MainMenuLayer["mCCControlEventLabel"],"CCLabelTTF")

    if nil == labelTTF then
        return
    end

    if controlEvent == CCControlEventTouchDown  then      
        labelTTF:setString("Touch Down.")        
    elseif controlEvent == CCControlEventTouchDragInside then
        labelTTF:setString("Touch Drag Inside.") 
    elseif controlEvent == CCControlEventTouchDragOutside then
        labelTTF:setString("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        labelTTF:setString("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        labelTTF:setString("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        labelTTF:setString("Touch Up Inside.") 
    elseif controlEvent == CCControlEventTouchUpOutside then
        labelTTF:setString("Touch Up Outside.") 
    elseif controlEvent == CCControlEventTouchCancel then
        labelTTF:setString("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        labelTTF:setString("Value Changed.") 
    end
     labelTTF:setString("moreButton")
end
local function setButton(eventName,control,controlEvent)
    -- body
    local labelTTF = tolua.cast(MainMenuLayer["mCCControlEventLabel"],"CCLabelTTF")

    if nil == labelTTF then
        return
    end

    if controlEvent == CCControlEventTouchDown  then      
        labelTTF:setString("Touch Down.")        
    elseif controlEvent == CCControlEventTouchDragInside then
        labelTTF:setString("Touch Drag Inside.") 
    elseif controlEvent == CCControlEventTouchDragOutside then
        labelTTF:setString("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        labelTTF:setString("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        labelTTF:setString("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        labelTTF:setString("Touch Up Inside.") 
    elseif controlEvent == CCControlEventTouchUpOutside then
        labelTTF:setString("Touch Up Outside.") 
    elseif controlEvent == CCControlEventTouchCancel then
        labelTTF:setString("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        labelTTF:setString("Value Changed.") 
    end
     labelTTF:setString("setButton")
end
local function aboutButton(eventName,control,controlEvent)
    -- body
    local sp=HSpriteCPP:hspriteWithFile("menu1.png")
    sp:setPosition(ccp(600, 600))
    layer:addChild(sp)
    local labelTTF = tolua.cast(MainMenuLayer["mCCControlEventLabel"],"CCLabelTTF")

    if nil == labelTTF then
        return
    end

    if controlEvent == CCControlEventTouchDown  then      
        labelTTF:setString("Touch Down.")        
    elseif controlEvent == CCControlEventTouchDragInside then
        labelTTF:setString("Touch Drag Inside.") 
    elseif controlEvent == CCControlEventTouchDragOutside then
        labelTTF:setString("Touch Drag Outside.") 
    elseif controlEvent == CCControlEventTouchDragEnter then
        labelTTF:setString("Touch Drag Enter.") 
    elseif controlEvent == CCControlEventTouchDragExit then
        labelTTF:setString("Touch Drag Exit.") 
    elseif controlEvent == CCControlEventTouchUpInside then
        labelTTF:setString("Touch Up Inside.") 
    elseif controlEvent == CCControlEventTouchUpOutside then
        labelTTF:setString("Touch Up Outside.") 
    elseif controlEvent == CCControlEventTouchCancel then
        labelTTF:setString("Touch Cancel.") 
    elseif controlEvent == CCControlEventValueChanged  then
        labelTTF:setString("Value Changed.") 
    end
    labelTTF:setString("aboutButton")
end
local function menuClick()
    -- body
    cclog("-------------------")
    if nil ~= MainMenuLayer["mAnimationManager"] then  
            local animationMgr = tolua.cast(MainMenuLayer["mAnimationManager"],"CCBAnimationManager")  
            if nil ~= animationMgr then  
                animationMgr:runAnimationsForSequenceNamedTweenDuration("moveAni", 0)  --执行myClick动画  
            end  
        end  
end
local function moveMidle()
    -- body
    cclog("movemiddle")
	cclog("")
end
local function doStep(  )
    -- body
    -- cclog("dostep")
end 
local function onTouch(event, x, y)

    cclog("ontouch")

    return true
end
MainMenuLayer["startButton"]=startButton
MainMenuLayer["moreButton"]=moreButton
MainMenuLayer["setButton"]=setButton
MainMenuLayer["aboutButton"]=aboutButton
MainMenuLayer["menuA"]=menuClick
-- MainMenuLayer["movemidle"]=moveMidle
local function MainMenuLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------MainMenuLayer")
    local  node  = CCBuilderReaderLoad("ccbi/MainMenuLayer.ccbi",proxy,MainMenuLayer)
    layer = tolua.cast(node,"CCLayer")
    local pLable = CCLabelTTF:create("workInLua!!!!!!!!!!!!!!!!", "Marker Felt", 30)
    pLable:setPosition(ccp(size.width / 2, size.height))
    pLable:setAnchorPoint(ccp(0.5,1))
    pLable:setColor(ccc3(255, 0, 0))
    layer:addChild(pLable)
    
    CCArmatureDataManager:sharedArmatureDataManager():addArmatureFileInfo("armature/Cowboy.ExportJson")
    local armature = CCArmature:create("Cowboy")
    armature:getAnimation():playWithIndex(0)
    local num = 3/4
    armature:setPosition(ccp(size.width / 4, size.height/4))
    armature:setScaleX(-0.24)
    armature:setScaleY(0.24)
    layer:addChild(armature)
    local armature1 = CCArmature:create("Cowboy")
    armature1:getAnimation():playWithIndex(0)
    armature1:setPosition(ccp(size.width*num, size.height/4))
    armature1:setScaleX(0.24)
    armature1:setScaleY(0.24)
    layer:addChild(armature1)
    layer:scheduleUpdateWithPriorityLua(doStep, 0)
    layer:setTouchEnabled(true)
    layer:registerScriptTouchHandler(onTouch)
    return layer
end
function runCocosBuilder()
    cclog("HelloCCBSceneTestMain")
    local scene = CCScene:create()
    scene:addChild(MainMenuLayer())
    return scene
end
