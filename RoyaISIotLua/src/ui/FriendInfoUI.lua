local FriendInfoUI = class("FriendInfoUI",function()
    return cc.LayerColor:create(cc.c4b(0,0,0,128))
end)

local kConfigFile = "FriendInfo_UI.json"

function FriendInfoUI:ctor()
    
end

function FriendInfoUI:init()
    local friendInfoBg = self.rootNode:getChildByName("FriendInfoBg")
    self.avatarDefault = friendInfoBg:getChildByName("AvatarDefault")
    self.onLine = friendInfoBg:getChildByName("OnLine")
    self.levelLabel = friendInfoBg:getChildByName("LevelLabel")
    self.nameLabel = friendInfoBg:getChildByName("NameLabel")
    self.inviteFriendsBtn = friendInfoBg:getChildByName("InviteFriendsBtn")
    self.sendGiftBtn = friendInfoBg:getChildByName("SendGiftBtn")
    self.chipsLabel = friendInfoBg:getChildByName("ChipsLabel")
    self.vipBtn = friendInfoBg:getChildByName("VipBtn")
    self.bestPlayersBtn = friendInfoBg:getChildByName("BestPlayersBtn")
    self.friendsBtn = friendInfoBg:getChildByName("FriendsBtn")
    self.closeBtn = friendInfoBg:getChildByName("CloseBtn")
    self.jackpotListView = friendInfoBg:getChildByName("JackpotListView")
    self.bigwinListView = friendInfoBg:getChildByName("BigwinListView")
    
    self.vipBtn:setEnabled(false)
    
    local function onTouch(sender, eventType)
        if eventType ~= ccui.TouchEventType.ended then
            return
        end
        if sender == self.closeBtn then
            self:removeFromParent(true)
        elseif sender == self.inviteFriendsBtn then
            cclog("inviteFriendsBtn")
        elseif sender == self.sendGiftBtn then
            cclog("sendGiftBtn")
        elseif sender == self.vipBtn then
            cclog("vipBtn")
        elseif sender == self.bestPlayersBtn then
            cclog("bestPlayersBtn")
        elseif sender == self.friendsBtn then
            cclog("friendsBtn")
        end
    end
    self.closeBtn:addTouchEventListener(onTouch)
    self.inviteFriendsBtn:addTouchEventListener(onTouch)
    self.sendGiftBtn:addTouchEventListener(onTouch)
    self.vipBtn:addTouchEventListener(onTouch)
    self.bestPlayersBtn:addTouchEventListener(onTouch)
    self.friendsBtn:addTouchEventListener(onTouch)
end

function FriendInfoUI:create()
    local messageUi = FriendInfoUI:new()
    messageUi.rootNode = tgGuiReader:widgetFromJsonFile(kConfigFile)
    messageUi:addChild(messageUi.rootNode)
    messageUi:init()
    return messageUi
end

function createFriendInfoUI()
    return FriendInfoUI:create()
end
