local MessageUI = class("MessageUI",function()
    return cc.LayerColor:create(cc.c4b(0,0,0,128))
end)

local kConfigFile = "Message_UI.json"

function MessageUI:ctor()
    
end

function MessageUI:init()
    local messageBg = self.rootNode:getChildByName("MsgBg")
    self.messageLabel = messageBg:getChildByName("MsgInfo")
    self.messageBtn = messageBg:getChildByName("MsgBtn")
    
    local function onTouch(sender, eventType)
        if eventType ~= ccui.TouchEventType.ended then
            return
        end
        if sender == self.messageBtn then
            self:removeFromParentAndCleanup()
            self.callback()
        end
    end
    self.messageBtn:addTouchEventListener(onTouch)
end

function MessageUI:create(callback)
    local messageUi = MessageUI:new()
    messageUi.callback = callback
    messageUi.rootNode = tgGuiReader:widgetFromJsonFile(kConfigFile)
    messageUi:addChild(messageUi.rootNode)
    messageUi:init()
    return messageUi
end

function createMessageUI(callback)
    return MessageUI:create(callback)
end
