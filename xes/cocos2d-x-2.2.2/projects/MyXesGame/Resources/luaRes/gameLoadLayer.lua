require "CCBReaderLoad"
require "luaRes/WorldMapLayer"
require "luaRes/Player"
cclog = function(...)
    print(string.format(...))
end
local layer = nil
local function gameLoadFinsh()
    cclog("进入大地图")
    -- AudioEngine.stopMusic()
    local nextLayer = runWorldMapLayer()
    CCDirector:sharedDirector():replaceScene(nextLayer)
end
local function showActionFinsh()
    -- body
    local action = CCSequence:createWithTwoActions(
        CCDelayTime:create(2),
        CCCallFunc:create(LoadFinsh))
    layer:runAction(action)
end

local function _gameLoadingLayer()
    layer=CCLayer:create()
    local back = CCSprite:create("load/logoback.png")
    local _ani = CCSprite:create("load/lo_0001.png")
    back:setAnchorPoint(ccp(0,0))
    layer:addChild(back)
    layer:addChild(_ani)
    _ani:setPositionX(512)
    _ani:setPositionY(386)
    _ani:setAnchorPoint(ccp(0.5,0.5))
    local temp =getLoadAni()
    _ani:runAction(CCRepeatForever:create(temp))

    local  pCallback = CCCallFunc:create(gameLoadFinsh)
    local arr = CCArray:create()
    arr:addObject(CCDelayTime:create(2))
    arr:addObject(pCallback)
    local  pSequence = CCSequence:create(arr)
    layer:runAction(pSequence)
    playBackMusic("music/background.mp3", true)
    return layer
end
function rungameLoadingLayer()
    cclog("LogoLayer")
    local scene = CCScene:create()
    scene:addChild(_gameLoadingLayer())
    return scene
end