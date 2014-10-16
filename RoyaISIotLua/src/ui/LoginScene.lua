LoginScene = class("LoginScene",function()
	return cc.Scene:create()
end)

local kTagCheckNetwork = 10000
local kTagLoginServer = 10001
local kTagConnectFb = 10002

function LoginScene:ctor()
    self.stateId = kTagCheckNetwork
    self.schedulerId = nil
    self.percent = 0
    self.messageStr = "Loading"
    self.dotIdx = 0
end

function LoginScene:init()
    local function scheduleProgress(dt)
        if self.loadingProgressBar:getPercent() < self.percent then
            self.loadingProgressBar:setPercent(self.loadingProgressBar:getPercent()+0.5)
            self.loadingPercentLabel:setString(self.loadingProgressBar:getPercent().."%")
        end
    end
    local uiNode = self.rootNode:getChildByTag(10003):getComponent("GUIComponent"):getNode()
    self.loadingPanel = uiNode:getChildByName("LoadingPanel")
    self.loadingPercentLabel = self.loadingPanel:getChildByName("PercentLabel")
    self.loadingProgressBar = self.loadingPanel:getChildByName("PercentProgress"):getChildByName("PercentProgressBar")
    self.loadingMessageLabel = self.loadingPanel:getChildByName("MessageLabel")
    self.buttonPanel = uiNode:getChildByName("ButtonPanel")
    self.facebookBtn = self.buttonPanel:getChildByName("FacebookBtn")
    self.guestBtn = self.buttonPanel:getChildByName("GuestBtn")
    
    local function callbackFunc(event)
        if kTagCheckNetwork == self.stateId then
            self:checkInternet()
        elseif kTagConnectFb == self.stateId then
        -- do sth
        elseif kTagLoginServer == self.stateId then
            self:loginServer()
        end
    end
    require("MessageUI")
    self.messageUI = createMessageUI(callbackFunc)
    self:addChild(self.messageUI, 1)
    
    self.loadingPanel:setVisible(true)
    self.buttonPanel:setVisible(false)
    self.messageUI:setVisible(false)
    
    self.loadingProgressBar:setPercent(self.percent)
    self.loadingPercentLabel:setString(self.percent.."%")
    self.loadingMessageLabel:setString(self.messageStr)
    
    local function onTouch(sender, eventType)
        if eventType ~= ccui.TouchEventType.ended then
            return
        end
        if sender == self.facebookBtn then
            self.loadingPanel:setVisible(true)
            self.buttonPanel:setVisible(false)
            self:readFbInfo()
        elseif sender == self.guestBtn then
            self.loadingPanel:setVisible(true)
            self.buttonPanel:setVisible(false)
            self:loginServer()
        end
    end
    self.facebookBtn:addTouchEventListener(onTouch)
    self.guestBtn:addTouchEventListener(onTouch)

    local function scheduleProgress(dt)
        if self.messageUI:isVisible() then
        	return
        end
        
        if false == self.loadingPanel:isVisible() then
            return
        end
        
        if self.loadingProgressBar:getPercent() < self.percent then
            self.loadingProgressBar:setPercent(self.loadingProgressBar:getPercent()+1)
            self.loadingPercentLabel:setString(self.loadingProgressBar:getPercent().."%")
        end
        
        self.dotIdx = self.dotIdx+0.1
        if self.dotIdx>=4 then
            self.dotIdx = 0
        end    
        local msgStr = self.messageStr
        for var=1, 4 do
            if var<self.dotIdx then
                msgStr = msgStr.."."
            else
                msgStr = msgStr.." "
            end
        end
        self.loadingMessageLabel:setString(msgStr)
        
        if self.loadingProgressBar:getPercent() >= 100 then
            tgScheduler:unscheduleScriptEntry(self.schedulerId)
            require("HallScene")
            tgEnterScene(createHall())
        end
    end
    self.schedulerId = tgScheduler:scheduleScriptFunc(scheduleProgress,0.01,false)
end

function LoginScene:loginServer()
    self.percent = 90
    self.messageStr = "Connect game server"

    local testUrl = nil
    local languageType = tgApplication:getCurrentLanguage()
    if languageType == cc.LANGUAGE_CHINESE then
        testUrl = "http://www.baidu.com"
    else
        testUrl = "http://www.google.com"
    end
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", testUrl)
    local function onReadyStateChange()
        if xhr.status == 200 then
            self.percent = 100
        else
            self.stateId = kTagLoginServer
            self.messageUI.messageLabel:setString("Connect game server failed!")
            self.messageUI:setVisible(true)
        end
    end
    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send()
end

function LoginScene:readFbInfo()
    self.percent = 60
    self.messageStr = "Reading Facebook Info"
    
    local testUrl = nil
    local languageType = tgApplication:getCurrentLanguage()
    if languageType == cc.LANGUAGE_CHINESE then
        testUrl = "http://www.baidu.com"
    else
        testUrl = "http://www.google.com"
    end
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", testUrl)
    local function onReadyStateChange()
        if xhr.status == 200 then
            self:loginServer()
        else
            self.stateId = kTagConnectFb
            self.messageUI.messageLabel:setString("Reading Facebook Info failed!")
            self.messageUI:setVisible(true)
        end
    end
    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send()
end

function LoginScene:checkInternet()
    self.percent = 30
    self.messageStr = "Checking Network"
    
    local testUrl = nil
    local languageType = tgApplication:getCurrentLanguage()
    if languageType == cc.LANGUAGE_CHINESE then
    	testUrl = "http://www.baidu.com"
    else
    	testUrl = "http://www.google.com"
    end
    local xhr = cc.XMLHttpRequest:new()
    xhr.responseType = cc.XMLHTTPREQUEST_RESPONSE_STRING
    xhr:open("GET", testUrl)
    local function onReadyStateChange()
        if xhr.status == 200 then
            if false then
                self:readFbInfo()
            else -- never connect fb
                self.loadingPanel:setVisible(false)
                self.buttonPanel:setVisible(true)                
            end
        else
            self.stateId = kTagCheckNetwork
            self.messageUI.messageLabel:setString("Checking Network failed!")
            self.messageUI:setVisible(true)
        end
    end
    xhr:registerScriptHandler(onReadyStateChange)
    xhr:send()
end

function LoginScene:create()
    local scene = LoginScene:new()
    scene.rootNode = tgSceneReader:createNodeWithSceneFile("LoginScene_1024x768.json")
    scene:addChild(scene.rootNode)
    scene:init()
    scene:checkInternet()
    return scene
end

function createLogin()
	return LoginScene:create()
end





