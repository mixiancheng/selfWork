require "MyMapLayer"
local GameScene = class("GameScene")
GameScene.__index = GameScene
--GameScene._MapLayer= nil
GameScene._widget = nil
function GameScene.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, GameScene)
    return target
end
function GameScene:init()
--   self._MapLayer= CreatMapLayer()
--    self._MapLayer:setPosition(100,100);
    self:addChild(CreatMapLayer())
end
function GameScene.create()
    local scene = cc.Scene:create()
    local layer = GameScene.extend(cc.Layer:create())
    layer:init()
    scene:addChild(layer)
    return scene   
end 
function runGameScene()
    local _scene = GameScene.create()
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(_scene)
    else
        cc.Director:getInstance():runWithScene(_scene)
    end
end