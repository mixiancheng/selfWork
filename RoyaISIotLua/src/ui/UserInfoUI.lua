local UserInfoUI = class("UserInfoUI",function()
    return cc.LayerColor:create(cc.c4b(0,0,0,128))
end)

local kConfigFile = "UserInfo_UI.json"

function UserInfoUI:ctor()
    
end

function UserInfoUI:init()
    local userInfoBg = self.rootNode:getChildByName("UserInfoBg")
    self.closeBtn = userInfoBg:getChildByName("CloseBtn")
    self.avatarDefault = userInfoBg:getChildByName("AvatarDefault")
    self.userIdLabel = userInfoBg:getChildByName("UserIdLabel")
    self.userNameLabel = userInfoBg:getChildByName("UserNameLabel")
    self.changeAvatarBtn = userInfoBg:getChildByName("ChangeAvatarBtn")
    self.leftExpLabel = userInfoBg:getChildByName("LeftExpLabel")
    self.expProgressBar = userInfoBg:getChildByName("ExpProgressBar")
    self.currentExpLabel = userInfoBg:getChildByName("CurrentExpLabel")
    self.levelLabel = userInfoBg:getChildByName("LevelBg"):getChildByName("LevelLabel")
    self.chipsLabel = userInfoBg:getChildByName("ChipsLabel")
    self.vipBtn = userInfoBg:getChildByName("VipBtn")
    self.bestPlayersBtn = userInfoBg:getChildByName("BestPlayersBtn")
    self.friendsBtn = userInfoBg:getChildByName("FriendsBtn")
    self.jackpotListView = userInfoBg:getChildByName("JackpotListView")
    self.bigwinListView = userInfoBg:getChildByName("BigwinListView")

    self.vipBtn:setEnabled(false)
    
    local function onTouch(sender, eventType)
        if eventType ~= ccui.TouchEventType.ended then
            return
        end
        if sender == self.closeBtn then
            self:removeFromParent(true)
        elseif sender == self.changeAvatarBtn then
            cclog("change avatar")
        elseif sender == self.vipBtn then
            cclog("vip")
        elseif sender == self.bestPlayersBtn then
            cclog("best players")
        elseif sender == self.friendsBtn then
            cclog("friends")
        end
    end
    self.closeBtn:addTouchEventListener(onTouch)
    self.changeAvatarBtn:addTouchEventListener(onTouch)
    self.vipBtn:addTouchEventListener(onTouch)
    self.bestPlayersBtn:addTouchEventListener(onTouch)
    self.friendsBtn:addTouchEventListener(onTouch)
end

function UserInfoUI:create()
    local userInfoUi = UserInfoUI:new()
    userInfoUi.rootNode = tgGuiReader:widgetFromJsonFile(kConfigFile)
    userInfoUi:addChild(userInfoUi.rootNode)
    userInfoUi:init()
    return userInfoUi
end

function createUserInfoUI()
    return UserInfoUI:create()
end