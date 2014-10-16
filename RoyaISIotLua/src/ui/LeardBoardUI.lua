local LeardBoardUI = class("LeardBoardUI",function()
    return cc.LayerColor:create(cc.c4b(0,0,0,128))
end)

function LeardBoardUI:ctor()

end

function LeardBoardUI:init()
    self.rootNode:getChildByName("MsgBg")
end

function LeardBoardUI:create()
    local messageUi = LeardBoardUI:new()
    messageUi.rootNode = tgGuiReader:widgetFromJsonFile("LeardBoard_UI.json")
    messageUi:addChild(messageUi.rootNode)
    messageUi:init()
    return messageUi
end

function createLeardBoardUI()
    return LeardBoardUI:create()
end