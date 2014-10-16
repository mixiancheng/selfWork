local SettingUI = class("SettingUI",function()
    return cc.LayerColor:create(cc.c4b(0,0,0,128))
end)

function SettingUI:ctor()

end

function SettingUI:init()
    local settingBg = self.rootNode:getChildByName("SettingBg")
    self.closeBtn = settingBg:getChildByName("CloseBtn")
    self.notifyCheckBox = settingBg:getChildByName("NotifyCheckBox")
    self.musicCheckBox = settingBg:getChildByName("MusicCheckBox")
    self.soundCheckBox = settingBg:getChildByName("SoundCheckBox")
    self.rateBtn = settingBg:getChildByName("RateBtn")
    self.gameCenterBtn = settingBg:getChildByName("GameCenterBtn")
    self.serviceBtn = settingBg:getChildByName("ServiceBtn")
    self.facebookCheckBox = settingBg:getChildByName("FacebookCheckBox")
    self.uidLabel = settingBg:getChildByName("UidLabel")
    
    local function selectedEvent(sender,eventType)
        if sender == self.notifyCheckBox then
            if eventType == ccui.CheckBoxEventType.selected then
                cclog("Selected")
            elseif eventType == ccui.CheckBoxEventType.unselected then
                cclog("Unselected")
            end
        elseif sender == self.musicCheckBox then
            if eventType == ccui.CheckBoxEventType.selected then
                cclog("Selected")
            elseif eventType == ccui.CheckBoxEventType.unselected then
                cclog("Unselected")
            end
        elseif sender == self.soundCheckBox then
            if eventType == ccui.CheckBoxEventType.selected then
                cclog("Selected")
            elseif eventType == ccui.CheckBoxEventType.unselected then
                cclog("Unselected")
            end
        elseif sender == self.facebookCheckBox then
            if eventType == ccui.CheckBoxEventType.selected then
                cclog("Selected")
            elseif eventType == ccui.CheckBoxEventType.unselected then
                cclog("Unselected")
            end
        end
    end
    local function onTouch(sender, eventType)
        if eventType ~= ccui.TouchEventType.ended then
            return
        end
        if sender == self.closeBtn then
            self:removeFromParentAndCleanup()
        elseif sender == self.rateBtn then
            cclog("rate")
        elseif sender == self.gameCenterBtn then
            cclog("gameCenterBtn")
        elseif sender == self.serviceBtn then
            cclog("serviceBtn")
        end
    end
    self.closeBtn:addTouchEventListener(onTouch)
    self.notifyCheckBox:addEventListener(selectedEvent)
    self.musicCheckBox:addEventListener(selectedEvent)
    self.soundCheckBox:addEventListener(selectedEvent)
    self.rateBtn:addTouchEventListener(onTouch)
    self.gameCenterBtn:addTouchEventListener(onTouch)
    self.facebookCheckBox:addEventListener(selectedEvent)
    self.serviceBtn:addTouchEventListener(onTouch)
end

function SettingUI:create()
    local messageUi = SettingUI:new()
    messageUi.rootNode = tgGuiReader:widgetFromJsonFile("Setting_UI.json")
    messageUi:addChild(messageUi.rootNode)
    messageUi:init()
    return messageUi
end

function createSettingUI()
    return SettingUI:create()
end