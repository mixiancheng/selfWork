local AvatarUI = class("AvatarUI",function()
    return cc.LayerColor:create(cc.c4b(0,0,0,128))
end)

local kConfigFile = "Avatar_UI.json"

function AvatarUI:ctor()

end

function AvatarUI:init()
    local changeAvatarBg = self.rootNode:getChildByName("ChangeAvatarBg")
    self.closeBtn = changeAvatarBg:getChildByName("CloseBtn")
    self.okBtn = changeAvatarBg:getChildByName("OkBtn")
    
    local function onTouch(sender, eventType)
        if eventType ~= ccui.TouchEventType.ended then
            return
        end
        if sender == self.closeBtn then
            self:removeFromParent(true)
        elseif sender == self.okBtn then
            cclog("ok")
        end
    end
    self.closeBtn:addTouchEventListener(onTouch)
    self.okBtn:addTouchEventListener(onTouch)
end

function AvatarUI:create()
    local messageUi = AvatarUI:new()
    messageUi.rootNode = tgGuiReader:widgetFromJsonFile(kConfigFile)
    messageUi:addChild(messageUi.rootNode)
    messageUi:init()
    return messageUi
end

function createAvatarUI()
    return AvatarUI:create()
end
