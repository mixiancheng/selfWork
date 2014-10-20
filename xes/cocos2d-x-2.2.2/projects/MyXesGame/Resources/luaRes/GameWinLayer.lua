
require "CCBReaderLoad"
require "AudioEngine"
cclog = function(...)
    print(string.format(...))
end
GameWinLayer = GameWinLayer or {}
ccb["GameWinLayer"] = GameWinLayer
local function LoadFinsh()
    cclog("进入大地图")
    local nextLayer = runWorldMapLayer()
    CCDirector:sharedDirector():replaceScene(nextLayer)
end
local function buttonRgame(eventName,control,controlEvent)
    -- body
    AudioEngine.playEffect("music/buttonchild.wav")
    local nextLayer = runRichLayer()
    CCDirector:sharedDirector():replaceScene(nextLayer)
end
local function buttonBack(eventName,control,controlEvent)
    -- body
    local nextLayer = runWorldMapLayer()
    CCDirector:sharedDirector():replaceScene(nextLayer)
end
GameWinLayer["buttonRgame"]=buttonRgame
GameWinLayer["buttonBack"]=buttonBack
local function _GameWinLayer(win)
    local size = CCDirector:sharedDirector():getWinSize()
    local  proxy = CCBProxy:create()
    -- cclog("-------Game2Layer")
    local  node  = CCBuilderReaderLoad("ccbi/GameWinLayer.ccbi",proxy,GameWinLayer)
    layer = tolua.cast(node,"CCLayer")
    local _win=tolua.cast(GameWinLayer["_gameWin"],"CCSprite")
    local _fal=tolua.cast(GameWinLayer["_gameFal"],"CCSprite")
    local _titlewin=tolua.cast(GameWinLayer["titleWin"],"CCSprite")
    local _titlefal=tolua.cast(GameWinLayer["titleFal"],"CCSprite")
    if win then _fal:setVisible(false) _titlefal:setVisible(false)  
    AudioEngine.playEffect("music/success.wav")
    else 
        AudioEngine.playEffect("music/fail.mp3")
        _win:setVisible(false)  _titlewin:setVisible(false)
    end
    -- local action = CCSequence:createWithTwoActions(
    --     CCDelayTime:create(2),
    --     CCCallFunc:create(LoadFinsh))
    -- layer:runAction(action)
    -- layer:scheduleUpdateWithPriorityLua(step, 0)
    return layer
end

function runGameWinLayer(win)
    cclog("GameWinLayer")
    local scene = CCScene:create()
    scene:addChild(_GameWinLayer(win))
    return scene
end