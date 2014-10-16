local HallScene = class("HallScene", function()
    return cc.Scene:create()
end)

function HallScene:createMap()
    local layer = cc.Layer:create()
    local map = ccexp.TMXTiledMap:create("hall_map/Untitled.tmx", false)
    layer:addChild(map)
    local size = map:getContentSize()
    map:setPosition(0, 0)
    return layer
end

function HallScene:init()
    local uiNode = self.rootNode:getChildByTag(10004):getComponent("GUIComponent"):getNode()
    local topBg = uiNode:getChildByName("TopBg")
    self.avatarDefault = topBg:getChildByName("AvatarDefault")
    self.userInfoBtn = topBg:getChildByName("UserInfoBtn")
    self.chipsLabel = topBg:getChildByName("getChildByName")
    self.expProgressBar = topBg:getChildByName("ExpProgressBar")
    self.levelLabel = topBg:getChildByName("LevelBg"):getChildByName("LevelLabel")
    self.giftBtn = topBg:getChildByName("GiftBtn")
    self.giftBtnNew = self.giftBtn:getChildByName("GiftBtnNew")
    self.freeCoinBtn = topBg:getChildByName("FreeCoinBtn")
    self.settingBtn = topBg:getChildByName("SettingBtn")
    self.buyCoinBtn = topBg:getChildByName("BuyCoinBtn")
    
    local bottomBg = uiNode:getChildByName("BottomBg")
    self.sbProgressBar = bottomBg:getChildByName("SbProgressBar")
    self.sbCollectBtn = bottomBg:getChildByName("SbCollectBtn")
    self.sbTimeLabel = bottomBg:getChildByName("SbTimeLabel")
    self.leardBoardBtn = bottomBg:getChildByName("LeardBoardBtn")
    self.hideBottomBtn = bottomBg:getChildByName("HideBottomBtn")
    self.showBottomBtn = bottomBg:getChildByName("ShowBottomBtn")
    self.friendsPanel = bottomBg:getChildByName("FriendsPanel")
    self.left1Btn = self.friendsPanel:getChildByName("Left1Btn")
    self.left2Btn = self.friendsPanel:getChildByName("Left2Btn")
    self.right1Btn = self.friendsPanel:getChildByName("Right1Btn")
    self.right2Btn = self.friendsPanel:getChildByName("Right2Btn")
    self.inviteFriendsBtn = self.friendsPanel:getChildByName("InviteFriendsBtn")
    self.friendListView = self.friendsPanel:getChildByName("FriendListView")
    self.loadingPanel = bottomBg:getChildByName("LoadingPanel")
    self.loadingLabel = self.loadingPanel:getChildByName("LoadingLabel")
    self.connectFbPanel = bottomBg:getChildByName("ConnectFbPanel")
    self.facebookBtn = self.connectFbPanel:getChildByName("FacebookBtn")
    
    self:addChild(self:createMap())
    
    local function onTouch(sender, eventType)
        if eventType ~= ccui.TouchEventType.ended then
            return
        end
        if sender == self.userInfoBtn then
            require("UserInfoUI")
            self.userInfoUI = createUserInfoUI()
            self:addChild(self.userInfoUI, 1)
        elseif sender == self.giftBtn then
            require("GiftUI")
            self.giftUI = createGiftUI()
            self:addChild(self.giftUI, 1)
        elseif sender == self.freeCoinBtn then
            cclog("freeCoinBtn")
        elseif sender == self.settingBtn then
            require("SettingUI")
            self.settingUI = createSettingUI()
            self:addChild(self.settingUI, 1)
        elseif sender == self.buyCoinBtn then
            cclog("buyCoinBtn")
        elseif sender == self.sbCollectBtn then
            cclog("sbCollectBtn")
        elseif sender == self.leardBoardBtn then
            require("LeardBoardUI")
            self.leardBoardUI = createLeardBoardUI()
            self:addChild(self.leardBoardUI, 1)
        elseif sender == self.hideBottomBtn then
            cclog("hideBottomBtn")
        elseif sender == self.showBottomBtn then
            cclog("showBottomBtn")
        elseif sender == self.left1Btn then
            cclog("left1Btn")
        elseif sender == self.left2Btn then
            cclog("left2Btn")
        elseif sender == self.right1Btn then
            cclog("right1Btn")
        elseif sender == self.right2Btn then
            cclog("right2Btn")
        elseif sender == self.inviteFriendsBtn then
            cclog("inviteFriendsBtn")
        elseif sender == self.facebookBtn then
            cclog("facebookBtn")
        end
    end
    self.userInfoBtn:addTouchEventListener(onTouch)
    self.giftBtn:addTouchEventListener(onTouch)
    self.freeCoinBtn:addTouchEventListener(onTouch)
    self.settingBtn:addTouchEventListener(onTouch)
    self.buyCoinBtn:addTouchEventListener(onTouch)
    self.sbCollectBtn:addTouchEventListener(onTouch)
    self.leardBoardBtn:addTouchEventListener(onTouch)
    self.hideBottomBtn:addTouchEventListener(onTouch)
    self.showBottomBtn:addTouchEventListener(onTouch)
    self.left1Btn:addTouchEventListener(onTouch)
    self.left2Btn:addTouchEventListener(onTouch)
    self.right1Btn:addTouchEventListener(onTouch)
    self.right2Btn:addTouchEventListener(onTouch)
    self.inviteFriendsBtn:addTouchEventListener(onTouch)
    self.facebookBtn:addTouchEventListener(onTouch)
end

function HallScene:create()
    local scene = HallScene:new()
    scene.rootNode = tgSceneReader:createNodeWithSceneFile("HallScene_1024x768.json")
    scene:addChild(scene.rootNode)
    scene:init()
    return scene
end

function createHall()
    return HallScene:create()
end

