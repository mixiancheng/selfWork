local GameView = class("GameView")
GameView.__index = GameView
GameView._uiLayer= nil
GameView._widget = nil
GameView._gamescene = nil
function GameView.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, GameView)
    return target
end
--添加LHJ层
function GameView:addGameLayer(_x,_y)
    require "GameLayer"
    local _gameLayer=CreatGameLayer()
    _gameLayer:setAnchorPoint(0,0)
    _gameLayer:setPosition(_x,_y)
    self:addChild(_gameLayer)
end
--页面初始化
function GameView:init()
    self._uiLayer = cc.Layer:create()
    self:addChild(self._uiLayer)

    self._widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/gameui/LHJ_1/LHJ_1.json")
    self._uiLayer:addChild(self._widget)
    local root = self._uiLayer:getChildByTag(10)
    self._gamescene = root:getChildByName("gameView")
    local _x=self._gamescene:getPositionX()
    local _y=self._gamescene:getPositionY()
    self:addGameLayer(_x,_y)
    local function spinCallback(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            spin()
        end
    end
    local Button_close=root:getChildByName("Button_close")
    Button_close:addTouchEventListener(spinCallback)
    
end
function GameView.create()
    local layer = GameView.extend(cc.Layer:create())
    layer:init()
    return layer   
end
function CreatGameView(_x,_y)
	local _layer=GameView.create()
    _layer:setAnchorPoint(cc.p(0,0))
    _layer:setPosition(_x,_y)
	return _layer
end
function CreatGameView()
	local _scene=cc.Scene:create()
	local _layer=GameView.create()
	_scene:addChild(_layer)
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(_scene)
    else
        cc.Director:getInstance():runWithScene(_scene)
    end
end