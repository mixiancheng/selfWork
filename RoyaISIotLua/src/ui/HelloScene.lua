require "Cocos2d"
local _main = require("main_pb")
local scheduler = cc.Director:getInstance():getScheduler()
local s = cc.Director:getInstance():getWinSize()
local HelloScene = class("HelloScene")
HelloScene.__index = HelloScene
HelloScene._uiLayer= nil
HelloScene._widget = nil
HelloScene._sceneTitle = nil
HelloScene.Name=nil
HelloScene.Pass=nil
function HelloSceneLayerStep(dt) --@return typeOrObject
end
function HelloScene.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, HelloScene)
    return target
end
function HelloScene:init()
    self._uiLayer = cc.Layer:create()
    self:addChild(self._uiLayer)
--    self._widget = ccs.GUIReader:getInstance():widgetFromJsonFile("res/battle/BattleMap_test_1.json")
    self._widget =ccs.GUIReader:getInstance():widgetFromJsonFile("res/DemoLogin_1/DemoLogin.json")
--    self._widget:setPosition(521,350)
    self._uiLayer:addChild(self._widget)
    local root = self._uiLayer:getChildByTag(1)
    self.Name=root:getChildByName("name_TextField")
    self.Pass=root:getChildByName("password_TextField")
    require "Network"
    cclog("git")
    Network.netInit()
    Network.Connect("fbjellydev.topgame.com", 3000)
--    Network.Connect("localhost", 1235)
    local function nextCallback(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            function fnUserLogin(cbName, dictData, bRet)
                local strInfo = string.char(unpack(dictData))
                local _newRes=_main.Response()
--                local _newRes=_main.LoginResponse()
                _newRes:ParseFromString(strInfo)
                print("nextCallback---\n"..text_format.msg_format(_newRes))
            end
--            local _res=_main.LoginResponse()
--            _res.fid=""
--            _res.uid=11
--            _res.token="token"
--            _res.ret=0
            local _res=_main.Request()
            local _login=_res.login
            local _str=_res:SerializeToString() 
            Network.rpc(fnUserLogin,"main", "main",_str, true)
    end 
       local person_pb=require("person_pb")
                local person=person_pb.Person()
                person.id=1001
                person.name=_name
                person.email=_pass
                cclog("------>")
        local _data=person.data:add()
        _data="test"
        print("person---\n"..text_format.msg_format(person))
--                local _data=person:SerializeToString()
--                require "Network"
--                Network.netInit()
--                Network.connect("localhost", 1235)
--                Network.rpc(fnUserLogin,"user.userLogin", "user.userLogin", "person", true)
--        end
    end
    local right_button = root:getChildByName("login_Button")
    right_button:addTouchEventListener(nextCallback)
end
function HelloScene.create()
    local scene = cc.Scene:create()
    local layer = HelloScene.extend(cc.Layer:create())
    layer:init()
    scene:addChild(layer)
    return scene   
end 
function runCocosHelloScene()
    local _scene = HelloScene.create()
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(_scene)
    else
        cc.Director:getInstance():runWithScene(_scene)
    end
end