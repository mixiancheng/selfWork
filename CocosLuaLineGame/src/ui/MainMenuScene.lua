require "Cocos2d"
local scheduler = cc.Director:getInstance():getScheduler()
local s = cc.Director:getInstance():getWinSize()
local MainMenuScene = class("MainMenuScene")
MainMenuScene.__index = MainMenuScene
MainMenuScene._uiLayer= nil
MainMenuScene._widget = nil
function MainMenuScene.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, MainMenuScene)
    return target
end
function MainMenuScene:init()
    self._uiLayer = cc.Layer:create()
    self:addChild(self._uiLayer)
    self._widget =ccs.GUIReader:getInstance():widgetFromJsonFile("LineGame_Menu.json")
    self._uiLayer:addChild(self._widget)
    local root = self._uiLayer:getChildByTag(3)
    local Panel_Menu=root:getChildByName("Panel_Menu")
    local function eventButton_Begin(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            cclog("Button_Begin----->")
            require "GameScene"
            runGameScene()
        end 
    end
    local Button_Begin = Panel_Menu:getChildByName("Button_Begin")
    Button_Begin:addTouchEventListener(eventButton_Begin)
    local function eventButton_Seting(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            cclog("Button_Seting----->")
            
        end 
    end
    local Button_Seting = Panel_Menu:getChildByName("Button_Seting")
    Button_Seting:addTouchEventListener(eventButton_Seting)
    local function eventButton_About(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            cclog("Button_About----->")
        end 
    end
    local Button_About = Panel_Menu:getChildByName("Button_About")
    Button_About:addTouchEventListener(eventButton_About)
    local function eventButton_Exit(sender, eventType)
        if eventType == ccui.TouchEventType.ended then 
            cclog("Button_Exit----->")
            cc.Director:getInstance():endToLua()
        end 
    end
    local Button_Exit = Panel_Menu:getChildByName("Button_Exit")
    Button_Exit:addTouchEventListener(eventButton_Exit)
    
--    require "LineObj"
--    local _tes=LineObjCreat(LintObjType.one,9,9)
--    self:addChild(_tes)
end
function MainMenuScene.create()
    local scene = cc.Scene:create()
    local layer = MainMenuScene.extend(cc.Layer:create())
    layer:init()
--    local layer= cc.LayerColor:create(cc.c4b(192, 0, 0, 255),200,200)
 
    scene:addChild(layer)
    return scene   
end 
function runMainMenuScene()
    local _scene = MainMenuScene.create()
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(_scene)
    else
        cc.Director:getInstance():runWithScene(_scene)
    end
end