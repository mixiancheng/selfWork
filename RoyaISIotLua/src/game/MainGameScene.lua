userInfo={}
local MainGameScene = class("MainGameScene")
MainGameScene.__index = MainGameScene
MainGameScene._node=nil
MainGameScene._button_home=nil
MainGameScene._button_goldAdd=nil
MainGameScene._button_payTable=nil
MainGameScene._button_seting=nil
MainGameScene._button_email=nil
MainGameScene._button_sound=nil
MainGameScene._button_maxBetSpin=nil
MainGameScene._button_spin=nil
MainGameScene._button_bet_del=nil
MainGameScene._button_bet_add=nil
MainGameScene._bet_text=nil
MainGameScene._allGold_text=nil
MainGameScene._jackPot_text=nil
MainGameScene._lastWin_text=nil
MainGameScene._lv_test=nil
function MainGameScene.extend(target)
    local t = tolua.getpeer(target)
    if not t then
        t = {}
        tolua.setpeer(target, t)
    end
    setmetatable(t, MainGameScene)
    return target
end
function MainGameScene:onEnter()
    cclog("onEnter---->")
end
function MainGameScene:initShowLayer()
    local render = self._node:getChildByTag(10020)
    render:setVisible(false)
    local render = self._node:getChildByTag(10021)
    render:setVisible(false)
    local render = self._node:getChildByTag(10022)
    render:setVisible(false)
    local render = self._node:getChildByTag(10023)
    render:setVisible(false)
    local render = self._node:getChildByTag(10024)
    render:setVisible(false)
    local render = self._node:getChildByTag(10025)
    render:setVisible(false)
    local render = self._node:getChildByTag(10026)
    render:setVisible(false)
    local render = self._node:getChildByTag(10027)
    render:setVisible(false)
end
function MainGameScene:show_free_spin()
    local render = self._node:getChildByTag(10020)
    render:setVisible(true)
    function call_back()
    render:setVisible(false)
    end
    ccs.ActionManagerEx:getInstance():playActionByName("Free_Spin_1024x768.json","show",cc.CallFunc:create(call_back))
end
function MainGameScene:show_bigWin()
cclog("show_bigWin")
    local render = self._node:getChildByTag(10021)
    local _node=render:getChildByTag(1):getChildByTag(10)
    local bigWin_text=_node:getChildByName("bigWin_text")
    local Image_select=_node:getChildByName("Image_select")
    local Button_collect=_node:getChildByName("Button_collect")
    function collect_CallBack(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            cclog("collect_CallBack----->")
            render:setVisible(false)
        end
    end
    Button_collect:addTouchEventListener(collect_CallBack)
    bigWin_text:setString(11111111)--debug
    Image_select:setVisible(true)
    render:setVisible(true)
    ccs.ActionManagerEx:getInstance():playActionByName("BigWin_1024x768.json","show")
end
function MainGameScene:initUserInfo()
    local render = self._node:getChildByTag(10014)
    table.insert(userInfo,render)
    render = self._node:getChildByTag(10015)
    table.insert(userInfo,render)
    render = self._node:getChildByTag(10016)
    table.insert(userInfo,render)
    render = self._node:getChildByTag(10017)
    table.insert(userInfo,render)
    render = self._node:getChildByTag(10018)
    table.insert(userInfo,render)
    render = self._node:getChildByTag(10019)
    table.insert(userInfo,render)
    --    for k,v in ipairs(userInfo) do
    --    	v:setVisible(false)
    --    end
end
function MainGameScene:initGameView()
    local render=self._node:getChildByTag(10011)
    local test = render:getChildByTag(1):getChildByName("Image_34")
    local _x=test:getPositionX()
    local _y=test:getPositionY()
    require "GameLayer"
    local _gameLayer=CreatGameLayer()
    _gameLayer:setAnchorPoint(0,0)
    _gameLayer:setPosition(28,40)
    test:addChild(_gameLayer,100)
end
function MainGameScene:initTextView()
    local render=self._node:getChildByTag(10011)
    local up_title = render:getChildByTag(1):getChildByName("Panel_up")
    local down_title = render:getChildByTag(1):getChildByName("Panel_down")
    self._lv_test=up_title:getChildByName("BitmapLabel_exp")
    self._lv_test:setString("10")
    self._allGold_text=up_title:getChildByName("allGold_text")
    self._allGold_text:setString("9999999")
    self._jackPot_text=up_title:getChildByName("jackpot_text")
    self._jackPot_text:setString("9999999")
    self._bet_text=down_title:getChildByName("bet_text")
    self._bet_text:setString(GameBet[GameBetIndex])
    self._lastWin_text=down_title:getChildByName("lastWin_text")
    self._lastWin_text:setString("99999999")
end
function MainGameScene:initButtonEvent()
    local render=self._node:getChildByTag(10011)
    local up_title = render:getChildByTag(1):getChildByName("Panel_up")
    local down_title = render:getChildByTag(1):getChildByName("Panel_down")
    function home_CallBack(sender, eventType)
        if eventType == ccui.TouchEventType.ended then
            cclog("home_Callback----->")
            self:show_free_spin()
        end
    end
    self._button_home=up_title:getChildByName("Button_home")
    self._button_home:addTouchEventListener(home_CallBack)
   ----------------------------------------------------------
    function goldADD_Callback(sender,eventType)
     if eventType == ccui.TouchEventType.ended then
        cclog("goldADD_Callback--->")
        end
    end
    self._button_goldAdd=up_title:getChildByName("Button_gold_add")
    self._button_goldAdd:addTouchEventListener(goldADD_Callback)
    ----------------------------------------------------------
    function payTable_Callback(sender,eventType)
     if eventType == ccui.TouchEventType.ended then
        cclog("payTable_Callback--->")
        end
    end
    self._button_payTable=up_title:getChildByName("Button_payTable")
    self._button_payTable:addTouchEventListener(payTable_Callback)
    ----------------------------------------------------------
    function seting_Callback(sender,eventType)
     if eventType == ccui.TouchEventType.ended then
        cclog("seting_Callback--->")
        end
    end
    self._button_seting=up_title:getChildByName("Button_seting")
    self._button_seting:addTouchEventListener(seting_Callback)
    ----------------------------------------------------------
    function email_Callback(sender,eventType)
     if eventType == ccui.TouchEventType.ended then
        cclog("email_Callback--->")
        end
    end
    self._button_email=down_title:getChildByName("Button_email")
    self._button_email:addTouchEventListener(email_Callback)
    ----------------------------------------------------------
    function sound_Callback(sender,eventType)
     if eventType == ccui.TouchEventType.ended then
        cclog("sound_Callback--->")
        end
    end
    self._button_sound=down_title:getChildByName("Button_sound")
    self._button_sound:addTouchEventListener(sound_Callback)
    ----------------------------------------------------------
    function bet_del_Callback(sender,eventType)
     if eventType == ccui.TouchEventType.ended then
        changeBet(-1)
        self._bet_text:setString(GameBet[GameBetIndex])
        end
    end
    self._button_bet_del=down_title:getChildByName("Button_dell_bet")
    self._button_bet_del:addTouchEventListener(bet_del_Callback)
    ----------------------------------------------------------
    function bet_add_Callback(sender,eventType)
     if eventType == ccui.TouchEventType.ended then
            changeBet(1)
            self._bet_text:setString(GameBet[GameBetIndex])
        end
    end
    self._button_bet_add=down_title:getChildByName("Button_add_bet")
    self._button_bet_add:addTouchEventListener(bet_add_Callback)
    ----------------------------------------------------------
    function max_bet_spin_Callback(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            cclog("max_bet_spin_Callback--->")
        end
    end
    self._button_maxBetSpin=down_title:getChildByName("Button_maxBet")
    self._button_maxBetSpin:addTouchEventListener(max_bet_spin_Callback)
    ----------------------------------------------------------
    function spin_Callback(sender,eventType)
        if eventType == ccui.TouchEventType.ended then
            spin()
        end
    end
    self._button_spin=down_title:getChildByName("Button_spin")
    self._button_spin:addTouchEventListener(spin_Callback)
end
function MainGameScene:initExpLen()
    local render=self._node:getChildByTag(10011)
    local ProgressBar_exp = render:getChildByTag(1):getChildByName("Panel_up"):getChildByName("ProgressBar_exp")
    ProgressBar_exp:setPercent(50)
end
function MainGameScene:init()
    self._node = ccs.SceneReader:getInstance():createNodeWithSceneFile("mainGameScene_1024x768.json")
    self:initUserInfo()
    self:initGameView()
    self:initExpLen()
    self:initButtonEvent()
    self:initTextView()
    self:initShowLayer()
    self:addChild(self._node)
    return node
end
function MainGameScene:onExit()
    ccs.TriggerMng.destroyInstance()
    ccs.ArmatureDataManager:destroyInstance()
    ccs.SceneReader:destroyInstance()
    ccs.ActionManagerEx:destroyInstance()
    ccs.GUIReader:destroyInstance()
end
function MainGameScene.create()
    local layer = MainGameScene.extend(cc.Layer:create())
    if nil ~= layer then
        layer:init()
        local function onNodeEvent(event)
            if "enter" == event then
                layer:onEnter()
            end
        end
        layer:registerScriptHandler(onNodeEvent)
    end
    return layer
end
function MainGameSceneTest()
    local _scene=cc.Scene:create()
    local _layer=
        --    cc.Layer:create()
        MainGameScene.create()
    _scene:addChild(_layer)
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(_scene)
    else
        cc.Director:getInstance():runWithScene(_scene)
    end
end