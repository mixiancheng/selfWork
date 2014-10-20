require "CCBReaderLoad"
require "luaRes/WorldMapLayer"
require "luaRes/gameLoadLayer"
require "luaRes/LoginLayer"
require "luaRes/UserDefault"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
LoadingLayer = LoadingLayer or {}
ccb["LoadingLayer"] = LoadingLayer
local function LoadFinsh()
    cclog("进入大地图")
    local nextLayer = rungameLoadingLayer()
    local name=CCUserDefault:sharedUserDefault():getStringForKey(saveData.userName)
    cclog("saveData.userName==>"..saveData.userName.."name=====>"..name)
    if name==nil or name=="" then  
      nextLayer =runLoginLayer()end 
    nextLayer =runLoginLayer()
    CCDirector:sharedDirector():replaceScene(nextLayer)
end
local function showActionFinsh()
    -- body
    local action = CCSequence:createWithTwoActions(
        CCDelayTime:create(2),
        CCCallFunc:create(LoadFinsh))
    layer:runAction(action)
end
LoadingLayer["showFinsh"]=showActionFinsh
local function _LoadingLayer()
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    cclog("-------LoadingLayer")
    local  node  = CCBuilderReaderLoad("ccbi/load.ccbi",proxy,LoadingLayer)
    layer = tolua.cast(node,"CCLayer")
    local animationMgr = tolua.cast(LoadingLayer["mAnimationManager"],"CCBAnimationManager")
        if nil ~= animationMgr then
            animationMgr:runAnimationsForSequenceNamedTweenDuration("aniAction",0.2)
    end 
    AudioEngine.playMusic("music/logo2.wav", false)
    return layer
end
function runLoadingLayer()
    cclog("LogoLayer")
    local scene = CCScene:create()
    scene:addChild(_LoadingLayer())
    return scene
end